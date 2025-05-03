//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}

//################################################################################
//# dk_run(strCommand, [intWindowStyle], [bWaitOnReturn])
//#
//#	strCommand
//#		String value indicating the command line you want to run. You must include any parameters you want to pass to the executable file.
//#		
//#	intWindowStyle
//#		Optional. Integer value indicating the appearance of the program's window. Note that not all programs make use of this information.
//#		0 Hides the window and activates another window.
//#     1 Activates and displays a window. If the window is minimized or maximized, the system restores it to its original size and position. 
//#			An application should specify this flag when displaying the window for the first time.
//#		2 Activates the window and displays it as a minimized window.
//#		3 Activates the window and displays it as a maximized window.
//#		4 Displays a window in its most recent size and position. The active window remains active.
//#		5 Activates the window and displays it in its current size and position.
//#		6 Minimizes the specified window and activates the next top-level window in the Z order.
//#		7 Displays the window as a minimized window. The active window remains active.
//#		8 Displays the window in its current state. The active window remains active.
//#		9 Activates and displays the window. If the window is minimized or maximized, the system restores it to its original size and position. 
//#			An application should specify this flag when restoring a minimized window.
//#		10 Sets the show-state based on the state of the program that started the application.
//#
//#	bWaitOnReturn
//#		Optional. Boolean value indicating whether the script should wait for the program to finish executing before continuing to the next statement in your script. 
//#		If set to true, script execution halts until the program finishes, and Run returns any error code returned by the program. If set to false (the default), 
//#		the Run method returns immediately after starting the program, automatically returning 0 (not to be interpreted as an error code).
//#
//#		Reference: https://www.vbsedit.com/html/6f28899c-d653-4555-8a59-49640b0e32ea.asp
//#
dk_run = function dk_run_f(){
	//dk_debugFunc(1);
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_run("+_ARGV_+")");
	
	if(arguments.length > 0){ 
		strCommand = arguments[0];
	}
	if(arguments.length > 1){ 
		intWindowStyle = arguments[1]; 
	} else {
		intWindowStyle = 1; 
	}
	if(arguments.length > 2){ 
		bWaitOnReturn = arguments[2]; 
	} else {
		bWaitOnReturn = false;
	}
	
	if(typeof ActiveXObject === "function"){
		WshShell = new ActiveXObject("WScript.Shell");
		WshShell.Run(strCommand, intWindowStyle, bWaitOnReturn);
	} else {
		console.error("ActiveXObject not available in browsers");
	}
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_run("C:/Windows/System32/notepad.exe", 1, false);
}
