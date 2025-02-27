//################################################################################
//# dk_setVolatile(name, value)
//#
//#
dk_setVolatile = function dk_setVolatile_f() {
	
	var shell = WScript.CreateObject("WScript.Shell");
	var env = shell.Environment("VOLATILE");
	env(arguments[0]) = arguments[1];
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_setVolatile("TEST", "the value of test");
}
