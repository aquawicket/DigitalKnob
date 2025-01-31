var index = "../../DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";
var USE_FILESYSTEM = 0;
var USE_NODEJS=1;

//###### Console ######
(function(con) {
	'use strict';
	var prop, method;
	var empty = {};
	if(typeof ActiveXObject === "function"){
		if(typeof WScript === "object"){
			var print = function(msg) { WScript.StdOut.Write(msg+"\n"); };
		} else {
			var print = function(msg) {
				// https://stackoverflow.com/a/52793021/688352
				//var WShell = new ActiveXObject('WScript.Shell');
				//var WShellExec = WShell.Exec("cmd /c echo "+msg);
				if(typeof dkconsole === "object"){
					dkconsole.log(msg);
				}
			}
		}
	}
	var properties = 'memory'.split(',');
	var methods = ('assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn').split(',');
	while (prop = properties.pop()) con[prop] = con[prop] || empty;
	while (method = methods.pop()) con[method] = con[method] || print;
})(this.console = this.console || {});


//############ dk_check ############
dk_check = function(object){
	if(typeof this[object] === "undefined"){console.error(object+" is invalid\n");}
  //if(typeof this[object] !== "undefined"){console.debug(object+" is valid\n");}
}










//############ HOST ############
var HOST = "unknown"
if(typeof ActiveXObject === "function"){
	if(typeof WScript === "object"){ HOST = "jscript"; }
	else{ HOST = "hta" }
} else { HOST = "browser" }
dk_check('HOST');


//############ ARGV, ARGC ############
if(typeof WScript === "object"){
	ARGV = WScript.Arguments;
	ARGC = WScript.Arguments.Count();
	for (i=0; i<ARGV.length; i++){
		console.log("ARGV"+i+" = "+ARGV(i)+"\n");
	}
}
//dk_check('WScript.Arguments');


//############ globalThis ############
if(typeof globalThis === "undefined") {
	var globalThis = (function () {  
		return this || (1, eval)('this');  
	}());
}
dk_check('globalThis');


//############ window ############
if(typeof window === "undefined") {
	var window = (function () {  
		return this || (1, eval)('this');  
	}());
}
dk_check('window');


//############ String.prototype.replaceAll (polyfill) ############
if(typeof String.prototype.replaceAll === "undefined") {
	String.prototype.replaceAll = function replaceAll(search, replace) { 
		return this.split(search).join(replace); 
	}
}
//dk_check('String.prototype.replaceAll');


//############ XMLHttpRequest ############
if(typeof XMLHttpRequest == "undefined"){ // || !ie7xmlhttp) {
	if(typeof ActiveXObject === "function"){
		XMLHttpRequest = function() {
			return new ActiveXObject("Msxml2.XMLHTTP.6.0");
		}
	}
}
dk_check('XMLHttpRequest');


//############ dk_source ############
if(typeof dk_source === "undefined") {
	dk_source = function(url, callback){
		var url = url.replaceAll("\\", "/");
		//############ Msxml2.XMLHTTP.6.0 ############
		if(typeof WScript === "object"){
			if(USE_FILESYSTEM == 1){
				// C:/Path/Format
				(1, eval)((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile(url, 1).ReadAll());
			} else {
				// file:///C:/Path/Format
				var xmlHttpRequest = new XMLHttpRequest;
				xmlHttpRequest.open("GET", url, true);
				xmlHttpRequest.send();
				eval(xmlHttpRequest.responseText);
			}
			if(callback){
				callback();
			}
		} else { //############ Browsers ############
			// file:///C:/Path/Format
			var script = document.createElement("script");
			script.src = url;  
			if (callback) {
				script.onreadystatechange = function () { // IE < 7, does not support onload
					if (script.readyState === "loaded" || script.readyState === "complete") {
						script.onreadystatechange = null; // no need to be notified again
						callback();
					}
				};
				script.onload = function () { // other browsers
					callback();
				};
			}
			document.documentElement.firstChild.appendChild(script);
		}	
	}
}
dk_check('dk_source');


//############ DOMDocument ############
if(typeof ActiveXObject === "function"){
	if(typeof document === "undefined"){ 
		var document = new ActiveXObject("Msxml2.DOMDocument.6.0");  
		document.async = true;
		document.setProperty("ProhibitDTD", false);
		document.validateOnParse = false;
		document.load(index);
		if(document.parseError.errorCode !== 0){
			if(typeof WScript !== "undefined"){
				console.error("ERROR when loading " + index + ": " + document.parseError.reason);
			}
		}
	}
}
dk_check('document');


//############ wscript_shell ############
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell === "undefined"){ 
		var wscript_shell = new ActiveXObject("WScript.Shell");
	}
}
dk_check('wscript_shell');

/*
//############ document ############
if(typeof document === "undefined"){ 
	var document = domDocument.documentElement;
	//console.log("document: "+document.xml+"\n\n");
}
dk_check('document');
*/


//############ location ############
if(typeof location === "undefined"){ 
	var location = new Object;
	location.href = domDocument.url;
	console.log("location.href = "+location.href);
}
dk_check('location');


//############ queryString ############
var queryString = "undefined"
if(typeof location === "object") {
	if(typeof location.search === "string") {
		queryString = location.search;
	}
	else if(typeof location.href === "string") {
		queryString=location.href.split('?')[1];
	}
}
dk_check('queryString');

//###### DKSCRIPT variables ######
if(typeof ARGV !== "undefined"){
	var href = ARGV(0).replaceAll("\\", "/");
	var DKSCRIPT_PATH = href;
} else {
	var DKSCRIPT_PATH = location.href;
}
var DKSCRIPT_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf("/"));
var DKSCRIPT_FILE = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1);
var DKSCRIPT_NAME = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1, (DKSCRIPT_PATH.lastIndexOf(".") - DKSCRIPT_PATH.lastIndexOf("/")-1));
var DKSCRIPT_EXT = DKSCRIPT_FILE.substr(DKSCRIPT_FILE.lastIndexOf("."));



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


//############ alert ############
if(typeof alert === "undefined"){
	dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js", function(){
		//alert("test");
	});
}
dk_check('alert');

/*
//############ console ############
if(typeof console === "undefined"){
	dk_source(assets+"/DKJavascript/polyfills/console.js", function(){
		//console.log(dkTitle);
		console.log("loaded console.log");
		console.log("HOST = "+HOST);
	});
}
dk_check('console');
*/

//############ document.addEventListener ############
if(typeof document.addEventListener !== "undefined"){
	document.addEventListener("DOMContentLoaded", onDOMContentLoaded());
}
//dk_check('document.addEventListener');


//############ onDOMContentLoaded ############
//if(typeof onDOMContentLoaded === "undefined"){
	function onDOMContentLoaded() {
		if(!window){ alert("window is invalid"); return; }
		if(!document){ alert("document is invalid"); return; }
		if(!window.document){ alert("window.document is invalid"); return; }
			
		var DKHtml = 1;
		dkTitle = "DigitalKnob - " + location.href;
		if(typeof document.title !== "undefined"){
			document.title = dkTitle;
		}
	}
//}
dk_check('onDOMContentLoaded');


//############ body_onload ############
//if(typeof body_onload === "undefined"){
	function body_onload(){
		if(!window.document.body){ alert("window.document.body is invalid"); return; }
		
		
		if(DKSCRIPT_FILE === "index.html"){
			var APP_NAME = DKSCRIPT_DIR.substr(DKSCRIPT_DIR.lastIndexOf("/")+1);
			dk_source(DKJAVASCRIPT_DIR+"/apps/"+APP_NAME+"/main.js", function(){
				main();
			});
		}
	
/*
		dk_source(DKJAVASCRIPT_DIR+"/functions/DKHtmlConsole.js", function(){
			dkconsole = new DKHtmlConsole;
			dkconsole.create("","0px","0px","0px","","25%");
			dk_source(DKJAVASCRIPT_DIR+"/functions/DKEventMonitor.js", function(){
				eventmonitor = new DKEventMonitor;
				eventmonitor.monitorEvents(window);
				eventmonitor.monitorEvents(document);
				eventmonitor.monitorEvents(document.body);
			});
		});
		
		console.log("loaded console.log");
		//console.log(dkTitle);
		console.log("HOST = "+HOST);
*/
	}
//}
dk_check('body_onload');

//dk_source(DKJAVASCRIPT_DIR+"/polyfills/globalThis.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/window.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/Document.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/addEventListener.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/FileSystem.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/WshShell.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/replaceAll.js");
dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js");

//############ DKTEST ############
if(typeof ARGV !== "undefined"){
	if(typeof ARGV(0) === "string"){
		dk_source(ARGV(0), function(){
		//if(DKSCRIPT_EXT !== ".js"){ return }
		//if(!dk_fileContains(DKSCRIPT_PATH, ":DKTEST")){ return }
		console.log("")
		console.log(bg_magenta+white+"###### DKTEST MODE ###### "+DKSCRIPT_FILE+" ###### DKTEST MODE ######"+clr)
		console.log("")
			DKTEST();
		console.log("")
		console.log(bg_magenta+white+"######## END TEST ####### "+DKSCRIPT_FILE+" ######## END TEST #######"+clr)
		console.log("")
		});
	}
}
