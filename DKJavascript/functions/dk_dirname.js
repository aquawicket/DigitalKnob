//if(!dk_valid("DK"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/DK.js", function(){}); 		}

//################################################################################
//# dk_dirname(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_dirname = function dk_dirname_f(){
	//dk_debugFunc(1);
	
	dk_fileSystem = function dk_fileSystem_f(){
		if(dk_valid("ActiveXObject")){
			return new ActiveXObject("Scripting.FileSystemObject");
		}
	}

	dk_dirname.value = dk_fileSystem().GetParentFolderName(arguments[0]);
	return dk_dirname.value;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
	console.log("dk_dirname('"+myPath+"') = "+dk_dirname(myPath));
}