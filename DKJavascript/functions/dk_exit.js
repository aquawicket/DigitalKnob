//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}


//################################################################################
//# dk_exit(exitcode)
//#
//#		Reference: https://www.tutorialspoint.com/how-to-terminate-a-script-in-javascript
//#
dk_exit = function dk_exit_f() {
	//dk_debugFunc(0);
	
	//### JScript ###
	if(dk_valid("WScript.Quit")){
		console.debug("WScript.Quit("+arguments[0]+");");
		WScript.Quit(arguments[0]);
	}
	
	//### Generic ###
	try{
		throw new Error("_"+arguments[0]);
	}
	catch(err) {
		console.log('dk_exit('+err.message.replaceAll("_", "")+')');
	}
	throw new Error();
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_exit(13);
	
	console.log("###### dk_exit.js:29 - SHOULD NOT GET HERE ######");
}
