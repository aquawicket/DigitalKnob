if(typeof dk_getEnv === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKHOME_DIR = function dk_DKHOME_DIR_f(){
    //dk_debugFunc(0 1);
	//console.log("dk_DKHOME_DIR("+args+")");
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++) {
		_ARGV_ += arguments[i];
	}
	console.log("\ndk_DKHOME_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKHOME_DIR = arguments[0];
	} 
		
	//############ GET ############
	else {
		DKHOME_DIR = dk_getEnv("USERPROFILE").replaceAll("\\", "/");
	}

	
	//###### WSLPATH_EXE ######
	//dk_set(WSLPATH_EXE   WSL_EXE+" wslpath")
	//dk_printVar(WSLPATH_EXE)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_exec "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

	dk_assertPath(DKHOME_DIR)
	
	//console.log("DKHOME_DIR = "+DKHOME_DIR);
	//window["DKHOME_DIR"] = DKHOME_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	//### GET ###
	dk_DKHOME_DIR();
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	//### SET ###
	dk_DKHOME_DIR("C:/Users");
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	//console.log("dk_DKHOME_DIR:DKTEST()")
	//dk_DKHOME_DIR()
};