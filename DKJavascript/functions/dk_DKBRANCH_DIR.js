if(typeof dk_getEnv === "dk_getEnv"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKBRANCH_DIR = function dk_DKBRANCH_DIR_f(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKBRANCH_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKBRANCH_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DIGITALKNOB_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DIGITALKNOB_DIR.js", function(){
				dk_DIGITALKNOB_DIR()
			}); 
		}
		DKBRANCH_DIR = DIGITALKNOB_DIR+"/Development";
	}

	dk_assertPath(DKBRANCH_DIR);
	//window["DKBRANCH_DIR"] = DKBRANCH_DIR;
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKBRANCH_DIR();
	console.log("DKBRANCH_DIR = "+DKBRANCH_DIR);
};