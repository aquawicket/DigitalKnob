using System;

using System.CodeDom.Compiler;
using Microsoft.CSharp;
using System.Reflection;

namespace DKAPP{ 
public class MAIN{

	//public MAIN myObj = new MAIN();
	public static string DKSCRIPT_PATH = "";
	public static string DKSCRIPT_DIR = "";
	public static string DKSCRIPT_FILE = "";
	public static string DKSCRIPT_NAME = "";
	public static string DKSCRIPT_EXT = "";

	public static CompilerParameters CompilerParams = new CompilerParameters{
		GenerateInMemory = true,
		TreatWarningsAsErrors = false,
		GenerateExecutable = false
	};

	public static string[] references = { "System.dll", "mscorlib.dll" };
	public static CSharpCodeProvider provider = new CSharpCodeProvider();

	//############################################################################
	//# Main(args)
	//#
	public static void Main(string[] args){
		string[] arguments = Environment.GetCommandLineArgs();
		//System.Console.WriteLine("GetCommandLineArgs: {0}", string.Join(", ", arguments));

		MAIN.DKSCRIPT_PATH = System.IO.Path.GetFullPath(arguments[0]);
		System.Console.WriteLine("DKSCRIPT_PATH = "+MAIN.DKSCRIPT_PATH);

		MAIN.DKSCRIPT_DIR = System.IO.Path.GetDirectoryName(MAIN.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_DIR = "+MAIN.DKSCRIPT_DIR);

		MAIN.DKSCRIPT_FILE = System.IO.Path.GetFileName(MAIN.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_FILE = "+MAIN.DKSCRIPT_FILE);

		MAIN.DKSCRIPT_NAME = System.IO.Path.GetFileNameWithoutExtension(MAIN.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_NAME = "+MAIN.DKSCRIPT_NAME);

		MAIN.DKSCRIPT_EXT = System.IO.Path.GetExtension(MAIN.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_EXT = "+MAIN.DKSCRIPT_EXT);

		CompilerParams.ReferencedAssemblies.AddRange(references);
		//int returnValue = CompileAndRun(DKSCRIPT_NAME);
		//System.Console.WriteLine("returnValue = "+returnValue);
		CompileAndRunDKTEST(MAIN.DKSCRIPT_NAME);
		Console.ReadKey();
	}

	//############################################################################
	//# CompileAndRun(funcName)
	//#
	public static int CompileAndRun(string funcName) {
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
			returnValue = (int)module.GetType("DK.APP").GetMethod(funcName).Invoke(null, new object[] {"Hello World!"});
		}
		DateTime executionFinished = DateTime.Now;
		Console.WriteLine("Compile time: {0}", compilationFinished - start);
		Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
		return returnValue;
	}

	//############################################################################
	//# CompileAndRunDKTEST(funcName)
	//#
	public static void CompileAndRunDKTEST(string funcName) {
		Console.WriteLine("");
		Console.BackgroundColor = ConsoleColor.Magenta;
		Console.ForegroundColor = ConsoleColor.White;
		Console.WriteLine("###### DKTEST MODE ###### "+ MAIN.DKSCRIPT_FILE +" ###### DKTEST MODE ########");
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
			module.GetType("DK.APP").GetMethod("DKTEST").Invoke(null, new object[] {});
		}
		DateTime executionFinished = DateTime.Now;
		Console.WriteLine("");
		Console.WriteLine("Compile time: {0}", compilationFinished - start);
		Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
		Console.WriteLine("");
		Console.BackgroundColor = ConsoleColor.Magenta;
		Console.ForegroundColor = ConsoleColor.White;
		Console.WriteLine("######## END TEST ####### "+ MAIN.DKSCRIPT_FILE +" ######## END TEST #########");
		Console.BackgroundColor = ConsoleColor.Black;
		Console.ForegroundColor = ConsoleColor.White;
		Console.WriteLine("");
	}
}
}
