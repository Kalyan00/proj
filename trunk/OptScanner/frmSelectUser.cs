using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace OptScanner
{
	public partial class frmSelectUser : Form
	{
		public frmSelectUser()
		{
			InitializeComponent();
		}

		internal void Init(List<string> list)
		{
			comboBox1.Items.AddRange(list.ToArray());
		}

		internal string SelectedName()
		{
			return comboBox1.SelectedItem.ToString();
		}

		private void button1_Click(object sender, EventArgs e)
		{
			DialogResult = DialogResult.OK;
			Close();
		}

		private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
		{
			button1.Enabled = true;
		}
	}
}
