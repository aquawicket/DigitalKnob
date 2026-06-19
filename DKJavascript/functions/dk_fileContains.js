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



//##################################################################################
//# dk_fileContains(file, string)
//#
//#
dk_fileContains() {
	//dk_debugFunc(2);

	// TODO
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	//dk_debugFunc(0);
	
	dk_fileWrite("fileContains_TEST.txt" "find the needle in the haystack");
	
	if(dk_fileContains("fileContains_TEST.txt" "needle"){
		dk_echo("The file contains the string");
	} else {
		dk_echo("The file does NOT contain the string");
	}
	
	if(dk_fileContains "fileContains_TEST.txt" "nope")
		dk_echo("The file contains the string");
	} else {
		dk_echo("The file does NOT contain the string");
	}
}






