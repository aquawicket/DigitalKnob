// JScript polyfills
var XMLHttpRequest = function(){ return new ActiveXObject("MSXML2.XMLHTTP.6.0"); }
dk_source = function(url){
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.open("GET", url, false);
	xmlHttpRequest.send();
	(1, eval)(xmlHttpRequest.responseText); 
}

var ENABLE_dk_debugFunc = 0;
var DKHTTP_DK_JS = "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKJavascript/functions/DK.js";
//var DKBRANCH_DIR = "C:/Users/Administrator/digitalknob/Development"
var DKSCRIPT_PATH = WScript.ScriptFullName;
var DKSCRIPT_DIR = new ActiveXObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName);
var DKBRANCH_DIR = DKSCRIPT_DIR;
var DKJAVASCRIPT_DIR = DKBRANCH_DIR+"/DKJavascript";
var DKJAVASCRIPT_FUNCTIONS_DIR = DKJAVASCRIPT_DIR+"/functions";
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";

// Download files if needed
var filesystem = new ActiveXObject("Scripting.FileSystemObject");
dk_download = function(url, destination){
	if (filesystem.FileExists(destination)){ return; }
	console.log("downloading "+url+"  to   "+destination+"\n");
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.Open('GET', url, false);
	xmlHttpRequest.Send();
	if (xmlHttpRequest.Status == 200) {
		var filestream = new FileStream;
		filestream.Open();
		filestream.Type = 1; // adTypeBinary
		filestream.Write(xmlHttpRequest.ResponseBody);
		filestream.Position = 0;
		if (filesystem.FileExists(destination)) { filesystem.DeleteFile(destination); }
		filestream.SaveToFile(destination, 2); // adSaveCreateOverWrite
		filestream.Close();
	}
}
if (!filesystem.FolderExists(DKJAVASCRIPT_DIR)){ filesystem.CreateFolder(DKJAVASCRIPT_DIR); }
if (!filesystem.FolderExists(DKJAVASCRIPT_FUNCTIONS_DIR)){ filesystem.CreateFolder(DKJAVASCRIPT_FUNCTIONS_DIR); }
if (!filesystem.FileExists(DK_JS)){ dk_download(DKHTTP_DK_JS, DK_JS); }
if (!filesystem.FileExists(DK_JS)){ console.log("ERROR: failed to download DK.js \n"); }

// ############ DKINIT ############
dk_source(DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js");
dk_source(DKJAVASCRIPT_FUNCTIONS_DIR+"/dk_download.js");









//dk_source(DK_JS);


//################## DKBuilder ####################
//var wshshell = new WshShell;
//wshshell.Run(DK_JS);  //we can probobly just run this as a javascript function instead.
//wshshell.Run(DKBRANCH_DIR+"/DKBuilder.cmd"); // Use Batch temorarily until javascript api is complete.
