//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});		}
if(!dk_valid("dk_log"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js", function(){}); }

//################################################################################
//# dk_error(msg)
//#
//#     Print an error message to the console
//#
//#     @msg    - The message to print
//#
dk_error = function dk_error_f(){
	dk_log("ERROR", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_error("test dk_error ERROR message");
}
