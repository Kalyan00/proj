using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Overlord.Common.Classes;
using System.Reflection;
using System.ServiceModel;
using System.Text.RegularExpressions;
using System.Runtime.Serialization;

namespace AssemblyChecker
{
	internal class MemberChecker
	{
		public MemberChecker()
		{
			NamePattern = @"[A-Za-z<_][A-Za-z0-9_~`>]*";
		}
		
		public string NamePattern { get; set; }

		public void CheckFile(string path, StatusReason reason)
		{
			try
			{
				var assembly = Assembly.LoadFrom(path);
				foreach (var module in assembly.GetModules())
				{
					foreach (var type in module.GetTypes())
					{
						ValidateType(type, reason);
 					}
				}
			}
			catch(Exception exc)
			{
				reason.AddError(exc.Message);
			}
		}

		private void ValidateType(Type type, StatusReason reason)
		{
			ValidateName(type, reason);

			if (type.IsInterface)
				ValidateInterface(type, reason);
			else
				ValidateClass(type, reason);

			foreach (var item in type.GetMembers(BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly))
				ValidateMember(item, reason);
		}
		private void ValidateClass(Type type, StatusReason reason)
		{
			var attrDC = GetAttribute<DataContractAttribute>(type);
			if (attrDC == null)
				reason.AddError("No [DataContract] for class " + GetTypeName(type));
			else
			{
				if (string.IsNullOrEmpty(attrDC.Namespace))
					reason.AddError("No [DataContract.Namespace] for class " + GetTypeName(type));
				else if (attrDC.Namespace.Contains("tempuri"))
					reason.AddError("Bad [DataContract.Namespace] for class " + GetTypeName(type) + " (contains tempuri)");
			}
		}
		private void ValidateInterface(Type type, StatusReason reason)
		{
			var attrSC = GetAttribute<ServiceContractAttribute>(type);
			if (attrSC == null)
				reason.AddError("No [ServiceContract] for interface " + GetTypeName(type));
			else
			{
				if (string.IsNullOrEmpty(attrSC.Namespace))
					reason.AddError("No [ServiceContract.Namespace] for interface " + GetTypeName(type));
				else if(attrSC.Namespace.Contains("tempuri"))
					reason.AddError("Bad [ServiceContract.Namespace] for interface " + GetTypeName(type) + " (contains tempuri)");
			}
		}
		private void ValidateMember(MemberInfo member, StatusReason reason)
		{
			ValidateName(member, reason);

			if (member.DeclaringType.IsInterface)
			{
				var attrOP = GetAttribute<OperationContractAttribute>(member);
				if (attrOP == null)
				{
					if(!member.ReflectedType.IsNotPublic)
						reason.AddError("No [OperationContract] for member " + member.DeclaringType + "." + member.Name);
				}
				else
				{
					if (member.ReflectedType.IsNotPublic)
						reason.AddError("No PUBLIC for member " + member.DeclaringType + "." + member.Name + " (but marked with [OperationContract])");
				}
			}
			else if(member.MemberType == MemberTypes.Property)
			{
				if (!IsDataMember(member))
				{
					if (!member.ReflectedType.IsNotPublic)
						reason.AddError("No [DataMember | EnumMember] for member " + member.DeclaringType + "." + member.Name);
				}
				else
				{
					if (member.ReflectedType.IsNotPublic)
						reason.AddError("No PUBLIC for member " + member.DeclaringType + "." + member.Name + " (but marked with [DataMember | EnumMember])");
				}
			}
		}
		private void ValidateName(Type type, StatusReason reason)
		{
			var r = new Regex(NamePattern);
			var match = r.Match(type.Name);

			if (match.Value != type.Name)
				reason.AddError("Invalid name " + GetTypeName(type) + " near [" + match.Value + "]");
		}
		private void ValidateName(MemberInfo member, StatusReason reason)
		{
			if (member.Name == ".ctor" ||
				member.Name == ".cctor" ||
				member.Name.StartsWith("get_") ||
				member.Name.StartsWith("set_") ||
				member.Name.StartsWith("add_") ||
				member.Name.StartsWith("remove_")
				)
				return;

			var r = new Regex(NamePattern);
			var match = r.Match(member.Name);

			if (match.Value != member.Name)
				reason.AddError("Invalid name " + member.DeclaringType.FullName + "." + member.Name + " near [" + match.Value + "].");
		}

		private bool IsDataMember(ICustomAttributeProvider provider)
		{
			return
				GetAttribute<DataMemberAttribute>(provider) != null ||
				GetAttribute<EnumMemberAttribute>(provider) != null;
		}
		private string GetTypeName(Type type)
		{
			return type.FullName;
		}
		private T GetAttribute<T>(ICustomAttributeProvider provider) where T : Attribute
		{
			var attrs = provider.GetCustomAttributes(typeof(T), false);
			if (attrs == null || attrs.Length < 1)
				return null;

			return (T)attrs[0];
		}
	}
}
