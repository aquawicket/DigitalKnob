//####################################################################
//# dk_getEnv()
//#
//#
dk_getEnv = function dk_getEnv_f() {
    //dk_debugFunc(0 1);
	
	if(typeof WScript === "object"){
		WScript_Shell = new ActiveXObject("WScript.Shell");
		return WScript_Shell.ExpandEnvironmentStrings("%"+arguments[0]+"%");
	}
};






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	COMSPEC = dk_getEnv("COMSPEC");
	console.log("COMSPEC = "+COMSPEC)
};
