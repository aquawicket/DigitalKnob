//################################################################################
//# dk_assertPath(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_assertPath = function dk_assertPath_f(path) {
	//dk_debugFunc(1);
	
	if(typeof fileSystemObject === "undefined") { 
		fileSystemObject = new ActiveXObject("Scripting.FileSystemObject");
	}
	if(fileSystemObject.FolderExists(path) || fileSystemObject.FileExists(path)){
		return
	}
	
	
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	

}