//################################################################################
//# dk_dirname(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_fileSystem = function dk_fileSystem_f(){
	//dk_debugFunc(0);
	if(dk_valid("ActiveXObject")){
		return new ActiveXObject("Scripting.FileSystemObject");
	}
}


dk_dirname = function dk_dirname_f(path){
	//dk_debugFunc(1);
	//return dk_call("window.dk_fileSystem").GetParentFolderName(path);
	
	//dk_dirname.value = dk_call("window.dk_fileSystem").GetParentFolderName(path);
	
	dk_dirname.value = dk_call("window.dk_fileSystem.GetParentFolderName", path);
	console.log("typeof dk_dirname.value = "+typeof dk_dirname.value);
	return dk_dirname.value;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";

	console.log("dk_dirname("+myPath+") = "+dk_dirname(myPath));
	console.log("dk_dirname("+myPath+") = "+dk_dirname(myPath));
//	var ret = dk_dirname(myPath);
//	console.log("myPath:'"+myPath+"' dk_dirname.value = "+dk_dirname.value);
//	return ret;
}