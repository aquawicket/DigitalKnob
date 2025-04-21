if(typeof dk_getEnv === "dk_getEnv"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }

//####################################################################
//# dk_DKHOME_DIR()
//#
//#
dk_DKDOWNLOAD_DIR = function dk_DKDOWNLOAD_DIR_f(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKDOWNLOAD_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKDOWNLOAD_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DIGITALKNOB_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DIGITALKNOB_DIR.js", function(){
				dk_DIGITALKNOB_DIR()
			}); 
		}
		DKDOWNLOAD_DIR = DIGITALKNOB_DIR+"/download";
	}

	dk_assertPath(DKDOWNLOAD_DIR);
	//window["DKDOWNLOAD_DIR"] = DKDOWNLOAD_DIR;
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKDOWNLOAD_DIR();
	console.log("DKDOWNLOAD_DIR = "+DKDOWNLOAD_DIR);
};