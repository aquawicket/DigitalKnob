if(typeof dk_env === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DK3RDPARTY_DIR()
//#
//#
dk_DK3RDPARTY_DIR = function dk_DK3RDPARTY_DIR_f(){
    //dk_debugFunc(0 1);

	//############ SET ############
	if(arguments[0]){ 
		DK3RDPARTY_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		dk_depend("dk_DKBRANCH_DIR"); dk_DKBRANCH_DIR();
		DK3RDPARTY_DIR = DKBRANCH_DIR+"/3rdParty";
	}

	dk_depend("dk_assertPath"); dk_assertPath(DK3RDPARTY_DIR);
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DK3RDPARTY_DIR();
	console.log("DK3RDPARTY_DIR = "+DK3RDPARTY_DIR);
};

