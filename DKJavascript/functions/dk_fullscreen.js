

//################################################################################
//# dk_fullscreen()
//#
//#
dk_fullscreen = function dk_fullscreen_f(){
	//dk_debugFunc(0, 99);
	
	var WScript_Shell = new ActiveXObject("WScript.Shell");
	WScript_Shell.Exec("cmd /c title batchfs");
	WScript.Sleep(100);
	WScript_Shell.AppActivate('batchfs');
	WScript_Shell.SendKeys('{F11}');
	
	/*
	WScript_Shell.Exec("cmd /c (title batchfs) ^& mshta.exe \"javascript:var WshShell = new ActiveXObject('WScript.Shell');WshShell.AppActivate('batchfs');WshShell.SendKeys('{F11}');close();\"");
	*/
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_fullscreen();
}