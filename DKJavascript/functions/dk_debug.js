// shebang
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
//# dk_debug(msg)
//#
//#     Print an debug message to the console
//#
//#     @msg    - The message to print
//#
dk_debug = function dk_debug_f(){
	//dk_debugFunc(1)
	
	if(!dk_valid("dk_log")){
		dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");
	}
	dk_log("DEBUG", arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_debug("test dk_debug DEBUG message");
}
