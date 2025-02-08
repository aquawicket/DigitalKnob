if(typeof dk_getEnv === "dk_getEnv"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKTOOLS_DIR = function dk_DKTOOLS_DIR(){
    //dk_debugFunc(0 1);
	console.log("dk_DKTOOLS_DIR()")

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
	
	var DKTOOLS_DIR = DIGITALKNOB_DIR+"/DKTools";
	console.log("DKTOOLS_DIR = "+DKTOOLS_DIR);
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DKTOOLS_DIR);	
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	console.log("begin")

	dk_DKTOOLS_DIR();
	//console.log("dk_DKHOME_DIR:DKTEST()")
	//dk_DKHOME_DIR()
};

