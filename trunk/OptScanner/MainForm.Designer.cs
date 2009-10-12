namespace OptScanner
{
    partial class MainForm
    {
        /// <summary>
        /// Требуется переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Обязательный метод для поддержки конструктора - не изменяйте
        /// содержимое данного метода при помощи редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
			  this.pictureBox1 = new System.Windows.Forms.PictureBox();
			  this.panel1 = new System.Windows.Forms.Panel();
			  this.label3 = new System.Windows.Forms.Label();
			  this.panel2 = new System.Windows.Forms.Panel();
			  this.label1 = new System.Windows.Forms.Label();
			  this.lblUser = new System.Windows.Forms.Label();
			  this.cbMethods = new System.Windows.Forms.ComboBox();
			  this.btnStart = new System.Windows.Forms.Button();
			  this.label2 = new System.Windows.Forms.Label();
			  this.panel6 = new System.Windows.Forms.Panel();
			  this.panel4 = new System.Windows.Forms.Panel();
			  this.txtDescr = new System.Windows.Forms.TextBox();
			  this.panel5 = new System.Windows.Forms.Panel();
			  this.btnAddDescr = new System.Windows.Forms.Button();
			  this.label4 = new System.Windows.Forms.Label();
			  this.panel3 = new System.Windows.Forms.Panel();
			  this.panel7 = new System.Windows.Forms.Panel();
			  ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
			  this.panel1.SuspendLayout();
			  this.panel2.SuspendLayout();
			  this.panel6.SuspendLayout();
			  this.panel4.SuspendLayout();
			  this.panel5.SuspendLayout();
			  this.panel3.SuspendLayout();
			  this.panel7.SuspendLayout();
			  this.SuspendLayout();
			  // 
			  // pictureBox1
			  // 
			  this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Right;
			  this.pictureBox1.Image = global::OptScanner.Properties.Resources.multiskanex;
			  this.pictureBox1.Location = new System.Drawing.Point(290, 0);
			  this.pictureBox1.Name = "pictureBox1";
			  this.pictureBox1.Size = new System.Drawing.Size(250, 132);
			  this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.AutoSize;
			  this.pictureBox1.TabIndex = 1;
			  this.pictureBox1.TabStop = false;
			  // 
			  // panel1
			  // 
			  this.panel1.Controls.Add(this.label3);
			  this.panel1.Controls.Add(this.panel2);
			  this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
			  this.panel1.Location = new System.Drawing.Point(0, 0);
			  this.panel1.Name = "panel1";
			  this.panel1.Padding = new System.Windows.Forms.Padding(20, 20, 20, 10);
			  this.panel1.Size = new System.Drawing.Size(540, 55);
			  this.panel1.TabIndex = 2;
			  // 
			  // label3
			  // 
			  this.label3.AutoSize = true;
			  this.label3.Dock = System.Windows.Forms.DockStyle.Right;
			  this.label3.Location = new System.Drawing.Point(243, 20);
			  this.label3.Name = "label3";
			  this.label3.Size = new System.Drawing.Size(10, 13);
			  this.label3.TabIndex = 4;
			  this.label3.Text = " ";
			  // 
			  // panel2
			  // 
			  this.panel2.Controls.Add(this.label1);
			  this.panel2.Controls.Add(this.lblUser);
			  this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
			  this.panel2.Location = new System.Drawing.Point(253, 20);
			  this.panel2.Name = "panel2";
			  this.panel2.Size = new System.Drawing.Size(267, 25);
			  this.panel2.TabIndex = 0;
			  // 
			  // label1
			  // 
			  this.label1.AutoSize = true;
			  this.label1.Dock = System.Windows.Forms.DockStyle.Right;
			  this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			  this.label1.Location = new System.Drawing.Point(56, 0);
			  this.label1.Name = "label1";
			  this.label1.Size = new System.Drawing.Size(103, 17);
			  this.label1.TabIndex = 0;
			  this.label1.Text = "Вы зашли как:";
			  // 
			  // lblUser
			  // 
			  this.lblUser.AutoSize = true;
			  this.lblUser.Dock = System.Windows.Forms.DockStyle.Right;
			  this.lblUser.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Italic | System.Drawing.FontStyle.Underline))), System.Drawing.GraphicsUnit.Point, ((byte)(204)));
			  this.lblUser.Location = new System.Drawing.Point(159, 0);
			  this.lblUser.Name = "lblUser";
			  this.lblUser.Size = new System.Drawing.Size(108, 17);
			  this.lblUser.TabIndex = 1;
			  this.lblUser.Text = "                         ";
			  this.lblUser.Click += new System.EventHandler(this.lblUser_Click);
			  // 
			  // cbMethods
			  // 
			  this.cbMethods.Dock = System.Windows.Forms.DockStyle.Fill;
			  this.cbMethods.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			  this.cbMethods.FormattingEnabled = true;
			  this.cbMethods.Location = new System.Drawing.Point(163, 0);
			  this.cbMethods.Name = "cbMethods";
			  this.cbMethods.Size = new System.Drawing.Size(282, 21);
			  this.cbMethods.TabIndex = 1;
			  this.cbMethods.SelectedIndexChanged += new System.EventHandler(this.cbMethods_SelectedIndexChanged);
			  // 
			  // btnStart
			  // 
			  this.btnStart.Dock = System.Windows.Forms.DockStyle.Right;
			  this.btnStart.Enabled = false;
			  this.btnStart.Location = new System.Drawing.Point(445, 0);
			  this.btnStart.Name = "btnStart";
			  this.btnStart.Size = new System.Drawing.Size(75, 21);
			  this.btnStart.TabIndex = 3;
			  this.btnStart.Text = "СТАРТ!";
			  this.btnStart.UseVisualStyleBackColor = true;
			  this.btnStart.Click += new System.EventHandler(this.btnStart_Click);
			  // 
			  // label2
			  // 
			  this.label2.Dock = System.Windows.Forms.DockStyle.Left;
			  this.label2.Location = new System.Drawing.Point(20, 0);
			  this.label2.Name = "label2";
			  this.label2.Size = new System.Drawing.Size(143, 21);
			  this.label2.TabIndex = 2;
			  this.label2.Text = "Выберите метод расчета:";
			  this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			  // 
			  // panel6
			  // 
			  this.panel6.Controls.Add(this.cbMethods);
			  this.panel6.Controls.Add(this.btnStart);
			  this.panel6.Controls.Add(this.label2);
			  this.panel6.Dock = System.Windows.Forms.DockStyle.Top;
			  this.panel6.Location = new System.Drawing.Point(0, 55);
			  this.panel6.Name = "panel6";
			  this.panel6.Padding = new System.Windows.Forms.Padding(20, 0, 20, 14);
			  this.panel6.Size = new System.Drawing.Size(540, 35);
			  this.panel6.TabIndex = 0;
			  // 
			  // panel4
			  // 
			  this.panel4.Controls.Add(this.txtDescr);
			  this.panel4.Dock = System.Windows.Forms.DockStyle.Fill;
			  this.panel4.Location = new System.Drawing.Point(0, 103);
			  this.panel4.Name = "panel4";
			  this.panel4.Padding = new System.Windows.Forms.Padding(10);
			  this.panel4.Size = new System.Drawing.Size(540, 198);
			  this.panel4.TabIndex = 5;
			  // 
			  // txtDescr
			  // 
			  this.txtDescr.Dock = System.Windows.Forms.DockStyle.Fill;
			  this.txtDescr.Location = new System.Drawing.Point(10, 10);
			  this.txtDescr.Multiline = true;
			  this.txtDescr.Name = "txtDescr";
			  this.txtDescr.Size = new System.Drawing.Size(520, 178);
			  this.txtDescr.TabIndex = 3;
			  // 
			  // panel5
			  // 
			  this.panel5.Controls.Add(this.btnAddDescr);
			  this.panel5.Dock = System.Windows.Forms.DockStyle.Bottom;
			  this.panel5.Location = new System.Drawing.Point(0, 301);
			  this.panel5.Name = "panel5";
			  this.panel5.Padding = new System.Windows.Forms.Padding(10);
			  this.panel5.Size = new System.Drawing.Size(540, 52);
			  this.panel5.TabIndex = 6;
			  // 
			  // btnAddDescr
			  // 
			  this.btnAddDescr.Dock = System.Windows.Forms.DockStyle.Fill;
			  this.btnAddDescr.Location = new System.Drawing.Point(10, 10);
			  this.btnAddDescr.Name = "btnAddDescr";
			  this.btnAddDescr.Size = new System.Drawing.Size(520, 32);
			  this.btnAddDescr.TabIndex = 0;
			  this.btnAddDescr.Text = "Добавить описание и открыть";
			  this.btnAddDescr.UseVisualStyleBackColor = true;
			  this.btnAddDescr.Click += new System.EventHandler(this.btnAddDescr_Click);
			  // 
			  // label4
			  // 
			  this.label4.AutoSize = true;
			  this.label4.Dock = System.Windows.Forms.DockStyle.Top;
			  this.label4.Location = new System.Drawing.Point(0, 90);
			  this.label4.Name = "label4";
			  this.label4.Size = new System.Drawing.Size(81, 13);
			  this.label4.TabIndex = 4;
			  this.label4.Text = "       Описание:";
			  // 
			  // panel3
			  // 
			  this.panel3.Controls.Add(this.pictureBox1);
			  this.panel3.Dock = System.Windows.Forms.DockStyle.Bottom;
			  this.panel3.Location = new System.Drawing.Point(0, 353);
			  this.panel3.Name = "panel3";
			  this.panel3.Size = new System.Drawing.Size(540, 132);
			  this.panel3.TabIndex = 2;
			  // 
			  // panel7
			  // 
			  this.panel7.Controls.Add(this.panel4);
			  this.panel7.Controls.Add(this.label4);
			  this.panel7.Controls.Add(this.panel5);
			  this.panel7.Controls.Add(this.panel6);
			  this.panel7.Controls.Add(this.panel3);
			  this.panel7.Controls.Add(this.panel1);
			  this.panel7.Dock = System.Windows.Forms.DockStyle.Fill;
			  this.panel7.Location = new System.Drawing.Point(0, 0);
			  this.panel7.Name = "panel7";
			  this.panel7.Size = new System.Drawing.Size(540, 485);
			  this.panel7.TabIndex = 7;
			  // 
			  // MainForm
			  // 
			  this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			  this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			  this.ClientSize = new System.Drawing.Size(540, 485);
			  this.Controls.Add(this.panel7);
			  this.Name = "MainForm";
			  this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			  this.Text = "Программа управления сканером оптической плотности";
			  this.Shown += new System.EventHandler(this.MainForm_Shown);
			  ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
			  this.panel1.ResumeLayout(false);
			  this.panel1.PerformLayout();
			  this.panel2.ResumeLayout(false);
			  this.panel2.PerformLayout();
			  this.panel6.ResumeLayout(false);
			  this.panel4.ResumeLayout(false);
			  this.panel4.PerformLayout();
			  this.panel5.ResumeLayout(false);
			  this.panel3.ResumeLayout(false);
			  this.panel3.PerformLayout();
			  this.panel7.ResumeLayout(false);
			  this.panel7.PerformLayout();
			  this.ResumeLayout(false);

        }

        #endregion

		  private System.Windows.Forms.PictureBox pictureBox1;
		  private System.Windows.Forms.Panel panel1;
		  private System.Windows.Forms.Panel panel2;
		  private System.Windows.Forms.Label lblUser;
		  private System.Windows.Forms.Label label1;
		  private System.Windows.Forms.ComboBox cbMethods;
		  private System.Windows.Forms.Label label2;
		  private System.Windows.Forms.Label label3;
		  private System.Windows.Forms.Button btnStart;
		  private System.Windows.Forms.Panel panel4;
		  private System.Windows.Forms.TextBox txtDescr;
		  private System.Windows.Forms.Panel panel5;
		  private System.Windows.Forms.Label label4;
		  private System.Windows.Forms.Panel panel3;
		  private System.Windows.Forms.Panel panel6;
		  private System.Windows.Forms.Button btnAddDescr;
		  private System.Windows.Forms.Panel panel7;

    }
}

