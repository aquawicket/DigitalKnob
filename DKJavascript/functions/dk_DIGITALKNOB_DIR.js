if(typeof dk_getEnv === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DIGITALKNOB_DIR = function dk_DIGITALKNOB_DIR_f(){
    //dk_debugFunc(0 1);
	console.log("dk_DIGITALKNOB_DIR()")

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DIGITALKNOB_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DIGITALKNOB_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DKHOME_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKHOME_DIR.js", function(){
				dk_DKHOME_DIR()
			}); 
		}
		DIGITALKNOB_DIR = DKHOME_DIR+"/digitalknob";
	}

	dk_assertPath(DIGITALKNOB_DIR)
	//window["DIGITALKNOB_DIR"] = DIGITALKNOB_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DIGITALKNOB_DIR();
	console.log("DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);
};