

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKHOME_DIR = function dk_DKHOME_DIR_f(){
    //dk_debugFunc(0 1);
	
	//############ SET ############
	if(typeof arguments[0] === "string"){ 
		DKHOME_DIR = arguments[0];
	} 
		
	//############ GET ############
	else {
		if(!dk_valid("DKHOME_DIR")){
			dk_depend("dk_env"); DKHOME_DIR = dk_env("USERPROFILE").replaceAll("\\", "/");
		}
	}

	//###### wslpath_exe ######
	//dk_set(wslpath_exe   wsl_exe+" wslpath")
	//dk_printVar(wslpath_exe)

	//if not defined HOMEDRIVE        !dk_call! dk_warning "HOMEDRIVE is invalid"
	//if not defined HOMEPATH         !dk_call! dk_warning "HOMEPATH is invalid"
	
	//if exist "!wslpath_exe!"        !dk_call! dk_exec "!wslpath_exe! -u !DKHOME_DIR!" DKHOME_DIR

	dk_depend("dk_assertPath"); dk_assertPath(DKHOME_DIR);
	
	//###### return ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = DKHOME_DIR;
	} else {
		console.log(DKHOME_DIR);
	}
	return(DKHOME_DIR);
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	//### Result as global variable
	console.log('\n');
	console.log('dk_DKHOME_DIR()');
	dk_DKHOME_DIR();
	console.log('DKHOME_DIR = '+DKHOME_DIR);
	
	
	//### Result as parameter
	console.log("\n");
	console.log('dk_DKHOME_DIR(null, resultB)');
	var resultB = {};
	dk_DKHOME_DIR(null, resultB);
	console.log("resultB = "+resultB.value);
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	
	//### Result as return value
	console.log("\n");
	console.log('var resultC = dk_DKHOME_DIR()');
	var resultC = dk_DKHOME_DIR();
	console.log("resultC = "+resultC);
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	
	//### Result as return value and parameter variable 	[GLOBAL][PARAM][RETURN]
	console.log("\n");
	console.log('var resultE = dk_DKHOME_DIR(null, resultD);');
	var resultD = {};
	var resultE = dk_DKHOME_DIR(null, resultD);
	console.log("resultD = "+resultD.value);
	console.log("resultE = "+resultE);
	console.log("DKHOME_DIR = "+DKHOME_DIR);
	
	
	//### Result from stdout								[STDOUT]
	console.log("\n");
	//dk_exec("cmd.exe /c ver");
	//stdout = dk_exec.stdout[dk_exec.stdout.length-1].toString();
	//processId = dk_exec.processId;
	//exit_code = dk_exec.exitcode;
	//console.log("stdout = "+stdout);
	//console.log("processId = "+processId);
	//console.log("exit_code = "+exit_code);

};