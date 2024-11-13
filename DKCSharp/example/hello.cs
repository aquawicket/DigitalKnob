using DK;

public class MyProgram {
	
    public static void Main() {
        var name = Util.GetWho();
		var hw = "hello "+name;
		
		console.dk_echo(hw);
    }
}