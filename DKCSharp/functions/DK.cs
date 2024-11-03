using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Net;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

namespace DK {
	public class App{
        static void Main(string[] args){
			Console.WriteLine("DK.cs");
			dk_source("dk_helloWorld");
		}

		static void dk_source(string func){ 
			Dictionary<string, string> providerOptions = new Dictionary<string, string>{ {"CompilerVersion", "v4.0"} };
			CSharpCodeProvider provider = new CSharpCodeProvider(providerOptions);
			CompilerParameters compilerParams = new CompilerParameters{GenerateInMemory = true, GenerateExecutable = false};
			CompilerResults results = provider.CompileAssemblyFromFile(compilerParams, func+".cs");
			if (results.Errors.Count != 0)
				throw new Exception("Mission failed!");
			object o = results.CompiledAssembly.CreateInstance("Foo.Bar");
			MethodInfo mi = o.GetType().GetMethod(func);
			mi.Invoke(o, null);
		}
	}
}