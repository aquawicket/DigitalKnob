using System;

using System.CodeDom.Compiler;
using Microsoft.CSharp;
using System.Reflection;

namespace dynamiccompilation{
    class APP{

        static CompilerParameters CompilerParams = new CompilerParameters{
            GenerateInMemory = true,
            TreatWarningsAsErrors = false,
            GenerateExecutable = false
        };

        static string[] references = { "System.dll", "mscorlib.dll" };
        static CSharpCodeProvider provider = new CSharpCodeProvider();
		
		public static class Global{
			public static string DKSCRIPT_PATH = "";
			public static string DKSCRIPT_DIR = "";
			public static string DKSCRIPT_FILE = "";
			public static string DKSCRIPT_NAME = "";
			public static string DKSCRIPT_EXT = "";
		}

        static void Main(string[] args){
			string[] arguments = Environment.GetCommandLineArgs();
			//System.Console.WriteLine("GetCommandLineArgs: {0}", string.Join(", ", arguments));
			
			Global.DKSCRIPT_PATH = System.IO.Path.GetFullPath(arguments[0]);
			System.Console.WriteLine("DKSCRIPT_PATH = "+Global.DKSCRIPT_PATH);
			
			Global.DKSCRIPT_DIR = System.IO.Path.GetDirectoryName(Global.DKSCRIPT_PATH);
			System.Console.WriteLine("DKSCRIPT_DIR = "+Global.DKSCRIPT_DIR);
			
			Global.DKSCRIPT_FILE = System.IO.Path.GetFileName(Global.DKSCRIPT_PATH);
			System.Console.WriteLine("DKSCRIPT_FILE = "+Global.DKSCRIPT_FILE);
			
			Global.DKSCRIPT_NAME = System.IO.Path.GetFileNameWithoutExtension(Global.DKSCRIPT_PATH);
			System.Console.WriteLine("DKSCRIPT_NAME = "+Global.DKSCRIPT_NAME);
			
			Global.DKSCRIPT_EXT = System.IO.Path.GetExtension(Global.DKSCRIPT_PATH);
			System.Console.WriteLine("DKSCRIPT_EXT = "+Global.DKSCRIPT_EXT);
			
            CompilerParams.ReferencedAssemblies.AddRange(references);
			//int returnValue = CompileAndRun(DKSCRIPT_NAME);
			//System.Console.WriteLine("returnValue = "+returnValue);
			CompileAndRunDKTEST(Global.DKSCRIPT_NAME);
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
		
		/*
		Black
		DarkBlue
		DarkGreen
		DarkCyan
		DarkRed
		DarkMagenta
		DarkYellow
		Gray
		DarkGray
		Blue
		Green
		Cyan
		Red
		Magenta
		Yellow
		White
		Black
		DarkBlue
		DarkGreen
		DarkCyan
		DarkRed
		DarkMagenta
		DarkYellow
		Gray
		DarkGray
		Blue
		Green
		Cyan
		Red
		Magenta
		Yellow
		White
		*/
		static void CompileAndRunDKTEST(string funcName) {
			Console.WriteLine("");
			Console.BackgroundColor = ConsoleColor.Magenta;
			Console.ForegroundColor = ConsoleColor.White;
			Console.WriteLine("###### DKTEST MODE ###### "+ Global.DKSCRIPT_FILE +" ###### DKTEST MODE ########");
			Console.BackgroundColor = ConsoleColor.Black;
			Console.ForegroundColor = ConsoleColor.White;
			Console.WriteLine("");
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
            Console.WriteLine("");
			Console.WriteLine("Compile time: {0}", compilationFinished - start);
            Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
			Console.WriteLine("");
			Console.BackgroundColor = ConsoleColor.Magenta;
			Console.ForegroundColor = ConsoleColor.White;
			Console.WriteLine("######## END TEST ####### "+ Global.DKSCRIPT_FILE +" ######## END TEST #########");
			Console.BackgroundColor = ConsoleColor.Black;
			Console.ForegroundColor = ConsoleColor.White;
			Console.WriteLine("");
        }
    }
}
