//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 			}
if(!dk_valid("dk_debugFunc"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js", function(){}); 	}
if(!dk_valid("dk_echo"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js", function(){}); 		}


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
	if(arguments.length > 0){
		dk_echo("dk_DKBRANCH_DIR():SET");
		DKBRANCH_DIR = arguments[0];
	} 
	
	//############ GET ############
	else {
		dk_echo("dk_DKBRANCH_DIR():GET");
		if(!dk_valid("dk_DIGITALKNOB_DIR"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DIGITALKNOB_DIR.js", function(){ dk_DIGITALKNOB_DIR() }); }
		DKBRANCH_DIR = DIGITALKNOB_DIR+"/Development";
	}

	if(!dk_valid("dk_assertPath")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
	dk_assertPath(DKBRANCH_DIR);
	//window["DKBRANCH_DIR"] = DKBRANCH_DIR;
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DKBRANCH_DIR();
	dk_echo("DKBRANCH_DIR = "+DKBRANCH_DIR);
	
	dk_DKBRANCH_DIR("C:/Windows");
	dk_echo("DKBRANCH_DIR = "+DKBRANCH_DIR);
};