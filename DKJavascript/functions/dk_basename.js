


//################################################################################
//# dk_basename(path, rtn_var)
//#
//#
dk_basename = function dk_basename_f(){
	//dk_debugFunc(1);
	
	dk_depend("dk_fileSystem");
	dk_assert("dk_fileSystem.GetBaseName");
	dk_basename.value = dk_fileSystem.GetBaseName(arguments[0]);
	
	//###### output ######
	if(typeof arguments[1] !== "undefined"){
		arguments[1].value = dk_basename.value;
	} else {
		console.log(dk_basename.value);
	}
	return(dk_basename.value);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_depend("dk_echo");
	
	//### Result as global variable
	dk_echo("\n");
	dk_basename("A:/directoryA/filenameA.extA");
	dk_echo("dk_basename.value = "+dk_basename.value);
	
	//### Result as variable parameter
	dk_echo("\n");
	var resultB = {};
	dk_basename("B:/directoryB/filenameB.extB", resultB);
	dk_echo("resultB = "+resultB.value);
	dk_echo("dk_basename.value = "+dk_basename.value);
	
	//### Result as return value
	dk_echo("\n");
	resultC = dk_basename("C:/directoryC/filenameC.extC");
	dk_echo("resultC = "+resultC);
	dk_echo("dk_basename.value = "+dk_basename.value);
	
}