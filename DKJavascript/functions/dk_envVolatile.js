//################################################################################
//# dk_envVolatile(name)
//# dk_envVolatile(name, value)
//#
//#
dk_envVolatile = function dk_envVolatile_f(){
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_envVolatile("+_ARGV_+")");
	
	var shell = WScript.CreateObject("WScript.Shell");
	var env = shell.Environment("VOLATILE");
	
	//### SET ###
	if(arguments.length > 1){
		if(arguments[1]){
			console.log("setting ...");
			env(arguments[0]) = arguments[1];
		} 
		else if(env(arguments[0])){
			console.log("removing ...");
			env.Remove(arguments[0]);
		}
	}
	
	//### GET ###
	return env(arguments[0]);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var TEST = dk_envVolatile("TEST", "");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST", "the value of test");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST", "");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST");
	console.log("TEST = '"+TEST+"'");
	
	var TEST = dk_envVolatile("TEST", "the value of test");
	console.log("TEST = '"+TEST+"'");
}
