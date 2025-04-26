//if(!dk_valid("DK"))	{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){});			}


//################################################################################
//# dk_basename(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_basename = function dk_basename_f(path, basename){
	//dk_debugFunc(1);
	
	dk_fileSystem = function dk_fileSystem_f(){
		if(dk_valid("ActiveXObject")){
			return new ActiveXObject("Scripting.FileSystemObject");
		}
	}

	dk_basename.value = dk_fileSystem().GetBaseName(arguments[0]);
	return dk_basename.value;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
	console.log("dk_basename('"+myPath+"') = "+dk_basename(myPath));
}