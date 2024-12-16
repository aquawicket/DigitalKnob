// C# program to print Hello World! 
using System; 
  
// namespace declaration 
//namespace InputArgs { 
  
// Class declaration 
class DK { 
  
    // Main Method 
    static int Main(string[] args) 
    { 
        //  Invoke this sample with an arbitrary set of command line arguments.
        string[] arguments = Environment.GetCommandLineArgs();
        Console.WriteLine("GetCommandLineArgs: {0}", string.Join(", ", arguments));
			
		// To prevents the screen from 
		// running and closing quickly 
		//Console.ReadKey();
		Console.WriteLine("-2147483648");
		Console.WriteLine("2147483647");
		Console.WriteLine("-1.5");
		Console.WriteLine("-1");
		Console.WriteLine("0");
		Console.WriteLine("1");
		Console.WriteLine("1.5");
		Console.WriteLine("2147483647");
		Console.WriteLine("2147483648");
		Console.WriteLine("string returned from C#");
		int code = -2;
		Environment.Exit( code );
		return code;
    } 
} 
