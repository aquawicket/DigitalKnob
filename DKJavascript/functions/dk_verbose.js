dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//################################################################################
//# dk_verbose(msg)
//#
//#     Print an verbose message to the console
//#
//#     @msg    - The message to print
//#
dk_verbose = function dk_verbose(){
	dk_log("VERBOSE", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_verbose("test dk_verbose VERBOSE message");
}
