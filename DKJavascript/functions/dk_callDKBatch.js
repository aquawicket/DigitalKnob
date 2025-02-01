dk_source(DKJAVASCRIPT_DIR+"/functions/dk_getEnv.js");
//################################################################################
//# dk_callDKBatch(function args)
//#
//#
dk_callDKBatch = function dk_callDKBatch_f() {
	//dk_debugFunc(0);
	
	console.log("dk_callDKBatch("+arguments[0]+")");

	DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKBatch/functions/";
	COMSPEC = dk_getEnv("%COMSPEC%")
	WShell = new ActiveXObject("WScript.Shell");
	
	var rtncode = WShell.Run("cmd /V:ON /c set DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKBatch/functions/& C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd");
	
	//WShell.Exec("cmd /V:ON /c set DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKBatch/functions/& C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd");
	
	console.log("dk_callDKBatch rtncode = "+rtncode)
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	dk_callDKBatch("dk_debug")
}
