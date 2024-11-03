using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Net;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

namespace DK{
    class App{
        static void Main(string[] args){
            Dictionary<string, string> providerOptions = new Dictionary<string, string>{ {"CompilerVersion", "v4.0"} };
            CSharpCodeProvider provider = new CSharpCodeProvider(providerOptions);
            CompilerParameters compilerParams = new CompilerParameters{GenerateInMemory = true, GenerateExecutable = false};
            CompilerResults results = provider.CompileAssemblyFromFile(compilerParams, "dk_helloWorld.cs");
            if (results.Errors.Count != 0)
                throw new Exception("Mission failed!");
            object o = results.CompiledAssembly.CreateInstance("Foo.Bar");
            MethodInfo mi = o.GetType().GetMethod("dk_helloWorld");
            mi.Invoke(o, null);
        }
    }
}