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
//# dk_debugFunc()
//#
//#
dk_debugFunc = function dk_debugFunc_f() {
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_debugFunc("+_ARGV_+")");
	
	//TODO
}













//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	dk_debugFunc(0);
	
	console.log("dk_debugFunc Test");
}
