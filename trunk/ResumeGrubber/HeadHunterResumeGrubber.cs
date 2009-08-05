using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Xml;
using log4net;
using log4net.Config;

namespace HeadHunterResumeGrubber
{
	internal class HeadHunterResumeGrubber
	{
		public static Random rnd = new Random( unchecked( (int)DateTime.Now.Ticks ) );
		public static AutoResetEvent[] eventList = null;

		private static Mutex mutexGetResumeId = new Mutex();
		private static SortedList resumeList = new SortedList();
		private static Dictionary<int,string> resumeLinkList = new Dictionary<int, string>();

		private static IEnumerator resumeEnumerator = null;
		private static IList threadList = new ArrayList();
		private static byte daysCount = 1;

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[ MTAThread ]
		private static void Main( string[] args )
		{
			AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler( UnhandledExceptionHandler );
			AppDomain.CurrentDomain.ProcessExit += new EventHandler( ApplicationExitHandler );
			if( args.Length > 0 )
			{
				try
				{
					if( args[ 0 ].StartsWith( @"/" ) )
					{
						args[ 0 ] = args[ 0 ].Substring( 1 );
					}
					daysCount = Byte.Parse( args[ 0 ] );
					if( daysCount != 1 && daysCount != 3 && daysCount != 7 )
					{
						throw new ArgumentOutOfRangeException();
					}
					if( File.Exists( Config.RESUME_LIST_FILE ) )
					{
						File.Delete( Config.RESUME_LIST_FILE );
					}
				}
				catch
				{
					Console.Write( "You can use only the 1, 3 and 7 value as a program parameter.\nPress the Enter key" );
					Console.Read();
					return;
				}
			}
			GetResumeList();
			if( resumeList.Count > 0 )
			{
				StartThreads();
				Thread.Sleep( 1000 );
				WaitHandle.WaitAll( eventList );
			}
		}

		private static void UnhandledExceptionHandler( object sender, UnhandledExceptionEventArgs args )
		{
			Config.FileLog.Fatal( "Unhandled error", (Exception)( args.ExceptionObject ) );
		}

		private static void ApplicationExitHandler( object sender, EventArgs e )
		{
			if( resumeList != null && resumeList.Count == 0 && File.Exists( Config.RESUME_LIST_FILE ) )
			{
				File.Delete( Config.RESUME_LIST_FILE );
			}
			if( !Config.LastProcessedResumeTimestamp.Equals( DateTime.MinValue ) )
			{
				using( StreamWriter writeStream = new StreamWriter( Config.LAST_PROCESSED_DATETIME_FILE, false, Encoding.UTF8 ) )
				{
					writeStream.WriteLine( Config.LastProcessedResumeTimestamp );
				}
			}
		}

		private static void StartThreads()
		{
			resumeEnumerator = resumeList.GetEnumerator();
			resumeEnumerator.Reset();
			eventList = new AutoResetEvent[Config.SessionCount];
			for( int i = 0; i < Config.SessionCount; i++ )
			{
				eventList[ i ] = new AutoResetEvent( false );
				ResumeGrubber grubber = new ResumeGrubber( i );
				Thread grubberThread = new Thread( new ThreadStart( grubber.ThreadStart ) );
				threadList.Add( grubberThread );
				grubberThread.Start();
			}
		}

		public static int GetResumeId()
		{
			mutexGetResumeId.WaitOne();
			try
			{
				resumeEnumerator.MoveNext();
				DictionaryEntry item = (DictionaryEntry)resumeEnumerator.Current;
				Config.LastProcessedResumeTimestamp = (DateTime)item.Key;
				return (int)item.Value;
			}
			finally
			{
				mutexGetResumeId.ReleaseMutex();
			}
		}

		public static void WriteResumeToFile( int resumeId, Stream content )
		{
			string fileName = String.Format( Config.ResumeFilePattern, resumeId );
/*
			for( int i = 1; File.Exists( fileName ); i++ )
			{
				fileName = String.Format( Config.ResumeFilePattern, resumeId + "_" + i );
			}
*/
			try
			{
				using(FileStream fs = new FileStream(fileName, FileMode.Create,FileAccess.Write))
				{
					using (BinaryReader readStream = new BinaryReader(content))
				   {
				      Byte[] read = new Byte[256];
				      int count;
				      while( ( count = readStream.Read( read, 0, 256 ) ) > 0 )
				      {
				         //writeStream.Write( new String( read, 0, count ) );
							fs.Write(read,0,count);
				      }
				   }
					
				}
				//using( StreamWriter writeStream = new StreamWriter( fileName, false, Encoding.ASCII ) )
				//{
				//   using( StreamReader readStream = new StreamReader( content, Encoding.ASCII ) )
				//   {
				//      Char[] read = new Char[256];
				//      int count;
				//      while( ( count = readStream.Read( read, 0, 256 ) ) > 0 )
				//      {
				//         writeStream.Write( new String( read, 0, count ) );
				//      }
				//   }
				//}
			}
			catch( Exception ex )
			{
				Config.FileLog.Error( "Cannot write the file: '" + fileName + "'. Details: " + ex.Message );
			}
		}

		public static Stream GetResumeFromWeb( int resumeId )
		{
			Stream content = null;
			while( content == null )
			{
				User user = null;
				try
				{
					user = (User)Config.UserList[ rnd.Next( 0, Config.UserList.Count ) ];
					Config.ConsoleLog.Info( String.Format( "Process the resume id: '{0}', login: '{1}'", resumeId, user.Login ) );
					string link = Config.UseRssLink.ToUpper() == "TRUE"
					              	? resumeLinkList[resumeId]
					              	: String.Format(Config.GET_RESUME_URI, resumeId);

					content = GetFromWeb(link, user);
				}
				catch( UnauthorizedUserException )
				{
					Config.FileLog.Warn( "The user '" + user.Login + "' cannot be authorized" );
					lock( Config.UserList )
					{
						Config.UserList.Remove( user );
					}
					if( Config.UserList.Count < 1 )
					{
						Config.FileLog.Warn( "No available authorized user logins" );
						throw;
					}
				}
			}
			return content;
		}

		private static void GetResumeList()
		{
			bool xPathIdNotFound = false,
			     xPathPubDateNotFound = false,
			     cannotExtractDate = false,
				  xPathLinkNotFound = false;
			try
			{
				XmlDocument xmlDoc = new XmlDocument();
				try
				{
					xmlDoc.Load( Config.RESUME_LIST_FILE );
				}
				catch
				{
					User user = (User)Config.UserList[ rnd.Next( 0, Config.UserList.Count ) ];
					Config.ConsoleLog.Info( String.Format( "Getting the resume list with the login: '{0}'", user.Login ) );
//					xmlDoc.Load( GetFromWeb( String.Format( Config.GET_RESUME_LIST_URI, daysCount * 10000, daysCount ), user ) );
					xmlDoc.Load( GetFromWeb( String.Format( Config.GET_RESUME_LIST_URI, Config.MaxResumeCountInList, daysCount ), user ) );
					xmlDoc.Save( Config.RESUME_LIST_FILE );
				}
				XmlNodeList itemNodeList = xmlDoc.SelectNodes(Config.xPathItem);//"/rss/channel/item");
				if (itemNodeList == null)
				{
					Config.FileLog.Warn("Cannot find xPathItem");
					return;
				}

				for( int i = itemNodeList.Count - 1; i >= 0 && resumeList.Count < Config.TotalResumeCount; i-- )
				{
					XmlNode itemNode = itemNodeList.Item( i );
					XmlNode pubDateNode = itemNode.SelectSingleNode(Config.xPathPubDate);//"pubDate");
					if (pubDateNode == null)
					{
						if (!xPathPubDateNotFound)
							Config.FileLog.Warn("Cannot find xPathPubDate");
						xPathPubDateNotFound = true;
						continue;
					}

					DateTime pubDate;
					if(!
						DateTime.TryParseExact( pubDateNode.InnerText.Replace( " (MSD)", "" ), Config.DateFormat,//"ddd, dd MMM yyyy H:mm:ss zzz",
													CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal, out pubDate))
					{
						if (!cannotExtractDate)
							Config.FileLog.Warn("Cannot extract date");
						cannotExtractDate = true;
						continue;
						
					}
					XmlNode linkNode = itemNode.SelectSingleNode(Config.xPathLink);//"pubDate");
					if (linkNode == null)
					{
						if (!xPathLinkNotFound)
							Config.FileLog.Warn("Cannot find xPathLink");
						xPathLinkNotFound = true;
						continue;
					}

					XmlNode idNode = itemNode.SelectSingleNode(Config.xPathId);//"id");
					if (idNode == null)
					{
						if (!xPathIdNotFound)
							Config.FileLog.Warn("Cannot find xPathId");
						xPathIdNotFound = true;
						continue;
					}
					if( pubDate > Config.LastProcessedResumeTimestamp )
					{
						while( resumeList.ContainsKey( pubDate ) )
						{
							pubDate = pubDate.AddMilliseconds( 1 );
						}
						string id = Regex.Match(idNode.InnerText, Config.xPathIdRegex).Groups["result"].ToString();

						resumeList.Add(pubDate, Convert.ToInt32(id));
						resumeLinkList[Convert.ToInt32(id)] = linkNode.InnerText;
					}
				}
			}
			catch( UnauthorizedUserException ex )
			{
				Config.FileLog.Warn( "The user '" + ex.User.Login + "' cannot be authorized" );
			}
			catch( WebException ex )
			{
				Config.FileLog.Error( "Cannot get a resume list. Error details: " + ex.Message );
			}
		}

		public static Stream GetFromWeb( string requestUri, User user )
		{
			Stream result;
			CredentialCache myCredentialCache = new CredentialCache();
			myCredentialCache.Add( new Uri( Config.URI ), "Basic", new NetworkCredential( user.Login, user.Password ) );
			int count = 0;
			while( true )
			{
				try
				{
					HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create( requestUri );
					httpWebRequest.PreAuthenticate = true;
					httpWebRequest.Credentials = myCredentialCache;
					httpWebRequest.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)";
					httpWebRequest.Accept = "text/html";
					httpWebRequest.Headers.Add( "Accept-Language", "ru" );
					result = httpWebRequest.GetResponse().GetResponseStream();
					break;
				}
				catch( WebException ex )
				{
					if( ex.Status == WebExceptionStatus.ProtocolError &&
					    ( ex.Response as HttpWebResponse ).StatusCode == HttpStatusCode.Unauthorized )
					{
						throw new UnauthorizedUserException( user );
					}
					else
					{
						if( count < Config.AttemptHttpRequestCount )
						{
							count++;
						}
						else
						{
							throw;
						}
					}
				}
			}
			return result;
		}
	}

	internal class Config
	{
		public const string LAST_PROCESSED_DATETIME_FILE = "last_processed_time";
		public const string RESUME_LIST_FILE = "resume_list.xml";

		public static readonly int AttemptHttpRequestCount = 5;
		public static readonly int MaxResumeCountInList = 500;
		public static readonly string ResumeFilePattern = "{0}.html";
		public static readonly int TotalResumeCount = 100;
		public static readonly ArrayList UserList = new ArrayList();
		public static readonly int SessionCount = 5;
		public static readonly TimeSpan SessionDelayMin = new TimeSpan( 0, 0, 0, 0, 500 );
		public static readonly TimeSpan SessionDelayMax = new TimeSpan( 0, 0, 0, 3, 0 );
		public static readonly ILog FileLog = LogManager.GetLogger( "FileLog" );
		public static readonly ILog ConsoleLog = LogManager.GetLogger( "ConsoleLog" );

		public static DateTime LastProcessedResumeTimestamp = DateTime.MinValue;

		//StringConstants
		public static string xPathPubDate = "pubDate";
		public static string xPathItem = "/rss/channel/item";
		public static string DateFormat = "ddd, dd MMM yyyy H:mm:ss zzz";
		public static string xPathId = "id";
		public static string xPathIdRegex = "(?<result>.*)";
		public static string xPathLink = "link";
		public static string UseRssLink = "true";

		public static string URI = "http://hh.ru/";
		public static string GET_RESUME_LIST_URI = "http://hh.ru/employer/resumesSearch.do?itemsOnPage={0}&areaId=113&professionalAreaId=0&keyword1=&allFields=true&salaryFrom=0&salaryTo=0&gender=&includeNoGender=10&ageFrom=0&ageTo=0&includeNoAge=10&educationId=0&englishLevel=0&frenchLevel=0&germanLevel=0&additionalLanguageLevel=0&additionalLanguageId=0&searchPeriod={1}&orderBy=2&actionSearch=actionSearch&showRss=1&basicLogin=1";
		public static string GET_RESUME_URI = "http://hh.ru/resume.do?id={0}&baseLogin=1";

		static Config()
		{
			DOMConfigurator.Configure();
			try
			{
				AttemptHttpRequestCount = Convert.ToInt32(ConfigurationSettings.AppSettings["AttemptHttpRequestCount"]);
			}
			catch{}
			try
			{
				MaxResumeCountInList = Convert.ToInt32(ConfigurationSettings.AppSettings["MaxResumeCountInList"]);
			}
			catch { }
			IDictionary resumes = (IDictionary)ConfigurationSettings.GetConfig("Resumes");
			try
			{
				ResumeFilePattern = resumes["filePattern"].ToString();
			}
			catch { }
			try
			{
				TotalResumeCount = Convert.ToInt32(resumes["count"]);
			}
			catch { }
			Hashtable StringConstants = (Hashtable)ConfigurationSettings.GetConfig("StringConstants");
			try
			{
				xPathPubDate = StringConstants["xPathPubDate"].ToString();
			}
			catch { }
			try
			{
				xPathItem = StringConstants["xPathItem"].ToString();
			}
			catch { }
			try
			{
				DateFormat = StringConstants["DateFormat"].ToString();
			}
			catch { }
			try
			{
				xPathId = StringConstants["xPathId"].ToString();
			}
			catch { }
			try
			{
				xPathIdRegex = StringConstants["xPathIdRegex"].ToString();
			}
			catch { }
			try
			{
				URI = StringConstants["URI"].ToString();
			}
			catch { }
			try
			{
				GET_RESUME_LIST_URI = StringConstants["GET_RESUME_LIST_URI"].ToString();
			}
			catch { }
			try
			{
				GET_RESUME_URI = StringConstants["GET_RESUME_URI"].ToString();
			}
			catch { }
			try
			{
				xPathLink = StringConstants["xPathLink"].ToString();
			}
			catch { }
			try
			{
				UseRssLink = StringConstants["UseRssLink"].ToString();
			}
			catch { }


			Hashtable loginList = (Hashtable)ConfigurationSettings.GetConfig("Logins");
			foreach( string key in loginList.Keys )
			{
				string password = loginList[ key ].ToString();
				if( password == null || password == "" )
				{
					throw new ConfigurationException( "Password cannot be empty" );
				}
				User user = new User( key, password );
				UserList.Add( user );
			}
			if( loginList.Count < 1 )
			{
				throw new ConfigurationException( "Empty the user login list" );
			}
			IDictionary sessions = (IDictionary)ConfigurationSettings.GetConfig( "Sessions" );
			try
			{
				SessionCount = Convert.ToInt32( sessions[ "count" ] );
			}
			catch
			{
			}
			try
			{
				SessionDelayMin = TimeSpan.Parse( sessions[ "delayMin" ].ToString() );
			}
			catch
			{
			}
			try
			{
				SessionDelayMax = TimeSpan.Parse( sessions[ "delayMax" ].ToString() );
			}
			catch
			{
			}
			if( SessionDelayMin > SessionDelayMax )
			{
				throw new ConfigurationException( "The session delay max value must be greater than or equal to min value" );
			}
			try
			{
				using( StreamReader readStream = new StreamReader( LAST_PROCESSED_DATETIME_FILE, Encoding.UTF8 ) )
				{
					LastProcessedResumeTimestamp = DateTime.Parse( readStream.ReadLine() );
				}
			}
			catch
			{
			}
		}
	}

	internal class User
	{
		public string Login = "";
		public string Password = "";

		public User( string login, string password )
		{
			Login = login;
			Password = password;
		}
	}

	internal class UnauthorizedUserException: Exception
	{
		public readonly User User;

		public UnauthorizedUserException(): base()
		{
		}

		public UnauthorizedUserException( User user ): base()
		{
			User = user;
		}

		public UnauthorizedUserException( string message ): base( message )
		{
		}

		public UnauthorizedUserException( string message, User user ): base( message )
		{
			User = user;
		}

		public UnauthorizedUserException( string message, Exception innerException ): base( message, innerException )
		{
		}

		public UnauthorizedUserException( string message, Exception innerException, User user )
			: base( message, innerException )
		{
			User = user;
		}
	}

	internal class ResumeGrubber
	{
		private int number;

		public ResumeGrubber( int number )
		{
			this.number = number;
		}

		public void ThreadStart()
		{
			while( true )
			{
				Thread.Sleep(
					new TimeSpan( Config.SessionDelayMin.Ticks +
					              HeadHunterResumeGrubber.rnd.Next( 0,
					                                                (int)
					                                                ( Config.SessionDelayMax.Subtract( Config.SessionDelayMin ).Ticks ) ) ) );
				int resumeId = int.MinValue;
				try
				{
					resumeId = HeadHunterResumeGrubber.GetResumeId();
					HeadHunterResumeGrubber.WriteResumeToFile( resumeId, HeadHunterResumeGrubber.GetResumeFromWeb( resumeId ) );
				}
				catch( WebException ex )
				{
					Config.FileLog.Error( "Error while getting the resume id=" + resumeId, ex );
					break;
				}
				catch( ThreadAbortException )
				{
					Thread.ResetAbort();
					break;
				}
				catch( InvalidOperationException )
				{
					break;
				}
				catch( Exception ex )
				{
					Config.FileLog.Error( "Error while getting the resume id=" + resumeId, ex );
				}
			}
			HeadHunterResumeGrubber.eventList[ number ].Set();
		}
	}
}