using DK;
using System;
using System.Reflection;

public class APP {
	
    public static void Main() {
		
		string filename = System.Diagnostics.Process.GetCurrentProcess().MainModule.FileName;
		string name = System.IO.Path.GetFileNameWithoutExtension(filename);
		dk_echo.call("name = "+name+"\n");
		
		//DK.name.DKTEST();
		Type t = System.Type.GetType(name);
		MethodInfo method = t.GetMethod("DKTEST", BindingFlags.Static | BindingFlags.Public);
        method.Invoke(null, null);
    }
}