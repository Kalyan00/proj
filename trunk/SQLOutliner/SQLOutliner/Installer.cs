using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;
using System.IO;
using System.Text;
using System.Windows.Forms;

// Set 'RunInstaller' attribute to true.
[RunInstaller(true)]
public class MyInstallerClass : Installer
{
   public MyInstallerClass()
      : base()
   {
      // Attach the 'Committed' event.
      this.Committed += new InstallEventHandler(MyInstaller_Committed);
      // Attach the 'Committing' event.
      this.Committing += new InstallEventHandler(MyInstaller_Committing);

   }
   // Event handler for 'Committing' event.
   private void MyInstaller_Committing(object sender, InstallEventArgs e)
   {
   }
   // Event handler for 'Committed' event.
   private void MyInstaller_Committed(object sender, InstallEventArgs e)
   {
   }
   // Override the 'Install' method.
   public override void Install(IDictionary savedState)
   {

      string dllLocation = GetType().Assembly.Location;
      string xml = string.Format(SQL_Outliner.Properties.Resources.AddInFile, dllLocation);
      string myDocs = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
      string addinDir =  myDocs + @"\Visual Studio 2005\AddIns\";
      string addinFile = addinDir + "SQL_Outliner.Addin";
      if (!Directory.Exists(addinDir))
         Directory.CreateDirectory(addinDir);

      File.WriteAllText(addinFile,xml,Encoding.BigEndianUnicode);

      base.Install(savedState);
   }
   // Override the 'Commit' method.
   public override void Commit(IDictionary savedState)
   {
      base.Commit(savedState);
   }
   // Override the 'Rollback' method.
   public override void Rollback(IDictionary savedState)
   {
      base.Rollback(savedState);
   }
   //public static void Main()
   //{
   //   Console.WriteLine("Usage : installutil.exe Installer.exe ");
   //}
}

