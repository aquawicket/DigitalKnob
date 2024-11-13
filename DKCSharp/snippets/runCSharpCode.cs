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
            CompilerParams.ReferencedAssemblies.AddRange(references);
            CompileAndRun(new string[] {
                "using System;" +
                "namespace NAMESPACE {" +
                "   public class CLASS {" +
                "       static public void Main() {" +
                "           System.Console.WriteLine(\"The time is now {0}.\", System.DateTime.Now);" +
                "       }" +
                "   }" +
                "}"});
            Console.ReadKey();
        }

        static void CompileAndRun(string[] code) {
            DateTime start = DateTime.Now;
            CompilerResults compile = provider.CompileAssemblyFromSource(CompilerParams, code);
            DateTime compilationFinished = DateTime.Now;
            if (compile.Errors.HasErrors) {
                foreach (CompilerError ce in compile.Errors) {
                    Console.WriteLine(ce.ToString());
                }
                Console.ReadKey();
                return;
            } else {
                Module module = compile.CompiledAssembly.GetModules()[0];
                module
                    .GetType("NAMESPACE.CLASS")
                    .GetMethod("Main")
                    .Invoke(null, new object[] { });
            }
            DateTime executionFinished = DateTime.Now;
			TimeSpan compile_time = compilationFinished - start;
			TimeSpan execution_time = executionFinished - compilationFinished;
            Console.WriteLine("Compile time: {0}", compile_time);
            Console.WriteLine("Execution time: {0}", execution_time);
        }
    }
}
