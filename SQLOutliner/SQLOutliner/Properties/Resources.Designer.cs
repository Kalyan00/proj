﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3031
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SQL_Outliner.Properties {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "2.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("SQL_Outliner.Properties.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to &lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-16&quot; standalone=&quot;no&quot;?&gt;
        ///&lt;Extensibility xmlns=&quot;http://schemas.microsoft.com/AutomationExtensibility&quot;&gt;
        ///	&lt;HostApplication&gt;
        ///		&lt;Name&gt;Microsoft Visual Studio&lt;/Name&gt;
        ///		&lt;Version&gt;8.0&lt;/Version&gt;
        ///	&lt;/HostApplication&gt;
        ///	&lt;Addin&gt;
        ///		&lt;FriendlyName&gt;SQL_Outliner&lt;/FriendlyName&gt;
        ///		&lt;Description&gt;SQL_Outliner by Kalyan00 &amp;amp; RIF&lt;/Description&gt;
        ///		&lt;Assembly&gt;{0}&lt;/Assembly&gt;
        ///		&lt;FullClassName&gt;SQL_Outliner.Connect&lt;/FullClassName&gt;
        ///		&lt;LoadBehavior&gt;1&lt;/LoadBehavior&gt;
        ///		&lt;CommandPreload&gt;1&lt;/CommandPrelo [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string AddInFile {
            get {
                return ResourceManager.GetString("AddInFile", resourceCulture);
            }
        }
    }
}