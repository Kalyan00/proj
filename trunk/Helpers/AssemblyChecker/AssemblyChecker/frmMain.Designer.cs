namespace AssemblyChecker
{
	partial class frmMain
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
			this.btnStart = new System.Windows.Forms.Button();
			this.txtResult = new System.Windows.Forms.TextBox();
			this.scMain = new System.Windows.Forms.SplitContainer();
			this.lblFiles = new System.Windows.Forms.Label();
			this.flvMain = new Overlord.Common.Controls.FileListView();
			this.txtMethodNamePattern = new Overlord.Common.Controls.LabelTextBox();
			this.scMain.Panel1.SuspendLayout();
			this.scMain.Panel2.SuspendLayout();
			this.scMain.SuspendLayout();
			this.SuspendLayout();
			// 
			// btnStart
			// 
			this.btnStart.Dock = System.Windows.Forms.DockStyle.Top;
			this.btnStart.Location = new System.Drawing.Point(0, 24);
			this.btnStart.Name = "btnStart";
			this.btnStart.Size = new System.Drawing.Size(399, 23);
			this.btnStart.TabIndex = 1;
			this.btnStart.Text = "Start check";
			this.btnStart.UseVisualStyleBackColor = true;
			this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
			// 
			// txtResult
			// 
			this.txtResult.Dock = System.Windows.Forms.DockStyle.Fill;
			this.txtResult.Location = new System.Drawing.Point(0, 47);
			this.txtResult.Multiline = true;
			this.txtResult.Name = "txtResult";
			this.txtResult.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.txtResult.Size = new System.Drawing.Size(399, 393);
			this.txtResult.TabIndex = 2;
			this.txtResult.WordWrap = false;
			// 
			// scMain
			// 
			this.scMain.Dock = System.Windows.Forms.DockStyle.Fill;
			this.scMain.Location = new System.Drawing.Point(4, 4);
			this.scMain.Name = "scMain";
			// 
			// scMain.Panel1
			// 
			this.scMain.Panel1.Controls.Add(this.flvMain);
			this.scMain.Panel1.Controls.Add(this.lblFiles);
			// 
			// scMain.Panel2
			// 
			this.scMain.Panel2.Controls.Add(this.txtResult);
			this.scMain.Panel2.Controls.Add(this.btnStart);
			this.scMain.Panel2.Controls.Add(this.txtMethodNamePattern);
			this.scMain.Size = new System.Drawing.Size(604, 440);
			this.scMain.SplitterDistance = 201;
			this.scMain.TabIndex = 3;
			// 
			// lblFiles
			// 
			this.lblFiles.AutoSize = true;
			this.lblFiles.Dock = System.Windows.Forms.DockStyle.Top;
			this.lblFiles.Location = new System.Drawing.Point(0, 0);
			this.lblFiles.Name = "lblFiles";
			this.lblFiles.Size = new System.Drawing.Size(82, 13);
			this.lblFiles.TabIndex = 1;
			this.lblFiles.Text = "Files (drop here)";
			// 
			// flvMain
			// 
			this.flvMain.Dock = System.Windows.Forms.DockStyle.Fill;
			this.flvMain.Location = new System.Drawing.Point(0, 13);
			this.flvMain.Name = "flvMain";
			this.flvMain.Size = new System.Drawing.Size(201, 427);
			this.flvMain.TabIndex = 0;
			this.flvMain.UseCompatibleStateImageBehavior = false;
			this.flvMain.View = System.Windows.Forms.View.List;
			// 
			// txtMethodNamePattern
			// 
			this.txtMethodNamePattern.AutoSize = true;
			this.txtMethodNamePattern.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
			this.txtMethodNamePattern.Dock = System.Windows.Forms.DockStyle.Top;
			this.txtMethodNamePattern.LabelText = "Method Name Pattern";
			this.txtMethodNamePattern.Location = new System.Drawing.Point(0, 0);
			this.txtMethodNamePattern.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
			this.txtMethodNamePattern.MaxLength = 32767;
			this.txtMethodNamePattern.Name = "txtMethodNamePattern";
			this.txtMethodNamePattern.Padding = new System.Windows.Forms.Padding(0, 0, 0, 4);
			this.txtMethodNamePattern.SelectionStart = 0;
			this.txtMethodNamePattern.Size = new System.Drawing.Size(399, 24);
			this.txtMethodNamePattern.TabIndex = 3;
			this.txtMethodNamePattern.Text = "[A-Za-z<_][A-Za-z0-9_~`>]*";
			this.txtMethodNamePattern.WordWrap = true;
			// 
			// frmMain
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(612, 448);
			this.Controls.Add(this.scMain);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.Name = "frmMain";
			this.Padding = new System.Windows.Forms.Padding(4);
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "MainForm";
			this.scMain.Panel1.ResumeLayout(false);
			this.scMain.Panel1.PerformLayout();
			this.scMain.Panel2.ResumeLayout(false);
			this.scMain.Panel2.PerformLayout();
			this.scMain.ResumeLayout(false);
			this.ResumeLayout(false);

		}

		#endregion

		private Overlord.Common.Controls.FileListView flvMain;
		private System.Windows.Forms.Button btnStart;
		private System.Windows.Forms.TextBox txtResult;
		private System.Windows.Forms.SplitContainer scMain;
		private System.Windows.Forms.Label lblFiles;
		private Overlord.Common.Controls.LabelTextBox txtMethodNamePattern;
	}
}

