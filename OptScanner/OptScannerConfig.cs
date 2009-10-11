using System.Collections.Generic;
using System;
using System.Xml;
using System.IO;

namespace OptScanner
{
	public class Matrix
	{
		public float[,] Matr { get; set; }
		public List<string> ss { get; set; } 

		public Matrix(string s)
		{
			ss = new List<string>(s.Split("\r\n".ToCharArray()));
			while (ss.Contains(string.Empty))
				ss.Remove(string.Empty);

			List<List<string>> result = new List<List<string>>();
			int imax = 0;
			foreach (string sss in ss)
			{
				string ssss = sss;
				var item = new List<string>();
				while (ssss.Length >= 6)
				{
					item.Add(ssss.Substring(0, 6));
					ssss = ssss.Substring(6);
				}
				if (ssss.Length > 0)
					item.Add(ssss);

				imax = imax > item.Count
								? imax
								: item.Count;
				result.Add(item);
			}

			Matr = new float[result.Count, imax];
			for(int i = 0; i < result.Count; i++)
				for (int j = 0; j < imax; j++)
				{
					float f;
					if (result[i].Count > j 
						&& float.TryParse(result[i][j].Trim(), 
												System.Globalization.NumberStyles.Any, 
												System.Globalization.CultureInfo.InvariantCulture , 
												out f))
						Matr[i, j] = f;
				}
		}

		public string GetHtmlTable()
		{
			var Result = "<table class='Matrix'>" + Environment.NewLine;
			for(int i = 0; i<= Matr.GetUpperBound(0);i++)
			{
				Result+="<tr>";
				for (int j = 0; j <= Matr.GetUpperBound(1); j++)
					Result += "<td>" + Matr[i, j] + "</td>";
				Result += "</tr>" + Environment.NewLine;
			}
			return Result + "</table>" + Environment.NewLine;
		}
	}
	public enum ActionType
	{
		Ask,
		Say,
		Matrix,
		TextParam,
	}
	public class ScanAction
	{
		public ActionType Type { get; set; }
		public string Text { get; set; }
		public string Result { get; set; }
		public string Identity { get; set; }
		public Matrix Matrix { get; set; }

		public void Do(ComPort _ComPort)
		{
			switch (Type)
			{ 
				case ActionType.Ask:
					Result = _ComPort.Ask(Text);
					break;
				case ActionType.Matrix:
					Result = _ComPort.Ask(Text);
					Matrix = new Matrix(Result);
					break;
				case ActionType.Say:
					_ComPort.Say(Text);
					break;
				default:
					break;
			}
		}

		public string GetResult()
		{
			if (Type != ActionType.Matrix)
				return Result ?? "";
			return Matrix.GetHtmlTable();
		}
	}
	public class ScanMethod:List<ScanAction>
	{
		private ComPort _ComPort;
		public string MethodName { get; set; }
		public string MethodId { get; set; }

		public ScanAction this[string identity]
		{
			get
			{
				return Find((a) => a.Identity == identity);
			}

		}

		public ScanMethod()
		{
			AddRange(new[]
				{
					new ScanAction
					{
						Type = ActionType.TextParam,
						Identity = "UserName",
					},
					new ScanAction
					{
						Type = ActionType.TextParam,
						Identity = "MethodName",
					},
					new ScanAction
					{
						Type = ActionType.TextParam,
						Identity = "MethodId",
					},
					new ScanAction
					{
						Type = ActionType.TextParam,
						Identity = "CurrentTime",
					},
					new ScanAction
					{
						Type = ActionType.TextParam,
						Identity = "Description",
					},
				});

		}

		public void Init(ComPort comPort, string userName)
		{
			_ComPort = comPort;
			this["UserName"].Result = userName;
			this["MethodName"].Result = MethodName;
			this["MethodId"].Result = MethodId;
			this["CurrentTime"].Result = DateTime.Now.ToString();
		}

		public void Do()
		{
			foreach (var action in this)
				action.Do(_ComPort);
			string s = _ComPort.ReadExisting();
			if (!string.IsNullOrEmpty(s))
				Add(new ScanAction { Type = ActionType.TextParam, Result = s, Identity = "LastString" });

		}

		public override string ToString()
		{
			return MethodName;
		}


		public string GetXml()
		{
			return XmlMapper.AppendXml(this, "ScanMethod", (new XmlDocument()).CreateElement("Root")).OuterXml.Replace(">", ">" + Environment.NewLine);
		}

		public string GetVarMatrixes()
		{
			string result = "["+Environment.NewLine;
			foreach (var item in this)
			{
				if (item.Matrix == null)
					continue;
				result += "		[" + Environment.NewLine;
				for (int i = 0; i <= item.Matrix.Matr.GetUpperBound(0); i++)
				{
					result += "			[" ;
					for (int j = 0; j <= item.Matrix.Matr.GetUpperBound(1); j++)
						result += (int)(item.Matrix.Matr[i, j] * 1000 + 0.5) + "/1000,";
					result += "]," + Environment.NewLine;
				}
				result += "		]," + Environment.NewLine;
			}
			return result + "]" + Environment.NewLine;
		}
		
	}
	public class HtmlFormatter
	{
		public string Html { get; set; }

		public string Do(ScanMethod sm)
		{
			var s = sm.GetXml();
			return "<!--" + s + "-->" + Environment.NewLine + Replace(Html, sm);

			/*
			 - <ScanMethod MethodName="Простейшее измерение" MethodId="Simple1" Capacity="16" Count="10">
			  <this Type="TextParam" Result="Лелик" Identity="UserName" /> 
			  <this Type="TextParam" Result="Простейшее измерение" Identity="MethodName" /> 
			  <this Type="TextParam" Result="Simple1" Identity="MethodId" /> 
			  <this Type="Say" Text="R" /> 
			  <this Type="Ask" Text="T" Result="ty" Identity="Time" /> 
			  <this Type="Say" Text="E0" /> 
			  <this Type="Say" Text="F1" /> 
			  <this Type="Say" Text="F1" /> 
			- <this Type="Matrix" Text="P" Result="0.016 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.188 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.003 0.181 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.003 2.967 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.002 0.025 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.031 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.043 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.053 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003">
			- <Matrix>
			- <ss Capacity="9" Count="8">
			  <this Value="0.016 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.002" /> 
			  <this Value="0.188 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.003" /> 
			  <this Value="0.181 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.003" /> 
			  <this Value="2.967 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003 0.002" /> 
			  <this Value="0.025 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002" /> 
			  <this Value="0.031 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002 0.003" /> 
			  <this Value="0.043 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.002" /> 
			  <this Value="0.053 0.001 0.001 0.001 0.001 0.002 0.002 0.002 0.002 0.002 0.002 0.003" /> 
			  </ss>
			  </Matrix>
			  </this>
			  <this Type="Say" Text="Q" /> 
			  </ScanMethod>
			 */
		}

		private string Replace(string str, ScanMethod sm)
		{
			string VarMatrixes = "VarMatrixes";
			string identities = "<!-- Identities:" + Environment.NewLine;
			identities += VarMatrixes + Environment.NewLine;
			foreach (var item in sm)
			{
				if (item.Identity != null)
				{
					identities += item.Identity + Environment.NewLine;
					str = str.Replace("%%" + item.Identity + "%%", item.GetResult());
				}
			}
			str = str.Replace("%%" + VarMatrixes + "%%", sm.GetVarMatrixes());
			return str + Environment.NewLine + identities+"-->";
		}
	}

	public class PathFormatter
	{ 
		public string Source { get; set; }
		public string Extension { get; set; }
		public string BaseFolder { get; set; }
		public string Format { get; set; }


		public string GetPath(ScanMethod sm)
		{
			DateTime result = DateTime.Now;
			if(!DateTime.TryParse(sm[Source].Result, out result))
				DateTime.TryParse(sm["CurrentTime"].Result, out result);
			return BaseFolder + result.ToString(Format) + Extension;
		}
	}
	public class OptScannerWork : List<ScanMethod>
	{
		public string ReaderName { get; set; }
		public ComPort ComPort { get; set; }
		string _Path;

		public HtmlFormatter HtmlFormatter { get; set; }
		public PathFormatter PathFormatter { get; set; }
		public void Init(System.Windows.Forms.Control control)
		{
			ComPort.Init(control);
			if (Users == null || Users.Count == 0)
				Users = new List<string> { "Гость" };

		}
		public string Do(ScanMethod sm, string userName)
		{
			sm.Init(ComPort, userName);
			sm.Do();
			_Path = PathFormatter.GetPath(sm);
			return FileSave(HtmlFormatter.Do(sm));
		}
		
		private string FileSave(string html)
		{
			if (!Directory.Exists(Path.GetDirectoryName(_Path)))
				Directory.CreateDirectory(Path.GetDirectoryName(_Path));
			try
			{
				File.WriteAllText(_Path, html);
			}
			catch(Exception exc)
			{
				System.Windows.Forms.MessageBox.Show(exc.Message, "ошибка", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
			}
			return _Path;
		}
		public string ChangeDescription(ScanMethod sm, string Description)
		{
			sm["Description"].Result = Description;
			return FileSave(HtmlFormatter.Do(sm));
		}

		public List<string> Users { get; set; }
	}
}
