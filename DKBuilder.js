// JScript polyfills
var WshShell = function(){ return new ActiveXObject("WScript.Shell"); }
var XMLHttpRequest = function(){ return new ActiveXObject("MSXML2.XMLHTTP.6.0"); }
var FileSystem = function(){ return new ActiveXObject("Scripting.FileSystemObject"); }
var Document = function(){ return new ActiveXObject("Msxml2.DOMDocument.6.0"); 
	objXMLDoc.async = false;
	objXMLDoc.setProperty("ProhibitDTD", false);
	objXMLDoc.validateOnParse = false;
	return objXMLDoc;
}
var FileStream = function(){ return WScript.CreateObject('ADODB.Stream'); }
var console = function(){}
console.log = function(msg){ WScript.StdOut.Write(msg+"\n"); }
var DKSCRIPT_PATH = WScript.ScriptFullName;
var DKSCRIPT_DIR = new ActiveXObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName);


var ENABLE_dk_debugFunc = 0;
var DKHTTP_DK_JS = "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKJavascript/functions/DK.js";
//var DKBRANCH_DIR = "C:/Users/Administrator/digitalknob/Development"
var DKBRANCH_DIR = DKSCRIPT_DIR;
var DKJAVASCRIPT_DIR = DKBRANCH_DIR+"/DKJavascript";
var DKJAVASCRIPT_FUNCTIONS_DIR = DKJAVASCRIPT_DIR+"/functions";
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";
console.log(DK_JS);




dk_func = function(url){
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.open("GET", url, false);
	xmlHttpRequest.send();
	return xmlHttpRequest.responseText;
}

dk_source = function(url){ 
	(1, eval)(dk_func(url)); 
};

//dk_source(DKJAVASCRIPT_FUNCTIONS_DIR+"/dk_download.js");
var filesystem = new FileSystem;
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
dk_source(DK_JS);


//################## DKBuilder ####################
var wshshell = new WshShell;
//wshshell.Run(DK_JS);  //we can probobly just run this as a javascript function instead.
wshshell.Run(DKBRANCH_DIR+"/DKBuilder.cmd"); // Use Batch temorarily until javascript api is complete.
