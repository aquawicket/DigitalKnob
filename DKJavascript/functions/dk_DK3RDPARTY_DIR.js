if(typeof dk_env === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DK3RDPARTY_DIR()
//#
//#
dk_DK3RDPARTY_DIR = function dk_DK3RDPARTY_DIR_f(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DK3RDPARTY_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DK3RDPARTY_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DKBRANCH_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKBRANCH_DIR.js", function(){
				dk_DKBRANCH_DIR()
			}); 
		}
		DK3RDPARTY_DIR = DKBRANCH_DIR+"/3rdParty";
	}

	dk_assertPath(DK3RDPARTY_DIR);
	//window["DK3RDPARTY_DIR"] = DK3RDPARTY_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DK3RDPARTY_DIR();
	console.log("DK3RDPARTY_DIR = "+DK3RDPARTY_DIR);
};

