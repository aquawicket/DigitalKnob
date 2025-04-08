if(typeof dk_getEnv === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKTOOLS_DIR = function dk_DKTOOLS_DIR(){
    //dk_debugFunc(0 1);

/*	//############ SET ############
	if(typeof arguments[0] !== "undefined"){ 
		var DKTOOLS_DIR = arguments[0];
		return;
	)
*/
	//############ GET ############
	
	//###### WSLPATH_EXE ######
	//dk_set(WSLPATH_EXE   WSL_EXE+" wslpath")
	//dk_printVar(WSLPATH_EXE)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	var DKTOOLS_DIR = DIGITALKNOB_DIR+"/DKTools";
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_commandToVariable "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DKTOOLS_DIR);
	window["DKTOOLS_DIR"] = DKTOOLS_DIR;
	
	//console.debug("DKTOOLS_DIR = "+DKTOOLS_DIR);
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKTOOLS_DIR();
	console.log("DKTOOLS_DIR = "+DKTOOLS_DIR);
	//dk_DKHOME_DIR()
};

