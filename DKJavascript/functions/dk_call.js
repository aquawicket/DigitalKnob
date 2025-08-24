
//################################################################################
//# dk_callDKBatch(function args)
//#
//#		Reference: 	https://stackoverflow.com/q/24148741
//#					https://www.vbsedit.com/html/f3358e96-3d5a-46c2-b43b-3107e586736e.asp
//#
dk_call = function dk_call_f(){
	//dk_debugFunc(0);

	func = arguments[0];
	args = arguments[1];
	dk_depend(func);
	
	dk_depend("dk_echo");
	dk_echo(func+"("+args+");");
	eval(func+"("+args+");");
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_callback(){
	//dk_debugFunc(0);
	
	dk_call('dk_info', '"testing dk_call"');
}
