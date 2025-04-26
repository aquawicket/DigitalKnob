//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_echo")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js", function(){}); 	}

//################################################################################
//# dk_exit(msg)
//#
//#
dk_exit = function dk_exit_f(){
	dk_echo("dk_exit()");
	die();
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_exit();
	
	//dk_echo("...SHOULD NOT GET HERE...");
}
