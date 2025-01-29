dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//################################################################################
//# dk_debug(msg)
//#
//#     Print an debug message to the console
//#
//#     @msg    - The message to print
//#
dk_debug = function dk_debug_f() {
	dk_log("DEBUG", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_debug("test dk_debug DEBUG message");
}
