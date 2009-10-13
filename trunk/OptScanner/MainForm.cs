using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
namespace OptScanner
{
	public partial class MainForm : Form
	{
		OptScannerWork cfg;
		ScanMethod _ScannedMethod;
		public string User
		{
			set
			{
				lblUser.Text = value;
			}
			get
			{
				return lblUser.Text;
			}
		}

		Control[] ControlToDiable;
	
		public MainForm()
		{
			InitializeComponent();
			ControlToDiable = new Control[] { lblUser, btnStart, cbMethods };
		}
		private bool Init()
		{
			cfg = ConfigHandler.GetConfig<OptScannerWork>("OptScannerConfig");
			if (cfg == null)
				return false;

			cfg.Init(this);
			Text = cfg.ReaderName ?? Text;
			foreach (var item in cfg)
				cbMethods.Items.Add(new ToStrinhHolder(item));
			
			return true;
		}
		
		class ToStrinhHolder
		{
			public object obj;
			public ToStrinhHolder(object o)
			{
				obj = o;
			}
			public override string ToString()
			{
				return obj.ToString();
			}

		}

		private void MainForm_Shown(object sender, EventArgs e)
		{
			if (!Init())
			{
				string AppFile = Application.ExecutablePath + ".config";
				bool exists = File.Exists(AppFile);
				if (!exists)
					File.WriteAllText(AppFile, Properties.Resources.App);
				if (exists)
					MessageBox.Show("Файл настроек поврежден.\r\nСовершите настройку и перезапустите программу.", "Внимание", MessageBoxButtons.OK, MessageBoxIcon.Error);
				else
					MessageBox.Show("Пересоздал файл настроек. \r\n Совершите настройку и перезапустите программу.", "Внимание", MessageBoxButtons.OK, MessageBoxIcon.Error);
				Close();
			}
			if (!SelectUser())
				Close();
		}

		private bool SelectUser()
		{
			var frm = new frmSelectUser();
			frm.Init(cfg.Users);
			var d = frm.ShowDialog();
			if (d != DialogResult.OK)
				return false;
			User = frm.SelectedName();
			return true;
		}

		private void lblUser_Click(object sender, EventArgs e)
		{
			SelectUser();
		}

		private void cbMethods_SelectedIndexChanged(object sender, EventArgs e)
		{
			btnStart.Enabled = true;
		}

		private void btnStart_Click(object sender, EventArgs e)
		{
			var x = cbMethods.SelectedItem as ToStrinhHolder;
			if (x == null)
				return;
			var method = x.obj as ScanMethod;
			if (method == null)
				return;
			_ScannedMethod = method;
			panel7.Enabled = false;
			var path = cfg.Do(method, User);
			panel7.Enabled = true;

		}

		private void btnAddDescr_Click(object sender, EventArgs e)
		{
			if(_ScannedMethod == null)
				return;
			var path = cfg.ChangeDescription(_ScannedMethod, txtDescr.Text);
			Process.Start(path);
		}

	}
}
