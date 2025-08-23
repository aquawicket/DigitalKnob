

//################################################################################
//# dk_dirname(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_dirname = function dk_dirname_f(){
	//dk_debugFunc(1);
	
	dk_depend("dk_fileSystem");
	dk_dirname.value = dk_fileSystem.GetParentFolderName(arguments[0]);
	
	//###### output ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = dk_dirname.value;
	} else {
		console.log(dk_dirname.value);
	}
	return dk_dirname.value;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
	console.log("dk_dirname('"+myPath+"') = "+dk_dirname(myPath));
	console.log("dk_dirname.value = "+dk_dirname.value);
}