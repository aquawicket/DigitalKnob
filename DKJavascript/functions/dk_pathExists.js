//################################################################################
//# dk_pathExists(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_pathExists = function dk_pathExists_f(path){
	//dk_debugFunc(1);
	
	if(typeof fileSystemObject === "undefined"){ 
		fileSystemObject = new ActiveXObject("Scripting.FileSystemObject");
	}
	return (fileSystemObject.FolderExists(path) || fileSystemObject.FileExists(path));
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
	if(dk_pathExists(myPath)){
	    console.log("'"+myPath+"' exists");	
	} else {
	    console.log("'"+myPath+"' does not exist");
	}
	
	var myPath = "C:/NonExistent";
	if(dk_pathExists(myPath)){
	    console.log("'"+myPath+"' exists");	
	} else {
	    console.log("'"+myPath+"' does not exist");
	}

}