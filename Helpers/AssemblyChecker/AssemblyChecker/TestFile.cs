using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using Overlord.Common.Classes;
using System.ServiceModel;
using System.Runtime.Serialization;

namespace AssemblyChecker
{
	[DataContract]
	class Data
	{
		[DataMember]
		private string Value { get; set; }
	}

	interface INoServiceContract
	{
		StatusReason Check(MemberInfo mi);
	}

	[ServiceContract]
	interface INoNamespace
	{
		StatusReason Check(MemberInfo mi);
	}

	[ServiceContract(Namespace = "tratata-tempuri.org-tratata")]
	interface ITempUri
	{
		StatusReason Check(MemberInfo mi);
	}

	[ServiceContract]
	interface IБэдНейм
	{
		StatusReason Check(MemberInfo mi);
	}

	[ServiceContract]
	interface IStrаngеNаме
	{
		StatusReason Check(MemberInfo mi);
	}
}
