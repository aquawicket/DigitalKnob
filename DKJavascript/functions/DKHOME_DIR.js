// shebang
//#####################################################################################################
//file:///C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions/dk_fileRead.js
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


//####################################################################
//# DKHOME_DIR()
//#
//#
DKHOME_DIR = function DKHOME_DIR_f(){
    //dk_debugFunc(0 1);
	//console.log("DKHOME_DIR("+args+")");
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("\nDKHOME_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKHOME_DIR = arguments[0];
	} 
		
	//############ GET ############
	else {
		DKHOME_DIR = dk_env("USERPROFILE").replaceAll("\\", "/");
	}

	//###### wslpath_exe ######
	//dk_set(wslpath_exe   wsl_exe+" wslpath")
	//dk_printVar(wslpath_exe)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	//if exist "!wslpath_exe!"        !dk_call! dk_exec "!wslpath_exe! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DKHOME_DIR);
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	//### GET ###
	DKHOME_DIR();
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	//### SET ###
	DKHOME_DIR("C:/Users");
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	//console.log("DKHOME_DIR:DKTEST()")
	//DKHOME_DIR()
};