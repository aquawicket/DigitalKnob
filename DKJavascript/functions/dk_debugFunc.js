//################################################################################
//# dk_debugFunc()
//#
//#
dk_debugFunc = function dk_debugFunc_f(){
	var args = arguments.toString();
	console.log("dk_debugFunc("+args+")");
	
	//TODO
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	dk_debugFunc(0);
	
	console.log("dk_debugFunc Test");
}
