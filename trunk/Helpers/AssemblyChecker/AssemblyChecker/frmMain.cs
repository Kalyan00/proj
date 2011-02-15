using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Overlord.Common.Classes;
using System.Reflection;

namespace AssemblyChecker
{
	public partial class frmMain : Form
	{
		public frmMain()
		{
			InitializeComponent();

			flvMain.AddFile(Assembly.GetExecutingAssembly().Location);
		}

		private void btnStart_Click(object sender, EventArgs e)
		{
			txtResult.Clear();

			try
			{
				var checker = new MemberChecker();
				checker.NamePattern = txtMethodNamePattern.Text;

				foreach (var item in flvMain.Items)
				{
					var lvi = (ListViewItem)item;
					var reason = new StatusReason(Environment.NewLine);
					var path = lvi.Tag.ToString();

					txtResult.AppendText("==========" + Environment.NewLine + lvi.Text + Environment.NewLine);

					checker.CheckFile(path, reason);
					txtResult.AppendText(reason.IsOK ? "OK." : reason.Reason.ToString());
		
					txtResult.AppendText(Environment.NewLine);
					txtResult.AppendText(Environment.NewLine);
				}
			}
			catch (Exception exc)
			{
				ErrorBox.ShowError(exc);
			}
		}
	}
}
