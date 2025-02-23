if(typeof dk_getEnv === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DIGITALKNOB_DIR = function dk_DIGITALKNOB_DIR_f(){
    //dk_debugFunc(0 1);
	console.log("dk_DIGITALKNOB_DIR()")

	//############ SET ############
//	if(arguments[0] !== "undefined"){ 
//		var DKHOME_DIR = "arguments[0]";
//		return;
//	)

	//############ GET ############
	
	//###### WSLPATH_EXE ######
	//dk_set(WSLPATH_EXE   WSL_EXE+" wslpath")
	//dk_printVar(WSLPATH_EXE)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	var DIGITALKNOB_DIR = DKHOME_DIR+"/digitalknob";
	console.log("DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DIGITALKNOB_DIR)
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_DIGITALKNOB_DIR();
	//console.log("dk_DKHOME_DIR:DKTEST()")
	//dk_DKHOME_DIR()
};