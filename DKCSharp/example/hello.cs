using System;
using World;

public class MyProgram {
	
    public static void Main() {
        var name = Util.Name();
		var hw = "hello "+name;
        Console.WriteLine(hw);
    }
}