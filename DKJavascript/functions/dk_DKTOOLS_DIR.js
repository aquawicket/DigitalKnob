if(typeof dk_env === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKTOOLS_DIR()
//#
//#
dk_DKTOOLS_DIR = function dk_DKTOOLS_DIR(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKTOOLS_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKTOOLS_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DIGITALKNOB_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DIGITALKNOB_DIR.js", function(){
				dk_DIGITALKNOB_DIR()
			}); 
		}
		DKTOOLS_DIR = DIGITALKNOB_DIR+"/DKTools";
	}

	dk_assertPath(DKTOOLS_DIR);
	//window["DKTOOLS_DIR"] = DKTOOLS_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKTOOLS_DIR();
	console.log("DKTOOLS_DIR = "+DKTOOLS_DIR);
};

