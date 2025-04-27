//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 			}
//if(!dk_valid("dk_debugFunc"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js"); }
//if(!dk_valid("dk_env"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); 		}
if(!dk_valid("dk_exec"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_exec.js"); 		}
//if(!dk_valid("dk_DKBRANCH_DIR")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKBRANCH_DIR"); }
if(!dk_valid("dk_echo"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js"); 		}


//################################################################################
//# dk_callDKPowershell(function args)
//#
//#		Reference: 	https://stackoverflow.com/q/24148741
//#					https://www.vbsedit.com/html/f3358e96-3d5a-46c2-b43b-3107e586736e.asp
//#
dk_callDKPowershell = function dk_callDKPowershell_f() {
	//dk_debugFunc(1, 99);
	
	func = arguments[0];
	args = arguments[1];
	
	
	//### Get DKC_FUNCTIONS_DIR
	if(!dk_valid("dk_assertPath"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js"); 		}
	dk_assertPath(DKPOWERSHELL_FUNCTIONS_DIR);
	
	
	
	if(!dk_valid("dk_env")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); }
	var ComSpec = dk_env("ComSpec");
	//DKBATCH_FUNCTIONS_DIR_ = dk_env("DKBATCH_FUNCTIONS_DIR_");
	//DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKBatch/functions/";
	
	var DKCOMMAND = ComSpec+' /c powershell.exe -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"';
	dk_exec(DKCOMMAND);
	
	var DKCOMMAND=ComSpec+' /V:ON /c call "'+DKPOWERSHELL_FUNCTIONS_DIR+"/"+func+'.ps1" '+args
	//var DKCOMMAND = 'powershell.exe -Command $global:DKSCRIPT_PATH = "'+DKSCRIPT_PATH+'"; . '+DKPOWERSHELL_FUNCTIONS_DIR+'/'+func+'.ps1; '+func+' "arg 1" "arg 2" "arg3"';//dk_allButFirstArgs;
	console.log("DKCOMMAND = "+DKCOMMAND);
	dk_exec(DKCOMMAND);
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_callDKPowershell('dk_test', '"arg 1" "arg 2" "arg 3"');
	//dk_echo("dk_callDKBatch = "+dk_callDKBatch);
	dk_echo("\n\n");
	dk_echo("  STATUS:  "+dk_exec.status);
	dk_echo("     PID:  "+dk_exec.processId);
	dk_echo("EXITCODE:  "+dk_exec.exitcode);
	dk_echo("  STDOUT:\n"+dk_exec.stdout.toString().replaceAll(",", "\n"));
	dk_echo("  STDERR:\n"+dk_exec.stderr.toString().replaceAll(",", "\n"));
}
