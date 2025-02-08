if(typeof dk_error === "undefined"){ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_error.js", function(){}); }

//################################################################################
//# dk_assertPath(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_assertPath = function dk_assertPath_f() {
	//dk_debugFunc(0 99);

	_path_ = arguments[0];
	console.log("_path_ = "+_path_);
	
	if(typeof fileSystemObject === "undefined") { 
		fileSystemObject = new ActiveXObject("Scripting.FileSystemObject");
	};
	if(fileSystemObject.FolderExists(_path_) || fileSystemObject.FileExists(_path_)){
		return 0
	};
	
	dk_error("ASSERTION: dk_assertPath("+arguments[0]+"): path not found!");
};





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc 0

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
//    dk_assertPath("myPath")							//OK
//	//# CMD.exe
//	dk_assertPath("%COMSPEC%")							//OK
	
    dk_assertPath("C:/NonExistentPath");					//ASSERT
};