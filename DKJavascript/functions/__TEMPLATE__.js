dk_source(DKJAVASCRIPT_DIR+"/functions/dk_log.js");

//################################################################################
//# __TEMPLATE__()
//#
//#
__TEMPLATE__ = function __TEMPLATE___f(){
	//dk_debugFunc(0);
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("__TEMPLATE__("+_ARGV_+")");
	
	//TODO
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	__TEMPLATE__();
}
