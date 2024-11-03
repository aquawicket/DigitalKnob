using System;

using System.CodeDom.Compiler;
using Microsoft.CSharp;
using System.Reflection;

namespace dynamiccompilation{
    class Program{
        static CompilerParameters CompilerParams = new CompilerParameters{
            GenerateInMemory = true,
            TreatWarningsAsErrors = false,
            GenerateExecutable = false
        };

        static string[] references = { "System.dll", "mscorlib.dll" };
        static CSharpCodeProvider provider = new CSharpCodeProvider();

        static void Main(string[] args){
			string[] arguments = Environment.GetCommandLineArgs();
			System.Console.WriteLine("GetCommandLineArgs: {0}", string.Join(", ", arguments));
			 
            CompilerParams.ReferencedAssemblies.AddRange(references);
			//int returnValue = CompileAndRun("dk_echo");
			//System.Console.WriteLine("returnValue = "+returnValue);
			CompileAndRunDKTEST("dk_echo");
            Console.ReadKey();
        }

        static int CompileAndRun(string funcName) {
            DateTime start = DateTime.Now;
            CompilerResults compile = provider.CompileAssemblyFromFile(CompilerParams, funcName+".cs");
            DateTime compilationFinished = DateTime.Now;
			int returnValue = 0;
            if (compile.Errors.HasErrors) {
                foreach (CompilerError ce in compile.Errors) {
                    Console.WriteLine(ce.ToString());
                }
                Console.ReadKey();
                return -1;
            } else {
                Module module = compile.CompiledAssembly.GetModules()[0];
                returnValue = (int)module.GetType("NAMESPACE.CLASS").GetMethod(funcName).Invoke(null, new object[] {"Hello World!"});
            }
            DateTime executionFinished = DateTime.Now;
            Console.WriteLine("Compile time: {0}", compilationFinished - start);
            Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
			return returnValue;
        }
		
		static void CompileAndRunDKTEST(string funcName) {
            DateTime start = DateTime.Now;
            CompilerResults compile = provider.CompileAssemblyFromFile(CompilerParams, funcName+".cs");
            DateTime compilationFinished = DateTime.Now;
            if (compile.Errors.HasErrors) {
                foreach (CompilerError ce in compile.Errors) {
                    Console.WriteLine(ce.ToString());
                }
                Console.ReadKey();
                return;
            } else {
                Module module = compile.CompiledAssembly.GetModules()[0];
				module.GetType("NAMESPACE.CLASS").GetMethod("DKTEST").Invoke(null, new object[] {});
            }
            DateTime executionFinished = DateTime.Now;
            Console.WriteLine("Compile time: {0}", compilationFinished - start);
            Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
        }
    }
}
