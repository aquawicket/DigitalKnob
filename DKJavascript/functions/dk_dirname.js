//################################################################################
//# dk_dirname(path)
//#
//#    https://learn.microsoft.com/en-us/office/vba/language/reference/user-interface-help/filesystemobject-object
//#
dk_dirname = function dk_dirname_f(path){
	//dk_debugFunc(1);
	
	if(typeof filesystem === "undefined"){ 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	return filesystem.GetFolder(path);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
    var result = dk_dirname(myPath);
    console.log("result = "+result);
}