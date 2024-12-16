using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Net;
using Microsoft.CSharp;
using System.CodeDom.Compiler;

namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {
            string source =
            @"
namespace Foo
{
    public class Bar
    {
        public void SayHello()
        {
            System.Console.WriteLine(""Hello World"");
        }
    }
}
            ";

            Dictionary<string, string> providerOptions = new Dictionary<string, string>{
				{"CompilerVersion", "v4.0"}
            };
            CSharpCodeProvider provider = new CSharpCodeProvider(providerOptions);
            CompilerParameters compilerParams = new CompilerParameters{GenerateInMemory = true, GenerateExecutable = false};
            CompilerResults results = provider.CompileAssemblyFromSource(compilerParams, source);
            if (results.Errors.Count != 0)
                throw new Exception("Mission failed!");
            object o = results.CompiledAssembly.CreateInstance("Foo.Bar");
            MethodInfo mi = o.GetType().GetMethod("SayHello");
            mi.Invoke(o, null);
        }
    }
}