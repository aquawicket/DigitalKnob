using dk_echo.cs;

public class App{
        
	
	//############################################################################
	//# dk_log(level, message)
	//#
	public static int dk_log(string message){
		//APP2.test();
		//CompileAndRun("dk_echo");
		DK dk = new DK();
		dk.dk_echo("DKTEST() dk_echo()");
		return 0;
	}
	
	//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	[System.STAThread] public static void Main() {
		dk_log("dk_log()");
	}

}
