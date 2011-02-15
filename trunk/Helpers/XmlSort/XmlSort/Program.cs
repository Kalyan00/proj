using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

namespace XmlSort
{
	class Program
	{
		static int Main(string[] args)
		{
			if (args.Length < 1)
				return ExitErr("args.Length < 1");
			if(!File.Exists(args[0]))
				return ExitErr("File '" + args[0] + "' not Exists");
			XmlDocument xDoc = new XmlDocument();
			try
			{
				xDoc.Load(args[0]);
			}
			catch(Exception ex)
			{
				return ExitErr(ex.ToString());
			}

			foreach (XmlNode chNode in xDoc.ChildNodes)
				SortAttribs(chNode);

			foreach (XmlNode chNode in xDoc.ChildNodes)
				SortChildNodes(chNode);

			StringBuilder sb = new StringBuilder();
			using (var xw = XmlWriter.Create(sb, new XmlWriterSettings
			{
				//Encoding = Encoding.UTF8,
				Indent = true,
			}))
				xDoc.WriteTo(xw);

			Console.Out.Write(sb.ToString());
			
			return 0;
		}

		private static void SortChildNodes(XmlNode node)
		{

			var sl = new SortedList<string, XmlNode>();
			if (node.Attributes != null)
			{
				int i = 0;
				foreach (XmlNode n in node.ChildNodes)
					sl[n.OuterXml + "\"" + i++] = n;
				foreach (var n in sl.Values)
					node.RemoveChild(n);

				foreach (var n in sl.Values)
					node.AppendChild(n);
			}

			foreach (XmlNode chNode in node.ChildNodes)
				SortAttribs(chNode);
		}

		private static void SortAttribs(XmlNode node)
		{
			var sl = new SortedList<string, XmlAttribute>();
			if (node.Attributes != null)
			{
				foreach (XmlAttribute attr in node.Attributes)
					sl[attr.Name + "\"" + attr.Value] = attr;
				node.Attributes.RemoveAll();
				foreach (var attr in sl.Values)
					node.Attributes.Append(attr);
			}

			foreach (XmlNode chNode in node.ChildNodes)
				SortAttribs(chNode);
		}

		private static int ExitErr(string s)
		{
			Console.Out.WriteLine(s);
			return 1;
		}
	}
}
