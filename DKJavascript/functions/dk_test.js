//################################################################################
//# dk_test()
//#
//#
dk_test = function dk_test_f(){
	//dk_debugFunc(0);
	
	console.log("################# dk_test.cmd ################");
	console.log("               ARGV(0) = "+ARGV(0));
//if(typeof ARGV(1)) !== "undefined"){ console.log("              ARGV(1) = "+ARGV(1)); }
/*	console.log("               ARGV(0) = "+ARGV(2));
	console.log("               ARGV(0) = "+ARGV(3));
	console.log("               ARGV(0) = "+ARGV(4));
	console.log("               ARGV(0) = "+ARGV(5));
	console.log("               ARGV(0) = "+ARGV(6));
	console.log("               ARGV(0) = "+ARGV(7));
	console.log("               ARGV(0) = "+ARGV(8));
	console.log("               ARGV(0) = "+ARGV(9));
	console.log("          arguments[0] = "+arguments[0]);
	console.log("          arguments[1] = "+arguments[1]);
	console.log("          arguments[2] = "+arguments[2]);
	console.log("          arguments[3] = "+arguments[3]);
	console.log("          arguments[4] = "+arguments[4]);
	console.log("          arguments[5] = "+arguments[5]);
	console.log("          arguments[6] = "+arguments[6]);
	console.log("          arguments[7] = "+arguments[7]);
	console.log("          arguments[8] = "+arguments[8]);
	console.log("          arguments[9] = "+arguments[9]);
//	console.log("            ERRORLEVEL = "+ERRORLEVEL);
//	console.log("                   LVL = "+LVL);
//	console.log("              __TIME__ = "+__TIME__);
//	console.log("              __CMND__ = "+__CMND__);
//	console.log("              __FILE__ = "+__FILE__);
//	console.log("              __LINE__ = "+__LINE__);
//	console.log("              __FUNC__ = "+__FUNC__);
//	console.log("              __ARGC__ = "+__ARGC__);
//	console.log("              __ARGV__ = "+__ARGV__);
	console.log("         DKSCRIPT_PATH = "+DKSCRIPT_PATH);
	console.log("          DKSCRIPT_DIR = "+DKSCRIPT_DIR);
	console.log("         DKSCRIPT_FILE = "+DKSCRIPT_FILE);
	console.log("         DKSCRIPT_NAME = "+DKSCRIPT_NAME);
	console.log("          DKSCRIPT_EXT = "+DKSCRIPT_EXT);
//	console.log("         DKSCRIPT_ARGS = "+DKSCRIPT_ARGS);
	console.log("            DKHOME_DIR = "+DKHOME_DIR);
	console.log("           DKCACHE_DIR = "+DKCACHE_DIR);
	console.log("         DKDESKTOP_DIR = "+DKDESKTOP_DIR);
	console.log("           DIGITALKNOB = "+DIGITALKNOB);
	console.log("       DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);
	console.log("        DKDOWNLOAD_DIR = "+DKDOWNLOAD_DIR);
	console.log("           DKTOOLS_DIR = "+DKTOOLS_DIR);
	console.log("              DKBRANCH = "+DKBRANCH);
	console.log("          DKBRANCH_DIR = "+DKBRANCH_DIR);
	console.log("        DK3RDPARTY_DIR = "+DK3RDPARTY_DIR);
	console.log("            DKAPPS_DIR = "+DKAPPS_DIR);
	console.log("            DKBASH_DIR = "+DKBASH_DIR);
	console.log("  DKBASH_FUNCTIONS_DIR = "+DKBASH_FUNCTIONS_DIR);
	console.log(" DKBASH_FUNCTIONS_DIR_ = "+DKBASH_FUNCTIONS_DIR_);

*/	//setGlobal GLOBAL_VAR "This is a global variable"
	//setReturn RETURN_VAR "This is a return variable"

	//var GLOBAL_VAR = %GLOBAL_VAR%
	//var RETURN_VAR = %RETURN_VAR%
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_test("from :DKTEST", "to dk_test");
	console.log("")
	//console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	//console.log("RETURN_VAR = "+RETURN_VAR)

//	Test::dk_test("from :DKTEST", "to Test::dk_test")
	console.log("")
/*	console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	console.log("RETURN_VAR = "+RETURN_VAR)

	Test::Test::dk_test("from :DKTEST", "to Test::Test::dk_test")
	console.log("")
	console.log("GLOBAL_VAR = "+GLOBAL_VAR)
	console.log("RETURN_VAR = "+RETURN_VAR)
*/
}