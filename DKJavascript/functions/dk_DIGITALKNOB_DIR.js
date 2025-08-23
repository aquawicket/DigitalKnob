

//####################################################################
//# dk_DIGITALKNOB_DIR()
//#
//#
dk_DIGITALKNOB_DIR = function dk_DIGITALKNOB_DIR_f(){
    //dk_debugFunc(0 1);

	//############ SET ############
	if(arguments.length > 0){
		DIGITALKNOB_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		dk_depend("dk_DKHOME_DIR"); dk_DKHOME_DIR();
		DIGITALKNOB_DIR = DKHOME_DIR+"/DigitalKnob";
	}

	dk_depend("dk_assertPath"); dk_assertPath(DIGITALKNOB_DIR)
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DIGITALKNOB_DIR();
	dk_depend("dk_echo"); dk_echo("DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);
};