dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js");
//################################################################################
//# dk_callDKBatch(function args)
//#
//#
dk_callDKBatch = function dk_callDKBatch_f() {
	//dk_debugFunc(0);
	
	console.log("dk_callDKBatch("+arguments[0]+")");
	
	COMSPEC = dk_getEnv("%COMSPEC%")

	WshShell = new ActiveXObject("WScript.Shell");
	WshShell.Run("c:/windows/system32/notepad.exe", 1, false);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_callDKBatch("dk_debug")
}
