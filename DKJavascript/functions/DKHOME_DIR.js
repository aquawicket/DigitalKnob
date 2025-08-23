

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

	//###### WSLPATH_EXE ######
	//dk_set(WSLPATH_EXE   WSL_EXE+" wslpath")
	//dk_printVar(WSLPATH_EXE)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	//if exist "!WSLPATH_EXE!"        !dk_call! dk_exec "!WSLPATH_EXE! -u !DKHOME_DIR!" DKHOME_DIR

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