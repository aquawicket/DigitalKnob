// C# program to print Hello World! 
using System; 
using System.IO;

// Class declaration 
class DK { 
  
    // Main Method 
    static int Main(string[] args) { 
        // string[] arguments = Environment.GetCommandLineArgs();
        // Console.WriteLine("Main({0})", string.Join(", ", arguments));
			
		// Check if file exists
		string file = "C:\\Windows\\System32\\cmd.exe";
		bool exists = File.Exists(file);
		Console.WriteLine("{0} exists = {1}", file, exists);

		return 0;
    } 
} 
