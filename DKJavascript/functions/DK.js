
if(typeof WScript === "object"){
	var XMLHttpRequest = function(){ return new ActiveXObject("MSXML2.XMLHTTP.6.0"); }
	var DKSCRIPT_PATH = WScript.ScriptFullName;
	var DKSCRIPT_DIR = new ActiveXObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName);
}

var DKBRANCH_DIR = DKSCRIPT_DIR;
var DKJAVASCRIPT_DIR = DKBRANCH_DIR+"/DKJavascript";
var DKJAVASCRIPT_FUNCTIONS_DIR = DKJAVASCRIPT_DIR+"/functions";
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";

dk_source = function(url){
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.open("GET", url, false);
	xmlHttpRequest.send();
	(1, eval)(xmlHttpRequest.responseText); 
}

dk_source(DKJAVASCRIPT_DIR+"/polyfills/globalThis.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/window.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/Document.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/console.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/addEventListener.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/FileSystem.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/WshShell.js");



/*
if(typeof WScript === "object"){
	console.log("Using Windows Scriting Host")
	var WshShell = function(){ return new ActiveXObject("WScript.Shell"); }
	var Document = function(){ return new ActiveXObject("Msxml2.DOMDocument.6.0"); 
		objXMLDoc.async = false;
		objXMLDoc.setProperty("ProhibitDTD", false);
		objXMLDoc.validateOnParse = false;
		return objXMLDoc;
	}
	
	dk_download = function(url, destination){
		var filesystem = new FileSystem;
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
}
*/
