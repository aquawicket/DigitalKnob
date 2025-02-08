if(typeof dk_getEnv === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKHOME_DIR = function dk_DKHOME_DIR_f(){
    //dk_debugFunc(0 1);
	console.log("dk_DKHOME_DIR()")

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
	
	var DKHOME_DIR = dk_getEnv("%USERPROFILE%");
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DKHOME_DIR)
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);

	dk_DKHOME_DIR();
	//console.log("dk_DKHOME_DIR:DKTEST()")
	//dk_DKHOME_DIR()
};