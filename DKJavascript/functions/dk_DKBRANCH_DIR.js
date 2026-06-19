

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKBRANCH_DIR = function dk_DKBRANCH_DIR_f(){
    //dk_debugFunc(0 1);

	//############ SET ############
	if(arguments.length > 0){
		DKBRANCH_DIR = arguments[0];
	} 
	
	//############ GET ############
	else {
		dk_depend("dk_DIGITALKNOB_DIR"); dk_DIGITALKNOB_DIR();
		DKBRANCH_DIR = DIGITALKNOB_DIR+"/Development";
	}

	//dk_depend("dk_assertPath"); dk_assertPath(DKBRANCH_DIR);
	
	//###### return ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = DKBRANCH_DIR;
	} else {
		console.log(DKBRANCH_DIR);
	}
	return DKBRANCH_DIR;
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_depend("dk_echo");

	dk_DKBRANCH_DIR();
	dk_echo("DKBRANCH_DIR = "+DKBRANCH_DIR);
	
	dk_DKBRANCH_DIR("C:/Windows");
	dk_echo("DKBRANCH_DIR = "+DKBRANCH_DIR);
};