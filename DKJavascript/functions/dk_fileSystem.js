

//################################################################################
//# dk_fileSystem()
//#
//#    Reference:https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
//dk_fileSystem = function dk_fileSystem_f(){
	//dk_debugFunc(0);
	if(!dk_valid("dk_fileSystem")){
		if(dk_valid("ActiveXObject")){
			dk_fileSystem = new ActiveXObject("Scripting.FileSystemObject");
		}
	}
	dk_assert("dk_fileSystem");
//}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	basename = dk_fileSystem.GetBaseName("C:/Windows/System32");
	dk_depend("dk_echo");
	dk_echo("basename = "+basename);
}
