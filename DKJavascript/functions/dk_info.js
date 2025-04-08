dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//################################################################################
//# dk_info(msg)
//#
//#     Print an info message to the console
//#
//#     @msg    - The message to print
//#
dk_info = function dk_info_f(){
	dk_log("INFO", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_info("test dk_info INFO message");
}
