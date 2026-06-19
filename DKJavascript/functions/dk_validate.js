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


//if(!dk_valid("DK"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_todo"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_todo.js", function(){});	}

//################################################################################
//# dk_validate(VAR <code>)
//#
//#
dk_validate = function dk_validate_f() {
	//dk_debugFunc(2);
	console.log("dk_validate()");
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	console.log("dk_validate("+_ARGV_+")");
	
	if(!dk_valid(arguments[0])){
		eval(arguments[1]);
	}
	//dk_todo("dk_validate");
};





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myVar;
	dk_validate('myVar', 'myVar = "abc";');
	console.log('myVar = '+myVar);
};
