var ENABLE_dk_debugFunc = 1;
var assets = "file:///C:/Users/Administrator/digitalknob/Development";
var DKHTTP_DK_JS = "https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKJavascript/functions/DK.js";
var DKJAVASCRIPT_FUNCTIONS_DIR = "DKJavascript/functions";
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.cmd";


var globalThis = (function () {  
    return this || (1, eval)('this');  
}());  

dk_func = function(url){
	var IXMLHttpRequest = new ActiveXObject("MSXML2.XMLHTTP.6.0");
	IXMLHttpRequest.open("GET", url, false);
	IXMLHttpRequest.send();
	return IXMLHttpRequest.responseText;
}
dk_source = function(url){ 
	(1, eval)(dk_func(url)); 
};

// Instantiate the DOM object.
var objXMLDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");  
objXMLDoc.async = false;
objXMLDoc.setProperty("ProhibitDTD", false);
objXMLDoc.validateOnParse = false;

dk_source(assets+"/DKJavascript/JScript/dk_download.js");


dk_download(DKHTTP_DK_JS, "DK.cmd");


var FileSystem = new ActiveXObject("Scripting.FileSystemObject");
if(!FileSystem.FolderExists(DKJAVASCRIPT_FUNCTIONS_DIR)) { FileSystem.CreateFolder(DKJAVASCRIPT_FUNCTIONS_DIR); }
if(!FileSystem.FileExists(DK_JS)){ dk_download(DKHTTP_DK_JS, "DK.cmd"); }
if(!FileSystem.FileExists(DK_JS)){ WScript.StdOut.Write("ERROR: failed to download DK.js \n"); }


//################## DKBuilder ####################
var wshShell = new ActiveXObject("WScript.Shell");
//wshShell.Run(DK_JS);  //we can probobly just run this as a javascript function instead.
wshShell.Run("DKBuilder.cmd"); // Use Batch temorarily until javascript api is complete.
