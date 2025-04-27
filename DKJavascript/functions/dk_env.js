//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}
if(!dk_valid("dk_echo")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js", function(){}); 	}

//####################################################################
//# dk_env(<VAR> <set:OPTIONAL>)
//#
//#
dk_env = function dk_env_f(){
    //dk_debugFunc(1 2);
	
	//############ SET ############
	if(arguments[1]){ 
		dk_echo("dk_env():SET");
		if(dk_valid("ActiveXObject")){
			WScript_Shell = new ActiveXObject("WScript.Shell");
			
			wshSystemEnv = WScript_Shell.Environment("USER");
			wshSystemEnv("TEST") = "Test User";

			//return WScript_Shell.ExpandEnvironmentStrings("%"+arguments[0]+"%");
		}
	} 
	
	//############ GET ############
	else {
		dk_echo("dk_env():GET");
		if(dk_valid("ActiveXObject")){
			WScript_Shell = new ActiveXObject("WScript.Shell");
			return WScript_Shell.ExpandEnvironmentStrings("%"+arguments[0]+"%");
		}
	}
};






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	COMSPEC = dk_env("COMSPEC");
	dk_echo("COMSPEC = "+COMSPEC);
	

	TEST = dk_env("TEST");
	dk_echo("TEST = "+TEST);
	
	dk_env("TEST", "123");
	TEST = dk_env("TEST");
	dk_echo("TEST = "+TEST);

};
