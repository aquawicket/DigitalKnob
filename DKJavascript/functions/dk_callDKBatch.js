//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 			}
if(!dk_valid("dk_debugFunc"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js"); }
if(!dk_valid("dk_env"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); 		}
if(!dk_valid("dk_exec"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_exec.js"); 		}
if(!dk_valid("dk_DKBRANCH_DIR")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKBRANCH_DIR"); }
if(!dk_valid("dk_echo"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js"); 		}


//################################################################################
//# dk_callDKBatch(function args)
//#
//#		Reference: 	https://stackoverflow.com/q/24148741
//#					https://www.vbsedit.com/html/f3358e96-3d5a-46c2-b43b-3107e586736e.asp
//#
dk_callDKBatch = function dk_callDKBatch_f() {
	//dk_debugFunc(1, 99);
	
	func = arguments[0];
	args = arguments[1];
	
	COMSPEC = dk_env("COMSPEC");
	//DKBATCH_FUNCTIONS_DIR_ = dk_env("DKBATCH_FUNCTIONS_DIR_");
	DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKBatch/functions/";
	dk_exec(COMSPEC+" /V:ON /c call "+DKBATCH_FUNCTIONS_DIR_+func+".cmd "+args);
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_callDKBatch('dk_test', '"arg 1" "arg 2" "arg 3"');
	//dk_echo("dk_callDKBatch = "+dk_callDKBatch);
}
