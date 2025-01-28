//################################################################################
//# dk_callDKBatch(function args)
//#
//#
dk_callDKBatch = function dk_callDKBatch_f() {
	//dk_debugFunc(0);
	
	console.log(arguments[0]);
	
	WshShell = new ActiveXObject("WScript.Shell");
	WshShell.Run("c:/windows/system32/notepad.exe", 1, false);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_callDKBatch("dk_debug")
}
