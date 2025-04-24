dk_source(DKJAVASCRIPT_DIR+"/functions/dk_env.js");

if(!dk_valid("dk_exec_ECHO_STDOUT")){ var dk_exec_ECHO_STDOUT = 1; }
if(!dk_valid("dk_exec_ECHO_STDERR")){ var dk_exec_ECHO_STDERR = 1; }
//################################################################################
//# dk_exec()
//#
//#
dk_exec = function dk_exec_f(){
	//dk_debugFunc(0);
	
	var _ARGV_ = "";
	for(var i = 0; i < arguments.length; i++){ _ARGV_ += arguments[i]; }
	console.log("dk_exec("+_ARGV_+")");

	ComSpec = dk_env("%ComSpec%")
	WShell = new ActiveXObject("WScript.Shell");
	
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
		
		dk_exec.stdout = [];
		//while(!oExec.Status){
		while(!oExec.StdOut.AtEndOfStream){
			dk_exec.stdout.push(oExec.StdOut.ReadLine());
			if(dk_exec_ECHO_STDOUT == 1){ 
				WScript.StdOut.WriteLine(dk_exec.stdout[dk_exec.stdout.length-1]); 
			}
		}
		if(dk_exec_ECHO_STDOUT == 1){ 
			stdout = oExec.StdOut.ReadAll();
			WScript.StdOut.Write(stdout);
		}
		
		WScript.Echo("\n######################## STDERR ########################");
		dk_exec.stderr = [];
		while(!oExec.StdErr.AtEndOfStream){
			dk_exec.stderr.push(oExec.StdErr.ReadLine());
			if(dk_exec_ECHO_STDERR == 1){ 
				WScript.StdErr.WriteLine(dk_exec.stderr[dk_exec.stderr.length-1]);
			}
		}
		if(dk_exec_ECHO_STDERR == 1){ 
			stderr = oExec.StdErr.ReadAll();
			WScript.StdErr.Write(stderr);
		}
		
		dk_exec.status = oExec.Status;		
		dk_exec.processId = oExec.ProcessID;
		dk_exec.exitcode = oExec.ExitCode;
	}
}




//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_callback(){
	//dk_debugFunc(0);
	
	//dk_exec("cmd /c dir");
	dk_exec("dk_exec_TEST.cmd");
	
	console.log("\n\n");
	console.log("  STATUS:  "+dk_exec.status);
	console.log("     PID:  "+dk_exec.processId);
	console.log("EXITCODE:  "+dk_exec.exitcode);
	console.log("  STDOUT:\n"+dk_exec.stdout.toString().replaceAll(",", "\n"));
	console.log("  STDERR:\n"+dk_exec.stderr.toString().replaceAll(",", "\n"));
}
