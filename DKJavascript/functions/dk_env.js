//####################################################################
//# dk_env(<VAR> <set:OPTIONAL>)
//#
//#
dk_env = function dk_env_f(){
    //dk_debugFunc(1 2);
	
	//############ SET ############
	if(arguments[1]){ 
		
	} 
	//############ GET ############
	else {
		if(typeof WScript === "object"){
			WScript_Shell = new ActiveXObject("WScript.Shell");
			return WScript_Shell.ExpandEnvironmentStrings("%"+arguments[0]+"%");
		}
	}
};






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	COMSPEC = dk_env("COMSPEC");
	console.log("COMSPEC = "+COMSPEC)
};
