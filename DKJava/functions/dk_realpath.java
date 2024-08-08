import DKJAVA_FUNCTIONS_DIR.DK;
//#include_guard()

//##################################################################################
//# dk_realpath(path) -> rtn_var
//#
//#    JAVA: https://docs.oracle.com/javase%2F7%2Fdocs%2Fapi%2F/java/nio/file/Path.html#toRealPath(java.nio.file.LinkOption...)
//#
public class Main {
	public static String dk_realpath(path) {
		dk_debugFunc();
		//if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }	
		
		String _realpath_ = path.toRealPath(new LinkOption[0]).toString();
		dk_printVar(_realpath_);
		return _realpath_;
	}






	//####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
	public static void DKTEST() { 
		dk_debugFunc();
		
		String realpath = dk_realpath("bash");
		dk_info("realpath = "+realpath);
	}
}