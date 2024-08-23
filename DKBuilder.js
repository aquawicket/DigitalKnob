var ENABLE_dk_debugFunc = 1;
var DKHTTP_DK_JS = "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKJavascript/functions/DK.js";
var DKJAVASCRIPT_DIR = "C:/Users/Administrator/digitalknob/Development/DKJavascript";
var DKJAVASCRIPT_FUNCTIONS_DIR = DKJAVASCRIPT_DIR+"/functions";
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";

var globalThis = (function () {  
    return this || (1, eval)('this');  
}());  

dk_func = function(url){
	var xmlHttpRequest = new ActiveXObject("MSXML2.XMLHTTP.6.0");
	xmlHttpRequest.open("GET", url, false);
	xmlHttpRequest.send();
	return xmlHttpRequest.responseText;
}
dk_source = function(url){ 
	(1, eval)(dk_func(url)); 
};

// Instantiate the DOM object.
var objXMLDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");  
objXMLDoc.async = false;
objXMLDoc.setProperty("ProhibitDTD", false);
objXMLDoc.validateOnParse = false;

//dk_source(DKJAVASCRIPT_FUNCTIONS_DIR+"/dk_download.js");
var FileSystem = new ActiveXObject("Scripting.FileSystemObject");
dk_download = function(url, destination){
	if (!FileSystem.FolderExists(destination)){ return; }
	var Object = WScript.CreateObject('MSXML2.XMLHTTP');
	Object.Open('GET', url, false);
	Object.Send();
	if (Object.Status == 200) {
		var Stream = WScript.CreateObject('ADODB.Stream');
		Stream.Open();
		Stream.Type = 1; // adTypeBinary
		Stream.Write(Object.ResponseBody);
		Stream.Position = 0;
		var File = WScript.CreateObject('Scripting.FileSystemObject');
		if (File.FileExists(destination)) { File.DeleteFile(destination); }
		Stream.SaveToFile(destination, 2); // adSaveCreateOverWrite
		Stream.Close();
	}
}


if (!FileSystem.FolderExists(DKJAVASCRIPT_DIR)){ FileSystem.CreateFolder(DKJAVASCRIPT_DIR); }
if (!FileSystem.FolderExists(DKJAVASCRIPT_FUNCTIONS_DIR)){ FileSystem.CreateFolder(DKJAVASCRIPT_FUNCTIONS_DIR); }
if (!FileSystem.FileExists(DK_JS)){ dk_download(DKHTTP_DK_JS, DK_JS); }
if (!FileSystem.FileExists(DK_JS)){ WScript.StdOut.Write("ERROR: failed to download DK.js \n"); }
dk_source(DK_JS);
//dk_source("file:///"+DK_JS);

//################## DKBuilder ####################
var wshShell = new ActiveXObject("WScript.Shell");
//wshShell.Run(DK_JS);  //we can probobly just run this as a javascript function instead.
wshShell.Run("DKBuilder.cmd"); // Use Batch temorarily until javascript api is complete.
