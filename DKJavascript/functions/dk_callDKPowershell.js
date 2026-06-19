// shebang
//file:///C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/dk_callDKPowershell.js
/*
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		//var DK_js = "C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/DK.js";
		//var rtn = wscript_shell.Run("cmd /k cscript.exe //D //X //NoLogo "+DK_js+" "+WScript.ScriptFullName, 1, 1);
		//wscript_shell.Run("cmd /k mshta.exe \"javascript:new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write('Hello World');\" | for /f \"delims=\" %a in ('findstr \"^\"') do @echo %a", 1, 1);
	}
}
*/
//################################################################################


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
	
	
	//### Get DKPOWERSHELL_FUNCTIONS_DIR
	if(!dk_valid("dk_assertPath"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js"); 		}
	dk_assertPath(DKPOWERSHELL_FUNCTIONS_DIR);
	
	
	
	if(!dk_valid("dk_env")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js"); }
	var ComSpec = dk_env("ComSpec");
	//DKBATCH_FUNCTIONS_DIR_ = dk_env("DKBATCH_FUNCTIONS_DIR_");
	//DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/DigitalKnob/Development/DKBatch/functions/";
	
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
