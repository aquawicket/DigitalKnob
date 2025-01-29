dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//################################################################################
//# dk_warning(msg)
//#
//#     Print an warning message to the console
//#
//#     @msg    - The message to print
//#
dk_warning = function dk_warning_f() {
	dk_log("WARNING", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_warning("test dk_warning WARNING message");
}
