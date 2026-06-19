//################################################################################
//# dk_pathExists(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_pathExists = function dk_pathExists_f(){
	//dk_debugFunc(1);
	
	dk_depend("dk_fileSystem");
	dk_assert("dk_fileSystem.FolderExists");
	return (dk_fileSystem.FolderExists(arguments[0]) || dk_fileSystem.FileExists(arguments[0]));
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
	if(dk_pathExists(myPath)){
	    console.log("'"+myPath+"' exists");	
	} else {
	    console.error("'"+myPath+"' does not exist");
	}
	
	var myPath = "C:/NonExistent";
	if(dk_pathExists(myPath)){
	    console.log("'"+myPath+"' exists");	
	} else {
	    console.error("'"+myPath+"' does not exist");
	}
}