if(typeof dk_env === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }

//####################################################################
//# dk_DKDESKTOP_DIR()
//#
//#
dk_DKDESKTOP_DIR = function dk_DKDESKTOP_DIR_f(){
    //dk_debugFunc(0 1);
	console.log("dk_DKDESKTOP_DIR()")

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKDESKTOP_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKDESKTOP_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DKHOME_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKHOME_DIR.js", function(){
				dk_DKHOME_DIR()
			}); 
		}
		DKDESKTOP_DIR = DKHOME_DIR+"/Desktop";
	}

	dk_assertPath(DKDESKTOP_DIR)
	//window["DKDESKTOP_DIR"] = DKDESKTOP_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKDESKTOP_DIR();
	console.log("DKDESKTOP_DIR = "+DKDESKTOP_DIR);
};