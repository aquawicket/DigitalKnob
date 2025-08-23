dk_source(DKJAVASCRIPT_DIR+"/functions/dk_debugFunc.js");
dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js");
dk_source(DKJAVASCRIPT_DIR+"/functions/dk_exec.js");
//################################################################################
//# dk_testReturn()
//#
//#
dk_testReturn = function dk_testReturn_f(){
	//dk_debugFunc(1, 2);
	
	testReturn = arguments[0].replace("input", "output");

	//###### output ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = testReturn;
	} else {
		console.log(testReturn);
	}
	return(testReturn);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	//### Result as global variable
	dk_echo("\n");
	dk_testReturn("inputA");
	dk_echo("testReturn = "+testReturn);
	
	
	//### Result as parameter
	dk_echo("\n");
	var resultB = {};
	dk_testReturn("inputB", resultB);
	dk_echo("resultB = "+resultB.value);
	dk_echo("testReturn = "+testReturn);
	
	
	//### Result as return value
	dk_echo("\n");
	var resultC = dk_testReturn("inputC");
	dk_echo("resultC = "+resultC);
	dk_echo("testReturn = "+testReturn);
	
	
	//### Result as return value and parameter variable 	[GLOBAL][PARAM][RETURN]
	dk_echo("\n");
	var resultD = {};
	var resultE = dk_testReturn("inputDE", resultD);
	dk_echo("resultD = "+resultD.value);
	dk_echo("resultE = "+resultE);
	dk_echo("testReturn = "+testReturn);
	
	
	//### Result from stdout								[STDOUT]
	dk_echo("\n");
	
	dk_exec("cmd.exe /c ver");
	stdout = dk_exec.stdout[dk_exec.stdout.length-1].toString();
	processId = dk_exec.processId;
	exit_code = dk_exec.exitcode;
	
	dk_echo("stdout = "+stdout);
	dk_echo("processId = "+processId);
	dk_echo("exit_code = "+exit_code);

};	