//################################################################################
//# dk_test()
//#
//#
dk_test = function() {
	//dk_debugFunc(0);
	
	console.log("################# dk_test.cmd ################");
	console.log("                     0 = %~0")
	console.log("                     1 = %~1")
	console.log("                     2 = %~2")
	console.log("                     3 = %~3")
	console.log("                     4 = %~4")
	console.log("                     5 = %~5")
	console.log("                     6 = %~6")
	console.log("                     7 = %~7")
	console.log("                     8 = %~8")
	console.log("                     9 = %~9")	
	console.log("                     * = %*")
	console.log("            ERRORLEVEL = %ERRORLEVEL%")
	console.log("                   LVL = %LVL%")
	console.log("              __TIME__ = %__TIME__%")
	console.log("              __CMND__ = %__CMND__%")
	console.log("              __FILE__ = %__FILE__%")
	console.log("              __LINE__ = %__LINE__%")
	console.log("              __FUNC__ = %__FUNC__%")
	console.log("              __ARGC__ = %__ARGC__%")
	console.log("              __ARGV__ = %__ARGV__%")
	console.log("         DKSCRIPT_PATH = %DKSCRIPT_PATH%")
	console.log("          DKSCRIPT_DIR = %DKSCRIPT_DIR%")
	console.log("         DKSCRIPT_FILE = %DKSCRIPT_FILE%")
	console.log("         DKSCRIPT_NAME = %DKSCRIPT_NAME%")
	console.log("          DKSCRIPT_EXT = %DKSCRIPT_EXT%")
	console.log("         DKSCRIPT_ARGS = %DKSCRIPT_ARGS%")
	console.log("            DKHOME_DIR = %DKHOME_DIR%")
	console.log("           DKCACHE_DIR = %DKCACHE_DIR%")
	console.log("         DKDESKTOP_DIR = %DKDESKTOP_DIR%")
	console.log("           DIGITALKNOB = %DIGITALKNOB%")
	console.log("       DIGITALKNOB_DIR = %DIGITALKNOB_DIR%")
	console.log("        DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%")
	console.log("           DKTOOLS_DIR = %DKTOOLS_DIR%")
	console.log("              DKBRANCH = %DKBRANCH%")
	console.log("          DKBRANCH_DIR = %DKBRANCH_DIR%")
	console.log("        DK3RDPARTY_DIR = %DK3RDPARTY_DIR%")
	console.log("            DKAPPS_DIR = %DKAPPS_DIR%")
	console.log("            DKBASH_DIR = %DKBASH_DIR%")
	console.log("  DKBASH_FUNCTIONS_DIR = %DKBASH_FUNCTIONS_DIR%")
	console.log(" DKBASH_FUNCTIONS_DIR_ = %DKBASH_FUNCTIONS_DIR_%")

	//setGlobal GLOBAL_VAR "This is a global variable"
	//setReturn RETURN_VAR "This is a return variable"

	//var GLOBAL_VAR = %GLOBAL_VAR%
	//var RETURN_VAR = %RETURN_VAR%
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	dk_test("from :DKTEST" "to dk_test");
//	echo:
//	echo GLOBAL_VAR = %GLOBAL_VAR%
//	echo RETURN_VAR = %RETURN_VAR%
//
//	Test::dk_test "from :DKTEST" "to Test::dk_test"
//	echo:
//	echo GLOBAL_VAR = %GLOBAL_VAR%
//	echo RETURN_VAR = %RETURN_VAR%
//
//	Test::Test::dk_test "from :DKTEST" "to Test::Test::dk_test"
//	echo:
//	echo GLOBAL_VAR = %GLOBAL_VAR%
//	echo RETURN_VAR = %RETURN_VAR%
}