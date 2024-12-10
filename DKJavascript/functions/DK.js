WScript.Echo("DK.js()");

if(typeof ActiveXObject === "function"){
	var XMLHttpRequest = function(){ return new ActiveXObject("MSXML2.XMLHTTP.6.0"); }
}
WScript.Echo("DK.js():6");
dk_source = function(url){
	var xmlHttpRequest = new XMLHttpRequest;
	xmlHttpRequest.open("GET", url, false);
	xmlHttpRequest.send();
	(1, eval)(xmlHttpRequest.responseText); 
}
dk_source(DKJAVASCRIPT_DIR+"/functions/dk_echo.js");
WScript.Echo("after dk_source");

var HOST = "unknown"
if(typeof ActiveXObject === "function"){
	if(typeof WScript === "object"){
		HOST = "jscript";
	}
	else{
		HOST = "hta"
	}
} else {
	HOST = "browser"
}
WScript.Echo("DK.js()");


//if(typeof WScript === "object"){
//	var DKSCRIPT_PATH = WScript.ScriptFullName;
//	var DKSCRIPT_DIR = new ActiveXObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName);
//}

//###### DKSCRIPT variables ######
var DKSCRIPT_PATH = location.href
var DKSCRIPT_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf("/"));
var DKSCRIPT_NAME = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1);
var DKSCRIPT_EXT = DKSCRIPT_NAME.substr(DKSCRIPT_NAME.lastIndexOf("."));

//###### DKHOME_DIR variables ######
var DIGITALKNOB = "digitalknob"
var DKHOME_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf(DIGITALKNOB)-1);
var DKCACHE_DIR = DKHOME_DIR+"/.dk"
var DKDESKTOP_DIR = DKHOME_DIR+"/Desktop"

//###### DIGITALKNOB_DIR variables ######
var DIGITALKNOB_DIR = DKHOME_DIR+"/"+DIGITALKNOB
var DKDOWNLOAD_DIR = DIGITALKNOB_DIR+"/download"
var DKTOOLS_DIR = DIGITALKNOB_DIR+"/DKTools"

//###### DKBRANCH_DIR variables ######
var DKBRANCH = "Development"
var DKBRANCH_DIR = DIGITALKNOB_DIR+"/"+DKBRANCH
var DK3RDPARTY_DIR = DKBRANCH_DIR+"/3rdParty"
var DKIMPORTS_DIR = DK3RDPARTY_DIR+"/_DKIMPORTS"
var DKAPPS_DIR = DKBRANCH_DIR+"/DKApps"
var DKBASH_DIR = DKBRANCH_DIR+"/DKBash"
var DKBASH_FUNCTIONS_DIR = DKBASH_DIR+"/functions"
var DKBASH_FUNCTIONS_DIR_ = DKBASH_DIR+"/functions/"
var DKBATCH_DIR = DKBRANCH_DIR+"/DKBatch"
var DKBATCH_FUNCTIONS_DIR = DKBATCH_DIR+"/functions"
var DKBATCH_FUNCTIONS_DIR_ = DKBATCH_DIR+"/functions/"
var DKC_DIR = DKBRANCH_DIR+"/DKC"
var DKC_FUNCTIONS_DIR = DKC_DIR+"/functions"
var DKC_FUNCTIONS_DIR_ = DKC_DIR+"/functions/"
var DKCMAKE_DIR = DKBRANCH_DIR+"/DKCMake"
var DKCMAKE_FUNCTIONS_DIR = DKCMAKE_DIR+"/functions"
var DKCMAKE_FUNCTIONS_DIR_ = DKCMAKE_DIR+"/functions/"
var DKCPP_DIR = DKBRANCH_DIR+"/DKCpp"
var DKCPP_FUNCTIONS_DIR = DKCPP_DIR+"/functions"
var DKCPP_FUNCTIONS_DIR_ = DKCPP_DIR+"/functions/"
var DKCSHARP_DIR = DKBRANCH_DIR+"/DKCSharp"
var DKCSHARP_FUNCTIONS_DIR = DKCSHARP_DIR+"/functions"
var DKCSHARP_FUNCTIONS_DIR_ = DKCSHARP_DIR+"/functions/"
var DKHTA_DIR = DKBRANCH_DIR+"/DKHta"
var DKHTA_FUNCTIONS_DIR = DKHTA_DIR+"/functions"
var DKHTA_FUNCTIONS_DIR_ = DKHTA_DIR+"/functions/"
var DKHTML_DIR = DKBRANCH_DIR+"/DKHta"
var DKHTML_FUNCTIONS_DIR = DKHTML_DIR+"/functions"
var DKHTML_FUNCTIONS_DIR_ = DKHTML_DIR+"/functions/"
var DKJAVA_DIR = DKBRANCH_DIR+"/DKJava"
var DKJAVA_FUNCTIONS_DIR = DKJAVA_DIR+"/functions"
var DKJAVA_FUNCTIONS_DIR_ = DKJAVA_DIR+"/functions/"
var DKJAVASCRIPT_DIR = DKBRANCH_DIR+"/DKJavascript"
var DKJAVASCRIPT_FUNCTIONS_DIR = DKJAVASCRIPT_DIR+"/functions"
var DKJAVASCRIPT_FUNCTIONS_DIR_ = DKJAVASCRIPT_DIR+"/functions/"
var DKPHP_DIR = DKBRANCH_DIR+"/DKPhp"
var DKPHP_FUNCTIONS_DIR = DKPHP_DIR+"/functions"
var DKPHP_FUNCTIONS_DIR_ = DKPHP_DIR+"/functions/"
var DKPLUGINS_DIR = DKBRANCH_DIR+"/DKPlugins"
var DKPOWERSHELL_DIR = DKBRANCH_DIR+"/DKPowershell"
var DKPOWERSHELL_FUNCTIONS_DIR = DKPOWERSHELL_DIR+"/functions"
var DKPOWERSHELL_FUNCTIONS_DIR_ = DKPOWERSHELL_DIR+"/functions/"
var DKPYTHON_DIR = DKBRANCH_DIR+"/DKPython"
var DKPYTHON_FUNCTIONS_DIR = DKPYTHON_DIR+"/functions"
var DKPYTHON_FUNCTIONS_DIR_ = DKPYTHON_DIR+"/functions/"
var DKVB_DIR = DKBRANCH_DIR+"/DKVb"
var DKVB_FUNCTIONS_DIR = DKVB_DIR+"/functions"
var DKVB_FUNCTIONS_DIR_ = DKVB_DIR+"/functions/"


var DK = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";



dk_source(DKJAVASCRIPT_DIR+"/polyfills/globalThis.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/window.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/Document.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/console.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/addEventListener.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/FileSystem.js");
dk_source(DKJAVASCRIPT_DIR+"/polyfills/WshShell.js");


dk_echo("DKTEST()");
DKTEST();
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
