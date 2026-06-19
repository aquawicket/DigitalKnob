// shebang
//#####################################################################################################
/*
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		throw new Error('Program Terminated');
	}
}
*/
//#####################################################################################################


//################################################################################
//# dk_assertPath(path)
//#
//#    Reference:https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_assertPath = function dk_assertPath_f(){
	//dk_debugFunc(0, 99);
	
	var argv = "";
	for (var i = 0; i < arguments.length; i++){ argv += arguments[i]; }
	//console.log('dk_assertPath('+argv+')');
	
	dk_depend("dk_fileSystem");
	dk_assert("dk_fileSystem.FolderExists");
	if(dk_fileSystem.FolderExists(argv) || dk_fileSystem.FileExists(argv)){
		return 0;
	};
		
	dk_depend("dk_error"); dk_error("ASSERTION: dk_assertPath("+argv+"): path not found!");
	return -1;
};





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(callback){
	//dk_debugFunc(0);

	//# correct path
	dk_assertPath("C:/Program Files/Common Files");		//OK
	//# back slashes
	dk_assertPath("C:\\Program Files\\Common Files");	//OK
	//# lower case
	dk_assertPath("c:/program files/common files");		//OK
	//# UPPER CASE
	dk_assertPath("C:/PROGRAM FILES/COMMON FILES");		//OK
	//# No quotes
//	dk_assertPath(C:/PROGRAM FILES/COMMON FILES)		//OK
	//# as Variable
    myPath = "C:/Program Files/Common Files";
	//# As a variable name
    dk_assertPath(myPath);								//OK
	//# As a variable name quoted
	dk_assertPath("myPath")								//ASSERT
	//# CMD.exe
//	dk_assertPath("%COMSPEC%")							//OK
	
    //dk_assertPath("C:/NonExistentPath");				//ASSERT
	
	if(callback){ callback(); }
};