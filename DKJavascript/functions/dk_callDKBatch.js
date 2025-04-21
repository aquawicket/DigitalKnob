dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js");
//################################################################################
//# dk_callDKBatch(function args)
//#
//#		Reference: 	https://stackoverflow.com/q/24148741
//#					https://www.vbsedit.com/html/f3358e96-3d5a-46c2-b43b-3107e586736e.asp
//#
dk_callDKBatch = function dk_callDKBatch_f(){
	//dk_debugFunc(0);
	
	console.log("dk_callDKBatch("+arguments[0]+")");

	DKBATCH_FUNCTIONS_DIR_ = "C:/Users/Administrator/digitalknob/Development/DKBatch/functions/";
	COMSPEC = dk_env("%COMSPEC%")
	WShell = new ActiveXObject("WScript.Shell");
	
	//var ret = WShell.Run("start /b cmd /V:ON /c set DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKBatch/functions/& C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd");
	
	//var ret = WShell.Exec("cmd /V:ON /c set DKBATCH_FUNCTIONS_DIR_=C:/Users/Administrator/digitalknob/Development/DKBatch/functions/& C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd");
	
	
	
	//var ret = WShell.Run("C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd");
	
	//var oExec = WShell.Run('cmd /c dir', 1 /* SW_SHOWNORMAL */, true /* bWaitOnReturn */);
	//WScript.Echo("ret " + ret);

	//var oExec = WShell.Exec('cmd /V:ON /c dir');
	var oExec = WShell.Exec('cmd /V:ON /c test.cmd');
	//var oExec = WShell.Exec('cmd /V:ON /c call C:/Users/Administrator/digitalknob/Development/DKBatch/functions/dk_test.cmd');
	
	

	/*
	var input = "";
	while (true) {
		if (!oExec.StdOut.AtEndOfStream) {
          input += oExec.StdOut.Read(1);
          if (input.indexOf("Press any key") != -1)
               break;
		}
		WScript.Sleep(100);
	}
	oExec.StdIn.Write("\n");
	while (oExec.Status != 1)
    WScript.Sleep(100);
	var stdin = oExec.StdIn.ReadAll();
	WScript.Echo("stdin = "+stdin);
	*/
	
	if(typeof oExec !== "undefined"){
/*	
	while(oExec.Status === 0){
			//WScript.Echo("### status = "+oExec.Status+" (running)");
			var stdoutA = oExec.StdOut.ReadAll();
			WScript.Echo(stdoutA);
			WScript.Sleep(1000);
		}
*/		
		var stdout = "";
		var stderr = "";
		
		while(!oExec.Status){
			if(!oExec.StdOut.AtEndOfStream){
				var stdout_line = oExec.StdOut.ReadLine();
				WScript.StdOut.WriteLine(stdout_line);
				stdout += stdout_line += "\n";
			}
			
			if(!oExec.StdErr.AtEndOfStream){
				var stderr_line = oExec.StdErr.ReadLine();
				WScript.StdErr.WriteLine(stderr_line);
				stderr += stderr_line += "\n";
			}
        }
		
		WScript.Echo("### status = "+oExec.Status+" (done)");
		
		var processid = oExec.ProcessID;
		WScript.Echo("### processid = "+processid);
		
		var exitcode = oExec.ExitCode;
		WScript.Echo("### exitcode = "+exitcode);
		
		WScript.Echo("\n######################## STDOUT ########################");
		stdout += oExec.StdOut.ReadAll();
		WScript.Echo(stdout);

		WScript.Echo("\n######################## STDERR ########################");
		stderr += oExec.StdErr.ReadAll();
		WScript.Echo(stderr);
		
		if(exitcode === 1){
			WScript.Echo("failed");	
		}
	}
	if(typeof oRun !== "undefined"){
		
	}
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_callback(){
	//dk_debugFunc(0);
	
	dk_callDKBatch("dk_test")
}
