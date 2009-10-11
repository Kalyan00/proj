using System;
using System.Collections.Generic;
using System.Configuration;
using System.Reflection;
using System.Windows.Forms;
using System.Xml;
using System.Collections;

namespace OptScanner
{
	public delegate void ParamDelegate(params object[] p);
	public delegate void VoidDelegate();


	public class XmlMapper
	{
		internal static void Fill(object obj, XmlNode xml)
		{
			FillEnumerable(obj, xml);
			FillProperties(obj, xml);
			FillArray(obj, xml);
		}

		private static void FillEnumerable(object obj, XmlNode xml)
		{
			var t = obj.GetType();
			foreach (var interf in GetInterfaces(t))
				if (interf.Name == "ICollection`1")
					FillICollection(obj, interf, interf.GetGenericArguments()[0], xml);
		}

		private static void FillICollection(object obj, Type t, Type memberType, XmlNode xml)
		{
			foreach (XmlNode xmlNode in GetNodes(xml))
				if (xmlNode.Name == "this" || xmlNode.Name == memberType.Name)
				{
					object item;
					if (!GetSimlpeVar(memberType, GetValue(xmlNode), out item))
						item = CreateAndFill(memberType, xmlNode);
					t.InvokeMember("Add", BindingFlags.InvokeMethod, null, obj, new[] { item });
				}
		}

		static Type[] GetInterfaces(Type t)
		{
			return t.FindInterfaces((a, b) => true, null);
		}

		private static void FillArray(object obj, XmlNode xml)
		{
			var t = obj.GetType();
			if (!t.IsArray)
				return;
			return;
			// ващето его нада сразу создать
		}

		internal static void FillProperties(object obj, XmlNode xml)
		{
			var t = obj.GetType();
			var props = t.GetProperties();

			foreach (var prop in props)
			{
				if (!prop.CanWrite)// && (prop.PropertyType.IsValueType || (prop.CanRead&& prop.GetValue(obj, null) == null)))
					continue;

				foreach (XmlNode node in GetNodes(xml))
				{
					if (node.Name != prop.Name)
						continue;
					FillProp(obj, prop, node);
				}
			}
		}


		private static void FillProp(object obj, PropertyInfo prop, XmlNode attr)
		{
			string value = GetValue(attr);

			object objValue;
			if (GetSimlpeVar(prop.PropertyType, value, out objValue))
			{
				if (prop.CanWrite)
					prop.SetValue(obj, objValue, null);
				return;
			}

			objValue = prop.GetValue(obj, null);
			if (objValue == null)
			{
				objValue = CreateObject(prop.PropertyType);
				prop.SetValue(obj, objValue, null);
			}
			if (objValue != null)
				Fill(objValue, attr);
		}

		private static string GetValue(XmlNode attr)
		{
			XmlNode valAttr = null;
			if (attr.Attributes != null)
				valAttr = attr.Attributes.GetNamedItem("Value");
			return (valAttr == null)
					  ? attr.InnerText
					  : valAttr.InnerText;
		}

		private static bool GetSimlpeVar(Type type, string value, out object result)
		{
			result = null;
			if (type == typeof(string))
			{
				result = value;
				return true;
			}

			if (type.IsValueType && type.Name == "Nullable`1")
			{
				result = Convert.ChangeType(value, type.GetGenericArguments()[0]);
				return true;
			}
			if (type.IsEnum)
			{
				int int1;
				if (int.TryParse(value, out int1))
					result = int1;
				else
					result = Enum.Parse(type, value);
				return true;
			}

			if (type.IsValueType)
			{
				result = Convert.ChangeType(value, type);
				return true;
			}
			return false;
		}

		private static object CreateObject(Type type)
		{
			ConstructorInfo ci = type.GetConstructor(new Type[] { });
			if (ci == null)
				return null;
			return ci.Invoke(new object[] { });
		}

		internal static object CreateAndFill(Type type, XmlNode xmlNode)
		{
			object obj = CreateObject(type);
			if (obj == null)
				obj = TryCreateWithParams(type, xmlNode);
			if (obj == null)
				return null;
			Fill(obj, xmlNode);
			return obj;
		}

		private static object TryCreateWithParams(Type type, XmlNode xmlNode)
		{
			List<XmlNode> xnodes = GetNodes(xmlNode);

			ConstructorInfo[] ciList = type.GetConstructors();
			if (ciList.Length != 1)
				return null;

			ParameterInfo[] piList = ciList[0].GetParameters();
			if (piList.Length != xnodes.Count)
				return null;

			object[] prms = new object[piList.Length];
			for (int i = 0; i < piList.Length; i++)
			{
				object objValue;
				if (GetSimlpeVar(piList[i].ParameterType, xnodes[i].InnerText, out objValue))
					prms[i] = objValue;
				else
				{
					prms[i] = CreateAndFill(piList[i].ParameterType, xnodes[i]);
				}
			}

			return ciList[0].Invoke(prms);
		}

		private static List<XmlNode> GetNodes(XmlNode xmlNode)
		{
			var result = new List<XmlNode>();
			if (xmlNode.Attributes != null)
				foreach (XmlNode a in xmlNode.Attributes)
					result.Add(a);
			if (xmlNode.Attributes != null)
				foreach (XmlNode a in xmlNode.ChildNodes)
					result.Add(a);
			return result;
		}

		internal static T1 CreateAndFill<T1>(XmlNode xmlNode)
		{
			return (T1)CreateAndFill(typeof(T1), xmlNode);
		}





		internal static XmlNode AppendXml(object obj, string name, XmlNode node)
		{
			Type t = obj.GetType();
			var newNode = node.OwnerDocument.CreateElement(name);
			node.AppendChild(newNode);

			if (t.IsEnum || t.IsValueType || obj is string)
			{
				var newAttr = node.OwnerDocument.CreateAttribute("Value");
				newAttr.Value = obj.ToString();
				newNode.Attributes.Append(newAttr);
				return newNode;
			}
			
			foreach (var prop in t.GetProperties())
			{
				if (!prop.CanRead)
					continue;
				if (prop.PropertyType.IsArray)
					continue;
				object val = null;
				try
				{
					val = prop.GetValue(obj, null);
				}
				catch
				{
					continue;
				}
				if (val == null)
					continue;

				if (prop.PropertyType.IsEnum || prop.PropertyType.IsValueType || val is string )
				{
					var newAttr = node.OwnerDocument.CreateAttribute(prop.Name);
					newAttr.Value = val.ToString();
					newNode.Attributes.Append(newAttr);
					continue;
				}
				AppendXml(val, prop.Name, newNode);
			}
			if(obj is IEnumerable)
				foreach (var item in obj as IEnumerable)
					AppendXml(item, "this", newNode);
			
			return newNode;
		}
	}

	public class ConfigHandler : IConfigurationSectionHandler
	{
		System.Xml.XmlNode _Xml;
		static public T GetConfig<T>(string sectionName)
		{
			ConfigHandler z = null;
			try
			{
				z = (ConfigHandler)ConfigurationManager.GetSection(sectionName);
			}
			catch
			{ }
			
			if (z == null)
				return default(T);
			return XmlMapper.CreateAndFill<T>(z._Xml);
		}

		//IConfigurationSectionHandler
		public object Create(object parent, object configContext, System.Xml.XmlNode section)
		{
			_Xml = section;
			return this;
		}
	}
	
	public class TimerHandler
	{
		object Method;
		object[] Param;
		Control _Control;
		System.Timers.Timer _timer = new System.Timers.Timer();

		public void DoAfter(int ms, VoidDelegate method, params object[] param)
		{
			DoAfter(null, ms, (object)method, param);
		}
		public void DoAfter(int ms, ParamDelegate method, params object[] param)
		{
			DoAfter(null, ms, (object)method, param);
		}
		public void DoAfter(Control c, int ms, VoidDelegate method, params object[] param)
		{
			DoAfter(c, ms, (object)method, param);
		}
		public void DoAfter(Control c, int ms, ParamDelegate method, params object[] param)
		{
			DoAfter(c, ms, (object)method, param);
		}
		private void DoAfter(Control c, int ms, object method, params object[] param)
		{
			_Control = c;
			Method = method;
			Param = param;
			_timer.Interval = ms;
			_timer.Elapsed -= Elapsed;
			_timer.Elapsed += Elapsed;
			_timer.Start();
		}

		class ParamEventArgs : EventArgs
		{
			public object[] Param { get; set; }
			public ParamEventArgs(params object[] param)
			{
				Param = param;
			}
		}
		void Elapsed(object sender, System.Timers.ElapsedEventArgs e)
		{
			_timer.Elapsed -= Elapsed;
			_timer.Stop();

			if (_Control != null && _Control.InvokeRequired)
			{
				_Control.Invoke(new System.Timers.ElapsedEventHandler(Elapsed), sender, e);
				return;
			}
			if(Method is ParamDelegate)
				(Method as ParamDelegate)(Param);
			if (Method is VoidDelegate)
				(Method as VoidDelegate)();
		}
	}
}