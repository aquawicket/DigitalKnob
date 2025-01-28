//####################################################################
//# dk_getEnv()
//#
//#
dk_getEnv = function dk_getEnv_f(){
    //dk_debugFunc(0 1);
	console.log("dk_getEnv()")
	
	if(typeof WScript === "object"){
		WScript_Shell = new ActiveXObject("WScript.Shell");
		COMPEC = WScript_Shell.ExpandEnvironmentStrings("%COMSPEC%");
	}
};






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	console.log("dk_getEnv:DKTEST()")
	
	COMSPEC = dk_getEnv("%COMSPEC%");
	console.log("COMSPEC = "+COMSPEC)
};
