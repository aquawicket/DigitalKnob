// shebang
//#####################################################################################################
//file:///C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/dk_fileContains.js
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		throw new Error('Program Terminated');
	}
}
//#####################################################################################################


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
