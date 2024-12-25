//################################################################################
//# dk_dirname(path)
//#
//#
dk_dirname = function(path) {
	//dk_debugFunc(1);
	
	if(typeof filesystem === "undefined") { 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	return filesystem.GetFolder(path);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	var myPath = "C:/Windows/System32";
    var result = dk_dirname(myPath);
    console.log("result = "+result);
}