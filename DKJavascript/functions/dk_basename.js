//################################################################################
//# dk_basename(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_basename = function dk_basename_f(path) {
	//dk_debugFunc(1);
	
	if(typeof filesystem === "undefined") { 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	return filesystem.GetBaseName (path);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f() {
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
    var basename = dk_basename(myPath);
    console.log("basename = "+basename);
}