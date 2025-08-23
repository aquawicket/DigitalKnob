

//####################################################################
//# dk_DKCACHE_DIR()
//#
//#
dk_DKCACHE_DIR = function dk_DKCACHE_DIR(){
    //dk_debugFunc(0, 1);

	//############ SET ############
	if(arguments[0]){ 
		DKCACHE_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		dk_depend("dk_DKHOME_DIR"); dk_DKHOME_DIR();
		DKCACHE_DIR = DKHOME_DIR+"/.dk";
	}

	//dk_depend("dk_assertPath"); dk_assertPath(DKCACHE_DIR);
	
	//###### output ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = DKCACHE_DIR;
	} else {
		console.log(DKCACHE_DIR);
	}
	return DKCACHE_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_depend("dk_echo");

	dk_DKCACHE_DIR();
	dk_echo("DKCACHE_DIR = "+DKCACHE_DIR);
	
	dk_DKCACHE_DIR("C:/.dk");
	dk_echo("DKCACHE_DIR = "+DKCACHE_DIR);
};

