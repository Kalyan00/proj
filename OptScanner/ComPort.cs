using System;
using System.IO.Ports;
using System.Timers;
using System.Collections.Generic;
using System.Threading;
using System.Windows.Forms;

namespace OptScanner
{
	public class ComPort
	{
		private byte[] Enter = new byte[2] { 10, 13 };
		private bool sleep;
		private System.Windows.Forms.Control _Control;
		private TimerHandler th = new TimerHandler();

		public event EventHandler Recive;

		public SerialPort ComPortInternal { get; set; }
		public int WaitInterval { get; set; } 

		public ComPort()
		{
			ComPortInternal = new SerialPort("COM1");
		}

		public void WaitResponse()
		{
			lock (Enter)
			{
				sleep = true;
				while (sleep)
				{
					if (!_Control.Visible)
						throw new Exception();
					Thread.Sleep(100);
					Application.DoEvents();
				}
			}
		}
		public string Ask(string Text)
		{
			Say(Text);
			WaitResponse();
			return ComPortInternal.ReadExisting();
		}
		public void Say(string Text)
		{
			ComPortInternal.Write(Text);
			ComPortInternal.Write(Enter,0,2);
		}


		public void Init(System.Windows.Forms.Control control)
		{
			ComPortInternal.Open();
			
			ComPortInternal.DataReceived += comReceived;
			_Control = control;
		}
		private void comReceived(object sender, SerialDataReceivedEventArgs e)
		{
			th.DoAfter(_Control, WaitInterval, comReceivedInvoker);
		}

		private void comReceivedInvoker()
		{
			if (sleep)
			{
				sleep = false;
				return;
			}
			if (Recive != null)
				Recive(this, new EventArgs());
		}


		public string ReadExisting()
		{
			return ComPortInternal.ReadExisting();
		}
	}
}
