//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 			}
//if(!dk_valid("dk_debugFunc"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js"); }
//if(!dk_valid("dk_env"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); 		}
if(!dk_valid("dk_exec"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_exec.js"); 		}
//if(!dk_valid("dk_DKBRANCH_DIR")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKBRANCH_DIR"); }
if(!dk_valid("dk_echo"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js"); 		}


//################################################################################
//# dk_callDKPhp(function args)
//#
//#		Reference: 	https://stackoverflow.com/q/24148741
//#					https://www.vbsedit.com/html/f3358e96-3d5a-46c2-b43b-3107e586736e.asp
//#
dk_callDKPhp = function dk_callDKPhp_f() {
	//dk_debugFunc(1, 99);
	
	func = arguments[0];
	args = arguments[1];
	
	//### Get DKPHP_FUNCTIONS_DIR
	if(!dk_valid("dk_assertPath"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js"); 		}
	dk_assertPath(DKPHP_FUNCTIONS_DIR);
	
	if(!dk_valid("dk_env")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); }
	var ComSpec = dk_env("ComSpec");
	
	//dk_exec(ComSpec+' /V:ON /c call "'+DKIMPORTS_DIR+'/php-src/DKINSTALL"');
	//PHP_EXE = dk_env('PHP_EXE');
	
	//DKBATCH_FUNCTIONS_DIR_ = dk_env("DKBATCH_FUNCTIONS_DIR_");
	//DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKBatch/functions/";
	
	dk_assertPath(ComSpec);
	//dk_assertPath(PHP_EXE);
	dk_assertPath(DKPHP_FUNCTIONS_DIR);
	//dk_assertVar(func);
	
	var DKCOMMAND=ComSpec+' /V:ON /c call "'+DKPHP_FUNCTIONS_DIR+'/'+func+'.php" '+args;
	//var DKCOMMAND = ComSpec+' /V:ON /c call '+PHP_EXE+' '+DKPHP_FUNCTIONS_DIR+'/'+func+'.php'; //dk_allButFirstArgs
	console.log("DKCOMMAND = "+DKCOMMAND);
	//dk_exec(DKCOMMAND);
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_callDKPhp('dk_test', '"arg 1" "arg 2" "arg 3"');
	dk_echo("\n\n");
	dk_echo("  STATUS:  "+dk_exec.status);
	dk_echo("     PID:  "+dk_exec.processId);
	dk_echo("EXITCODE:  "+dk_exec.exitcode);
	dk_echo("  STDOUT:\n"+dk_exec.stdout.toString().replaceAll(",", "\n"));
	dk_echo("  STDERR:\n"+dk_exec.stderr.toString().replaceAll(",", "\n"));
}
