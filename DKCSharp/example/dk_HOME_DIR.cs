namespace DK {
    public class dk_DKHOME_DIR {
		
		public static string call() {
			string DKHOME_DIR = System.Environment.GetEnvironmentVariable("USERPROFILE");
			return DKHOME_DIR;
        }
		
		public static void DKTEST() {
			string DKHOME_DIR = call();
			dk_echo.call("DKHOME_DIR = "+DKHOME_DIR);
		}
    }
}