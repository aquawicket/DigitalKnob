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
	
	//### Result as global variable
	dk_echo;
	dk_basename("A:/directoryA/filenameA.extA");
	dk_echo "dk_basename = ${dk_basename}";
	
	//### Result as variable parameter
	dk_echo;
	dk_basename("B:/directoryB/filenameB.extB" resultB);
	dk_echo "resultB = ${resultB}";
	dk_echo "dk_basename = ${dk_basename}";
	
	//### Result as return value
	dk_echo;
	resultC=dk_basename("C:/directoryC/filenameC.extC");
	dk_echo "resultC = ${resultC}";
	#dk_echo "dk_basename = ${dk_basename}"					#NOTE: export cannot be seen outside of command substituion
	
	//### Result as hashtable parameter
	dk_echo;
	dk_basename("D:/directoryD/filenameD.extD" resultD.value);
	dk_echo "resultD.value = ${resultD.value}";
	dk_echo "dk_basename = ${dk_basename}";
}