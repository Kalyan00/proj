using System;
using System.IO.Ports;
using System.Threading;
using System.Windows.Forms;

namespace OptScanner
{
	public class ComPort
	{
		readonly object Locker = new object();
		private bool sleep;
		private Control _Control;
		private readonly TimerHandler th = new TimerHandler();

		public event EventHandler Recive;

		public SerialPort ComPortInternal { get; set; }
		public int WaitInterval { get; set; } 

		public ComPort()
		{
			ComPortInternal = new SerialPort("COM1");
		}

		public void WaitResponse()
		{
			lock (Locker)
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
			string result = "123456789";
			Say(Text);
			WaitResponse();
			result = ComPortInternal.ReadExisting();
			return result;
			
		}
		public void Say(string Text)
		{
			ComPortInternal.Write(Text + Environment.NewLine);
		}


		public void Init(Control control)
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
