//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});		}
if(!dk_valid("dk_log"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js", function(){}); }

//################################################################################
//# dk_todo(msg)
//#
//#     Print an info message to the console
//#
//#     @msg    - The message to print
//#
dk_todo = function dk_todo_f(){
	dk_log("TODO", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_todo("test dk_todo INFO message");
}
