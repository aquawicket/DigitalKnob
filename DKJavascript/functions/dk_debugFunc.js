//################################################################################
//# dk_debugFunc()
//#
//#
dk_debugFunc = function dk_debugFunc_f() {
	
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_debugFunc("+arguments.toString()+")");
	console.log("dk_debugFunc("+_ARGV_+")");
	
	//TODO
}





















//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	dk_debugFunc(0);
	
	console.log("dk_debugFunc Test");
}
