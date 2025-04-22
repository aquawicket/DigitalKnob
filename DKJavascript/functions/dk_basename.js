//################################################################################
//# dk_basename(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_basename = function dk_basename_f(path, basename){
	//dk_debugFunc(1);
	
	if(typeof filesystem === "undefined"){ 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	
	if(typeof filesystem !== "undefined"){ 
		dk_basename.value = filesystem.GetBaseName(path);
		return 0;
	}
	return 1; // error
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_callback(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
    var ret = dk_basename(myPath);
	console.log("myPath:'"+myPath+"' dk_basename.value = "+dk_basename.value);
	return ret;
}