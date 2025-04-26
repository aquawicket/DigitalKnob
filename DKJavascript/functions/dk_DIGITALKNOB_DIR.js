//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 		}
if(!dk_valid("dk_echo"))		{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js", function(){});	}

//####################################################################
//# dk_DIGITALKNOB_DIR()
//#
//#
dk_DIGITALKNOB_DIR = function dk_DIGITALKNOB_DIR_f(){
    //dk_debugFunc(0 1);

	//###### Print 'function(arguments)' ######
	//var _ARGV_ = "";
	//for (var i = 0; i < arguments.length; i++) {_ARGV_ += arguments[i];}
	//console.log("dk_DIGITALKNOB_DIR("+_ARGV_+")");

	//############ SET ############
	if(arguments.length > 0){
		dk_echo("dk_DIGITALKNOB_DIR():SET");
		DIGITALKNOB_DIR = arguments[0];
	} 
	//############ GET ############
	else {
		dk_echo("dk_DIGITALKNOB_DIR():GET");
		if(!dk_valid("dk_DKHOME_DIR")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_DKHOME_DIR.js", function(){ dk_DKHOME_DIR() }); }
		DIGITALKNOB_DIR = DKHOME_DIR+"/digitalknob";
	}

	if(!dk_valid("dk_assertPath")){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_assertPath.js", function(){}); }
	dk_assertPath(DIGITALKNOB_DIR)
	//window["DIGITALKNOB_DIR"] = DIGITALKNOB_DIR;
}






//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);

	dk_DIGITALKNOB_DIR();
	dk_echo("DIGITALKNOB_DIR = "+DIGITALKNOB_DIR);
};