using System;
using DK;

public class MyProgram {
	
    public static void Main() {
        var name = Util.GetWho();
		var hw = "hello "+name;
		
        //Console.WriteLine(hw);
		dk.dk_echo(hw);
    }
}