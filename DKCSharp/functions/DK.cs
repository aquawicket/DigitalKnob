using System;					// https://learn.microsoft.com/en-us/dotnet/api/system?view=net-8.0
using System.CodeDom.Compiler;	// https://learn.microsoft.com/en-us/dotnet/api/system.codedom.compiler?view=net-8.0
using Microsoft.CSharp;			// https://learn.microsoft.com/en-us/dotnet/api/microsoft.csharp?view=net-8.0
using System.Reflection;		// https://learn.microsoft.com/en-us/dotnet/api/system.reflection?view=net-8.0



namespace DKAPP{ 
public class APP{

	public static string DKSCRIPT_PATH = "";
	public static string DKSCRIPT_DIR = "";
	public static string DKSCRIPT_FILE = "";
	public static string DKSCRIPT_NAME = "";
	public static string DKSCRIPT_EXT = "";

	public static CompilerParameters CompilerParams = new CompilerParameters{
		CompilerOptions = "/optimize",
		GenerateExecutable = false,
		GenerateInMemory = true,
		IncludeDebugInformation = true,
		//MainClass = "APP",
		//OutputAssembly = exeFile,
		//ReferencedAssemblies.Add( "System.dll" ),
		//ReferencedAssemblies.Add( "mscorlib.dll" ),
		//TempFiles = new TempFileCollection(".", true),
		TreatWarningsAsErrors = false,
		WarningLevel = 3
	};

	public static string[] references = { "System.dll", "mscorlib.dll" };
	public static CSharpCodeProvider provider = new CSharpCodeProvider();

	//############################################################################
	//# Main(args)
	//#
	public static void Main(string[] args){
		string[] arguments = Environment.GetCommandLineArgs();
		//System.Console.WriteLine("GetCommandLineArgs: {0}", string.Join(", ", arguments));

		APP.DKSCRIPT_PATH = System.IO.Path.GetFullPath(arguments[0]);
		System.Console.WriteLine("DKSCRIPT_PATH = "+APP.DKSCRIPT_PATH);

		APP.DKSCRIPT_DIR = System.IO.Path.GetDirectoryName(APP.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_DIR = "+APP.DKSCRIPT_DIR);

		APP.DKSCRIPT_FILE = System.IO.Path.GetFileName(APP.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_FILE = "+APP.DKSCRIPT_FILE);

		APP.DKSCRIPT_NAME = System.IO.Path.GetFileNameWithoutExtension(APP.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_NAME = "+APP.DKSCRIPT_NAME);

		APP.DKSCRIPT_EXT = System.IO.Path.GetExtension(APP.DKSCRIPT_PATH);
		System.Console.WriteLine("DKSCRIPT_EXT = "+APP.DKSCRIPT_EXT);

		CompilerParams.ReferencedAssemblies.AddRange(references);
		
		//int returnValue = CompileAndRun(DKSCRIPT_NAME);
		//System.Console.WriteLine("returnValue = "+returnValue);
		
		CompileAndRunDKTEST(APP.DKSCRIPT_NAME);
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
		Console.WriteLine("###### DKTEST MODE ###### "+ APP.DKSCRIPT_FILE +" ###### DKTEST MODE ########");
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
			module.GetType("APP").GetMethod("DKTEST").Invoke(null, new object[] {});
		}
		DateTime executionFinished = DateTime.Now;
		Console.WriteLine("");
		Console.WriteLine("Compile time: {0}", compilationFinished - start);
		Console.WriteLine("Execution time: {0}", executionFinished - compilationFinished);
		Console.WriteLine("");
		Console.BackgroundColor = ConsoleColor.Magenta;
		Console.ForegroundColor = ConsoleColor.White;
		Console.WriteLine("######## END TEST ####### "+ APP.DKSCRIPT_FILE +" ######## END TEST #########");
		Console.BackgroundColor = ConsoleColor.Black;
		Console.ForegroundColor = ConsoleColor.White;
		Console.WriteLine("");
	}
}
}
