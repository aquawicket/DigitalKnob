//################################################################################
//# dk_pathExists(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_pathExists = function(path) {
	//dk_debugFunc(1);
	
	if(typeof filesystem === "undefined") { 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	return (filesystem.FolderExists(path) || filesystem.FileExists(path));
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/Sysem32";
	if(dk_pathExists(myPath)){
	    console.log("path exists");	
	} else {
	    console.log("path does not exist");
	}
	return;
}