if(typeof dk_getEnv === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKIMPORTS_DIR()
//#
//#
dk_DKIMPORTS_DIR = function dk_DKIMPORTS_DIR_(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKTOOLS_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKIMPORTS_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DK3RDPARTY_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DK3RDPARTY_DIR.js", function(){
				dk_DK3RDPARTY_DIR()
			}); 
		}
		DKIMPORTS_DIR = DK3RDPARTY_DIR+"/_DKIMPORTS";
	}

	dk_assertPath(DKIMPORTS_DIR);
	//window["DKIMPORTS_DIR"] = DKIMPORTS_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKIMPORTS_DIR();
	console.log("DKIMPORTS_DIR = "+DKIMPORTS_DIR);
};

