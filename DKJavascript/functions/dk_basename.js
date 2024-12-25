//################################################################################
//# dk_basename(path)
//#
//#
dk_basename = function(path) {
	//dk_debugFunc(1);
	console.log("dk_basename("+path+")");
	if(typeof filesystem === "undefined") { 
		filesystem = new ActiveXObject("Scripting.FileSystemObject");
	}
	//console.log("path = "+filesystem.GetFolder(path);)
	return filesystem.GetBaseName (path);
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function() {
	//dk_debugFunc(0);
	
	console.log("DKTEST()");
	var myPath = "C:/Windows/System32";
    var basename = dk_basename(myPath);
    console.log("basename = "+basename);
}