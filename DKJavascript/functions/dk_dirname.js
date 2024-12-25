//################################################################################
//# dk_dirname(path)
//#
//#
dk_dirname = function(path) {
	//dk_debugFunc(1);
	console.log("dk_dirname("+path+")");
	if(typeof filesystem === "undefined") { 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	//console.log("path = "+filesystem.GetFolder(path);)
	return filesystem.GetFolder(path);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	console.log("DKTEST()");
	var myPath = "C:/Windows/System32";
    var result = dk_dirname(myPath);
    console.log("result = "+result);
}