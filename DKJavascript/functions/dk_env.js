//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}

//################################################################################
//# dk_env(name)
//# dk_env(name, value)
//#
//#		Reference: https://www.robvanderwoude.com/vbstech_data_environment.php
//#
dk_env = function dk_env_f(){
	//dk_debugFunc(1, 2);
	
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	//console.log("dk_env("+_ARGV_+")");
	
	var shell = WScript.CreateObject("WScript.Shell");
	var env = shell.Environment("PROCESS");
	//var env = shell.Environment("SYSTEM");
	//var env = shell.Environment("USER");
	//var env = shell.Environment("VOLATILE");
	
	//### SET ###
	if(arguments.length > 1){
		if(arguments[1]){
			//console.log("setting ...");
			env(arguments[0]) = arguments[1];
		} 
		else if(env(arguments[0])){
			//console.log("removing ...");
			env.Remove(arguments[0]);
		}
	}
	
	//### GET ###
	return env(arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	
	console.log('var TEST = dk_env("TEST");');
	var TEST = dk_env("TEST");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var TEST = dk_env("TEST", "the value of test");');
	var TEST = dk_env("TEST", "the value of test");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var TEST = dk_env("TEST");');
	var TEST = dk_env("TEST");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var TEST = dk_env("TEST", "");');
	var TEST = dk_env("TEST", "");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var TEST = dk_env("TEST");');
	var TEST = dk_env("TEST");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var TEST = dk_env("TEST", "the value of test");');
	var TEST = dk_env("TEST", "the value of test");
	console.log("TEST = '"+TEST+"'");
	
	console.log('');
	console.log('var USERPROFILE = dk_env("USERPROFILE");');
	var USERPROFILE = dk_env("USERPROFILE");
	console.log("USERPROFILE = '"+USERPROFILE+"'");
}
