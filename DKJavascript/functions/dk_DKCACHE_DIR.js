if(typeof dk_env === "undefined")	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js", function(){}); }
if(typeof dk_assertPath === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
//(1, eval)(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js").OpenTextFile(url, 1).ReadAll();

//####################################################################
//# dk_DKCACHE_DIR()
//#
//#
dk_DKCACHE_DIR = function dk_DKCACHE_DIR(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DKCACHE_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments[0]){ 
		DKTOOLS_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		if(typeof dk_DKHOME_DIR === "undefined"){ 
			dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKHOME_DIR.js", function(){
				dk_DKHOME_DIR()
			}); 
		}
		DKCACHE_DIR = DKHOME_DIR+"/.dk";
	}

	dk_assertPath(DKCACHE_DIR);
	//window["DKCACHE_DIR"] = DKCACHE_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKCACHE_DIR
	console.log("DKCACHE_DIR = "+DKCACHE_DIR);
};

