dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js");
//################################################################################
//# dk_exec()
//#
//#
dk_exec = function dk_exec_f(){
	//dk_debugFunc(0);
	
	var _ARGV_ = "";
	for(var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_exec("+_ARGV_+")");

	COMSPEC = dk_env("%COMSPEC%")
	WShell = new ActiveXObject("WScript.Shell");
	
	//var oExec = WShell.Exec('cmd /V:ON /c dir');
	//var oExec = WShell.Exec('cmd /V:ON /c test.cmd');
	var oExec = WShell.Exec(_ARGV_);
	
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
		var stdout = "";
		var stderr = "";

		WScript.Echo("\n######################## STDOUT ########################");
		while(!oExec.Status){
			if(!oExec.StdOut.AtEndOfStream){
				var stdout_line = oExec.StdOut.ReadLine();
				WScript.StdOut.WriteLine(stdout_line);
				stdout += stdout_line += "\n";
			}
			/*
			if(!oExec.StdErr.AtEndOfStream){
				var stderr_line = oExec.StdErr.ReadLine();
				WScript.StdErr.WriteLine(stderr_line);
				stderr += stderr_line += "\n";
			}
			*/
        }
		
		stdout = oExec.StdOut.ReadAll();
		WScript.Echo(stdout);

		WScript.Echo("\n######################## STDERR ########################");
		stderr = oExec.StdErr.ReadAll();
		WScript.Echo(stderr);
		
		WScript.Echo("### status = "+oExec.Status+" (done)");
		
		var processid = oExec.ProcessID;
		WScript.Echo("### processid = "+processid);
		
		var exitcode = oExec.ExitCode;
		WScript.Echo("### exitcode = "+exitcode);
		
		if(exitcode === 1){
			WScript.Echo("failed");	
		}
	}
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_callback(){
	//dk_debugFunc(0);
	
	//dk_exec("cmd /c dir");
	
	dk_exec("dk_exec_TEST.cmd");
}
