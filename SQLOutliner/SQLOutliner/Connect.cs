using System;
using System.Collections.Generic;
using System.Windows.Forms;
using Extensibility;
using EnvDTE;
using EnvDTE80;
using Microsoft.VisualStudio.CommandBars;
using System.Resources;
using System.Reflection;
using System.Globalization;

namespace SQL_Outliner
{
	/// <summary>The object for implementing an Add-in.</summary>
	/// <seealso class='IDTExtensibility2' />
	public class Connect : IDTExtensibility2, IDTCommandTarget
	{
		/// <summary>Implements the constructor for the Add-in object. Place your initialization code within this method.</summary>
		public Connect()
		{
		}

		/// <summary>Implements the OnConnection method of the IDTExtensibility2 interface. Receives notification that the Add-in is being loaded.</summary>
		/// <param term='application'>Root object of the host application.</param>
		/// <param term='connectMode'>Describes how the Add-in is being loaded.</param>
		/// <param term='addInInst'>Object representing this Add-in.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnConnection(object application, ext_ConnectMode connectMode, object addInInst, ref Array custom)
		{
			_applicationObject = (DTE2)application;
			_addInInstance = (AddIn)addInInst;
         //if (connectMode == ext_ConnectMode.ext_cm_UISetup) //ext_cm_Setup
			{
				object []contextGUIDS = new object[] { };
				Commands2 commands = (Commands2)_applicationObject.Commands;
				string toolsMenuName;

				try
				{
					//If you would like to move the command to a different menu, change the word "Tools" to the 
					//  English version of the menu. This code will take the culture, append on the name of the menu
					//  then add the command to that menu. You can find a list of all the top-level menus in the file
					//  CommandBar.resx.
					ResourceManager resourceManager = new ResourceManager("SQL_Outliner.CommandBar", Assembly.GetExecutingAssembly());
					CultureInfo cultureInfo = new CultureInfo(_applicationObject.LocaleID);
					string resourceName = String.Concat(cultureInfo.TwoLetterISOLanguageName, "Tools");
					toolsMenuName = resourceManager.GetString(resourceName);
				}
				catch
				{
					//We tried to find a localized version of the word Tools, but one was not found.
					//  Default to the en-US word, which may work for the current culture.
					toolsMenuName = "Tools";
				}

				//Place the command on the tools menu.
				//Find the MenuBar command bar, which is the top-level command bar holding all the main menu items:
            CommandBar menuBarCommandBar = ((CommandBars)_applicationObject.CommandBars)["MenuBar"];
            CommandBar menuBarStandard = ((CommandBars)_applicationObject.CommandBars)["Standard"];

            List<string> s = new List<string>();
            foreach (CommandBar cb in ((CommandBars)_applicationObject.CommandBars))
			   {
			      s.Add(cb.Name); 
			   }

				//Find the Tools command bar on the MenuBar command bar:
				CommandBarControl toolsControl = menuBarCommandBar.Controls[toolsMenuName];
				CommandBarPopup toolsPopup = (CommandBarPopup)toolsControl;

				//This try/catch block can be duplicated if you wish to add multiple commands to be handled by your Add-in,
				//  just make sure you also update the QueryStatus/Exec method to include the new command names.

            try
            {
               commands.UpdateCommandUI(true);
               foreach (Command o in commands)
                  if (o.Name == "SQL_Outliner.Connect.SQL_Outliner"||
                      o.Name == "SQL_Outliner.Connect.SQL_Outliner_Inner" ||
                      o.Name == "SQL_Outliner.Connect.SQL_Outliner_Trim" ||
                      o.Name == "SQL_Outliner.Connect.SQL_Outliner_Comment")
                     o.Delete();
            }
            catch { }
               
            try
				{
					//Add a command to the Commands collection:
               Command command =
                  commands.AddNamedCommand2(_addInInstance, "SQL_Outliner", "SQL_Outliner",
                                            "Executes the command for SQL_Outliner", true, 59,
                                            ref contextGUIDS,
                                            (int)vsCommandStatus.vsCommandStatusSupported +
                                            (int)vsCommandStatus.vsCommandStatusEnabled,
                                            (int)vsCommandStyle.vsCommandStylePictAndText,
                                            vsCommandControlType.vsCommandControlTypeButton);
               Command commandInner =
                  commands.AddNamedCommand2(_addInInstance, "SQL_Outliner_Inner", "SQL_Outliner_Inner",
                                            "Executes the command for SQL_Outliner", true, 59,
                                            ref contextGUIDS,
                                            (int)vsCommandStatus.vsCommandStatusSupported +
                                            (int)vsCommandStatus.vsCommandStatusEnabled,
                                            (int)vsCommandStyle.vsCommandStylePictAndText,
                                            vsCommandControlType.vsCommandControlTypeButton);
               Command commandTrim =
                  commands.AddNamedCommand2(_addInInstance, "SQL_Outliner_Trim", "SQL_Outliner_Trim",
                                            "Executes the command for SQL_Outliner", true, 59,
                                            ref contextGUIDS,
                                            (int)vsCommandStatus.vsCommandStatusSupported +
                                            (int)vsCommandStatus.vsCommandStatusEnabled,
                                            (int)vsCommandStyle.vsCommandStylePictAndText,
                                            vsCommandControlType.vsCommandControlTypeButton);
               Command commandComment =
                  commands.AddNamedCommand2(_addInInstance, "SQL_Outliner_Comment", "--[?]--{",
                                            "Executes the command for SQL_Outliner", true, 59,
                                            ref contextGUIDS,
                                            (int)vsCommandStatus.vsCommandStatusSupported +
                                            (int)vsCommandStatus.vsCommandStatusEnabled,
                                            (int)vsCommandStyle.vsCommandStylePictAndText,
                                            vsCommandControlType.vsCommandControlTypeButton);

					//Add a control for the command to the tools menu:
					if((command != null) && (toolsPopup != null))
					{
                  command.AddControl(toolsPopup.CommandBar, 1);
                  commandInner.AddControl(toolsPopup.CommandBar, 1);
                  commandComment.AddControl(toolsPopup.CommandBar, 1);
                  commandTrim.AddControl(toolsPopup.CommandBar, 1);

						CommandBarControl c = command.AddControl(menuBarStandard, menuBarStandard.Controls.Count + 1) as CommandBarControl;
						c.BeginGroup = true;
						commandInner.AddControl(menuBarStandard, menuBarStandard.Controls.Count + 1);
						commandComment.AddControl(menuBarStandard, menuBarStandard.Controls.Count + 1);
					}
				}
				catch(ArgumentException)
				{
					//If we are here, then the exception is probably because a command with that name
					//  already exists. If so there is no need to recreate the command and we can 
                    //  safely ignore the exception.
               commands.UpdateCommandUI(true);
				}
			}
		}

		/// <summary>Implements the OnDisconnection method of the IDTExtensibility2 interface. Receives notification that the Add-in is being unloaded.</summary>
		/// <param term='disconnectMode'>Describes how the Add-in is being unloaded.</param>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnDisconnection(ext_DisconnectMode disconnectMode, ref Array custom)
		{
		}

		/// <summary>Implements the OnAddInsUpdate method of the IDTExtensibility2 interface. Receives notification when the collection of Add-ins has changed.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />		
		public void OnAddInsUpdate(ref Array custom)
		{
		}

		/// <summary>Implements the OnStartupComplete method of the IDTExtensibility2 interface. Receives notification that the host application has completed loading.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnStartupComplete(ref Array custom)
		{
		}

		/// <summary>Implements the OnBeginShutdown method of the IDTExtensibility2 interface. Receives notification that the host application is being unloaded.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnBeginShutdown(ref Array custom)
		{
		}
		
		/// <summary>Implements the QueryStatus method of the IDTCommandTarget interface. This is called when the command's availability is updated</summary>
		/// <param term='commandName'>The name of the command to determine state for.</param>
		/// <param term='neededText'>Text that is needed for the command.</param>
		/// <param term='status'>The state of the command in the user interface.</param>
		/// <param term='commandText'>Text requested by the neededText parameter.</param>
		/// <seealso class='Exec' />
		public void QueryStatus(string commandName, vsCommandStatusTextWanted neededText, ref vsCommandStatus status, ref object commandText)
		{
         if (neededText == vsCommandStatusTextWanted.vsCommandStatusTextWantedNone)
			{
            if (commandName == "SQL_Outliner.Connect.SQL_Outliner"||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Inner"||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Trim" ||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Comment")
            {
               status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
               return;
            }
         }
		}

		/// <summary>Implements the Exec method of the IDTCommandTarget interface. This is called when the command is invoked.</summary>
		/// <param term='commandName'>The name of the command to execute.</param>
		/// <param term='executeOption'>Describes how the command should be run.</param>
		/// <param term='varIn'>Parameters passed from the caller to the command handler.</param>
		/// <param term='varOut'>Parameters passed from the command handler to the caller.</param>
		/// <param term='handled'>Informs the caller if the command was handled or not.</param>
		/// <seealso class='Exec' />
		public void Exec(string commandName, vsCommandExecOption executeOption, ref object varIn, ref object varOut, ref bool handled)
		{
         handled = false;
         if (executeOption == vsCommandExecOption.vsCommandExecOptionDoDefault)
			{
            if (commandName == "SQL_Outliner.Connect.SQL_Outliner"||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Trim" ||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Inner" ||
               commandName == "SQL_Outliner.Connect.SQL_Outliner_Comment")
            {
				   handled = true;
               try
               {
                  if (commandName == "SQL_Outliner.Connect.SQL_Outliner_Trim")
                  {
                     Trim();
                     return;
                  }
                  if (commandName == "SQL_Outliner.Connect.SQL_Outliner_Comment")
                  {
                     MakeComment();
                     return;
                  }
                  MakeOutlililng(commandName == "SQL_Outliner.Connect.SQL_Outliner_Inner");
               
               }catch
               {
               }
				   return;
            }
			}
		}

		private void TrimFast()
		{
			TextSelection text = ((TextSelection)_applicationObject.ActiveDocument.Selection);
			string s = text.Text;
			while (true)
			{
				int len = s.Length;
				foreach (char c in " \t".ToCharArray())
					s = s.Replace(c + Environment.NewLine, Environment.NewLine);
				if (s.Length == len)
					break;
			}
			text.Insert(s, (int)vsInsertFlags.vsInsertFlagsCollapseToEnd);
		}

		private void Trim()
	   {
         TextSelection text = ((TextSelection)_applicationObject.ActiveDocument.Selection);
	      int topLine = text.TopPoint.Line;
	      int bottomLine = text.BottomPoint.Line;

			string allText = text.Text;
			string[] lines = allText.Replace(Environment.NewLine, "\n").Split('\n');

			for(int i = 0 ; i<lines.Length ;i++)
				if (lines[i] != lines[i].TrimEnd("\t ".ToCharArray()))
				{
					text.GotoLine(i+topLine, false);
					text.EndOfLine(false);
					text.CharLeft(true, lines[i].Length - lines[i].TrimEnd("\t ".ToCharArray()).Length);
					text.Delete(1);
				}
	   }


	   private void MakeComment()
	   {

         TextSelection text = ((TextSelection)_applicationObject.ActiveDocument.Selection);
         int topLine = text.TopPoint.Line;
         int bottomLine = text.BottomPoint.Line;

         text.GotoLine(topLine, false);
         text.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText, false);
         

         text.EndOfLine(true);
	   	

	      string comment = text.Text;
      
         comment = comment.Replace(Environment.NewLine,"").Trim("\t -\r\n{[]".ToCharArray());
	      comment = "--[ " + comment + " ]--";
	      while (comment.Length < 70)
	         comment += '-';
         comment += "{ ";
         
	      text.Text = comment;
			int col = text.ActivePoint.VirtualDisplayColumn - 1;

         text.GotoLine(bottomLine,false);
         text.EndOfLine(false);
         text.Text = Environment.NewLine + "--}";

         text.EndOfLine(false);
         text.CharLeft(false, 1);
         text.MoveTo(topLine,col, true);
         text.OutlineSection();
         text.GotoLine(topLine + 1, false);
         text.StartOfLine(vsStartOfLineOptions.vsStartOfLineOptionsFirstText, false);



	   }

	   private void MakeOutlililng(bool inner)
      {
         _applicationObject.Find.Target = vsFindTarget.vsFindTargetCurrentDocument;
         _applicationObject.Find.MatchCase = false;
         _applicationObject.Find.MatchWholeWord = true;
         _applicationObject.Find.Backwards = false;
         _applicationObject.Find.MatchInHiddenText = true;
         _applicationObject.Find.PatternSyntax = vsFindPatternSyntax.vsFindPatternSyntaxLiteral;
         _applicationObject.Find.Action = vsFindAction.vsFindActionFind;

         try
         {
            _applicationObject.ExecuteCommand("Edit.StopOutlining", "");
         }
         catch
         {
         }

         List<Entry> starts = new List<Entry>();
         FindStarts(starts, true, "--{");
         FindStarts(starts, false, "--}");
         starts.Sort();

         if (starts.Count > 0)
            if(inner)
               OutlineNew(starts); // --{   --}
            else
               OutlineNew_withoutinner(starts); 
         else
            OutlineOld(); // --1   --1


         try
         {
            _applicationObject.ExecuteCommand("Edit.ToggleAllOutlining", "");
         }
         catch
         {
         }
      }

	   private void OutlineOld()
	   {
	      TextPoint tp = ((TextSelection)_applicationObject.ActiveDocument.Selection).ActivePoint;
         foreach (string s in new string[] { "--0", "--1", "--2", "--i" })
         {
            _applicationObject.Find.FindWhat = s;
            ((TextSelection)_applicationObject.ActiveDocument.Selection).StartOfDocument(false);
            int i = -1;
            long j = -1;
            for (; ; )
            {
               _applicationObject.ExecuteCommand("Edit.FindNext", "");
               if (tp.AbsoluteCharOffset <= i || tp.AbsoluteCharOffset <= j)
                  break;
               i = tp.AbsoluteCharOffset; //            'start poin
               _applicationObject.ExecuteCommand("Edit.FindNext", "");
               if (tp.AbsoluteCharOffset <= i)
               {
                  MessageBox.Show("нечетное число отметок вида " + _applicationObject.Find.FindWhat);
                  return;
               }
               try
               { _applicationObject.ExecuteCommand("Edit.SelectToLastGoBack", ""); }
               catch { }
               ((TextSelection)_applicationObject.ActiveDocument.Selection).OutlineSection();
               j = tp.AbsoluteCharOffset; //            'end point
            }
         }

	   }

	   private void OutlineNew_withoutinner(IList<Entry> starts)
      {
         for (int j = 0; j < starts.Count; j++)
         {
            int vloj = 0;
            if (starts[j].Start)
               for (int k = j; k < starts.Count; k++)
               {
                  if (starts[k].Start) vloj++;
                  else vloj--;
                  if (vloj == 0)
                  {
                     //j-k

                     //                           ((TextSelection)_applicationObject.ActiveDocument.Selection).GotoLine((int)starts[j].Line, false);
                     ((TextSelection) _applicationObject.ActiveDocument.Selection)
                        .MoveTo(starts[j].Line, starts[j].Column, false);
                     ((TextSelection)_applicationObject.ActiveDocument.Selection)
                        .MoveTo(starts[k].Line, starts[k].Column-1, true);

                     ((TextSelection) _applicationObject.ActiveDocument.Selection).OutlineSection();
                     break;
                  }
               }
         }
      }

      private void OutlineNew(IList<Entry> starts)
      {
         for (int j = 0; j < starts.Count; j++)
            if (starts[j].Start)
               j = OutlineRecurs(starts, j);
      }

	   private int OutlineRecurs(IList<Entry> starts, int j)
	   {
         for (int k = j+1; k < starts.Count; k++)
         {
            if (starts[k].Start)
               k = OutlineRecurs(starts, k);
            else 
            {
               //j-k

               //                           ((TextSelection)_applicationObject.ActiveDocument.Selection).GotoLine((int)starts[j].Line, false);
               ((TextSelection)_applicationObject.ActiveDocument.Selection)
                  .MoveTo(starts[j].Line, starts[j].Column, false);
               ((TextSelection)_applicationObject.ActiveDocument.Selection)
                  .MoveTo(starts[k].Line, starts[k].Column - 1, true);

               ((TextSelection)_applicationObject.ActiveDocument.Selection).OutlineSection();
					
               return k;
            }
         }
	      return starts.Count;
	   }

	   private void FindStarts(List<Entry> starts, bool isStart, string FindWhat)
	   {
	      int i,iprev = -1;
         TextPoint tp = ((TextSelection)_applicationObject.ActiveDocument.Selection).ActivePoint;
         
         _applicationObject.Find.FindWhat = FindWhat;
         ((TextSelection)_applicationObject.ActiveDocument.Selection).StartOfDocument(false);
         while (true)
         {
            //_applicationObject.ExecuteCommand("Edit.FindNext", "");
            if (_applicationObject.Find.Execute() != vsFindResult.vsFindResultFound)
               break;

            i = tp.AbsoluteCharOffset;
            if (i <= iprev)
               break;
            TextSelection text = ((TextSelection)_applicationObject.ActiveDocument.Selection);
            starts.Add(new Entry(isStart
               , text.ActivePoint.Line //text.CurrentLine
               , text.ActivePoint.VirtualDisplayColumn //text.CurrentColumn
               , text.ActivePoint.AbsoluteCharOffset
               ));
            iprev = i;
         }

	   }

	   private DTE2 _applicationObject;
		private AddIn _addInInstance;
	}
   internal class Entry : IComparable<Entry>
   {
      public readonly bool Start;
      public readonly int Line;
      public readonly int Column;
      public readonly int CharIndex;
      public Entry(bool start, int line, int column, int charIndex)
      {
         Start = start;
         CharIndex = charIndex;
         Column = column;
         Line = line;
      }

      public int CompareTo(Entry other)
      {
         return CharIndex.CompareTo(other.CharIndex);
      }
   }

}