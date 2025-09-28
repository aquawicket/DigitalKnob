var index = "file:///C:/Users/Administrator/DigitalKnob/Development/DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/DigitalKnob/Development";
var USE_FILESYSTEM = 0;
var USE_NODEJS=0;

/*
function stringify(obj) {
    var str = '';
    for (var p in obj) {
        if (Object.prototype.hasOwnProperty.call(obj, p)) {
            str += p + '::' + obj[p] + '\n';
        }
    }
    return str;
}
*/

//###### console.log ######
(function(con){
	'use strict';
	var prop, method;
	var empty = {};
	
	//### print
	if(typeof ActiveXObject === "function"){
		if(typeof WScript === "object"){
			if(typeof WScript.StdOut !== "undefined"){
				var print = function(msg){ WScript.StdOut.Write(msg+"\n"); }
			}
		}		
	} else if(typeof dkconsole === "object"){
		var print = function(msg){ dkconsole.log(msg); }
	} else {
		alert("ERROR in console");
	}

  //var assert         = function(msg){ print(msg); }
  //var count          = function(msg){ print(msg); }
	var debug          = function(msg){ print("\x1b[94m"+msg+"\x1b[0m"); }
  //var dir            = function(msg){ print(msg); }
  //var dirxml         = function(msg){ print(msg); }
	var info           = function(msg){ print("\x1b[37m"+msg+"\x1b[0m"); }
	var error          = function(msg){ print("\x1b[91m"+msg+"\x1b[0m"); }
  //var exception      = function(msg){ print(msg); }
  //var group          = function(msg){ print(msg); }
  //var groupCollapsed = function(msg){ print(msg); }
  //var groupEnd       = function(msg){ print(msg); }
  //var log            = function(msg){ print(msg); }
  //var markTimeline   = function(msg){ print(msg); }
  //var profile        = function(msg){ print(msg); }
  //var profileEnd     = function(msg){ print(msg); }
  //var time           = function(msg){ print(msg); }
  //var timeEnd        = function(msg){ print(msg); }
  //var trace          = function(msg){ print(msg); }
	var warn           = function(msg){ print("\x1b[33m"+msg+"\x1b[0m"); }
	
		
	var properties = 'memory'.split(',');
	var methods = ('assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn').split(',');
	while (prop = properties.pop()){
		con[prop] = con[prop] || empty;
	}
	while (method = methods.pop()){
		     if(method === "")              { con[method] = con[method] || print;          }
	  //else if(method === "assert")        { con[method] = con[method] || assert;         }
	  //else if(method === "count")         { con[method] = con[method] || count;          }
		else if(method === "debug")         { con[method] = con[method] || debug;          }
	  //else if(method === "dir")	        { con[method] = con[method] || dir;            }
	  //else if(method === "dirxml")        { con[method] = con[method] || dirxml;         }
		else if(method === "info")          { con[method] = con[method] || info;           }
		else if(method === "error")         { con[method] = con[method] || error;          }
	  //else if(method === "exception")     { con[method] = con[method] || exception;      }
	  //else if(method === "group")         { con[method] = con[method] || group;          }
	  //else if(method === "groupCollapsed"){ con[method] = con[method] || groupCollapsed; }
	  //else if(method === "groupEnd")      { con[method] = con[method] || groupEnd;       }
	  //else if(method === "log")           { con[method] = con[method] || log;            }
	  //else if(method === "markTimeline")  { con[method] = con[method] || markTimeline;   }
	  //else if(method === "profile")       { con[method] = con[method] || profile;        }
	  //else if(method === "profileEnd")    { con[method] = con[method] || profileEnd;     }
	  //else if(method === "time")          { con[method] = con[method] || time;           }
	  //else if(method === "timeEnd")       { con[method] = con[method] || timeEnd;        }
	  //else if(method === "trace")         { con[method] = con[method] || trace;          }	
		else if(method === "warn")          { con[method] = con[method] || warn;           }
		else                                { con[method] = con[method] || print;          }
	}
})(this.console = this.console || {});

//############ NodeJS ############
if(USE_NODEJS){
	dk_validate(DKIMPORTS_DIR, "dk_DKIMPORTS_DIR");
	dk_validate(nodejs_exe, DKIMPORTS_DIR+"/nodejs/dk_install.js")
	
	//COMSPEC = dk_env("%COMSPEC%")
	WScript_Shell = new ActiveXObject("WScript.Shell");
	WScript_Shell.Run('start '+nodejs_exe+' '+DKJAVASCRIPT_FUNCTIONS_DIR+'\DKNodeServer.js')
	WScript_Shell.Run('explorer "http://127.0.0.1:8080/Users/Administrator/DigitalKnob/Development/DKHtml/index.html?DKTEST="+DKSCRIPT_PATH')
}

//##############################################################
//# dk_valid(<objectPath>)
//#
//#		Takes a string of an object path to test. I.E. dk_valid('window.navigator.userAgent')
//#		Returns true if the object path exists and False if the object path is undefined.
//#
dk_valid = function(){
	if(typeof arguments[0] !== "string"){
		console.error("dk_valid(): arg1 must be a string");
		return -1;
	}
	if(typeof this === "undefined"){
		console.error("dk_valid(): requires a valid 'this' object.");
		return -1;
	}
	var arry = arguments[0].split(".");
	if(typeof this[arry[0]] === "undefined"){
		//console.error("dk_valid(): "+arry[0]+" is invalid.");
		return false;
	}
	
	/*
	if(arry[0] === "globalThis"){ arry.shift(); }
	if(arry[0] === "window"){ arry.shift(); }
	if(arry[0] === "self"){ arry.shift(); }
	*/
	
	currentObject = this;
	result = true;
	
	for (var i = 0; i < arry.length; i++) {
		result = false;
		if(typeof currentObject[arry[i]] !== "undefined"){
			if(i < arry.length-1){
				currentObject = currentObject[arry[i]];
				continue;
			}
			result = true;
		}
		if(result === false){
			break;
		}
	}
	return result;
}

//############ dk_assert ############
dk_assert = function(object){
	if(!dk_valid(object)){ console.error(object+" is invalid\n"); }
}




//########### DKENGINE ###########
if(!dk_valid("DKScriptEngine")){
	if(dk_valid("ScriptEngine")){
		var DKScriptEngine = ScriptEngine();
		var DKScriptEngine_Version = ScriptEngineMajorVersion()+"."+ScriptEngineMinorVersion()+"."+ScriptEngineBuildVersion();
	}
}
//dk_assert("DKScriptEngine");
///dk_assert("DKScriptEngine_Version");

//############ globalThis ############
if(!dk_valid("globalThis")){
	var globalThis = (function (){  
		return this || (1, eval)('this');  
	}());
}
dk_assert("globalThis");

//############ window ############
if(!dk_valid("window")){
	var window = (function Window(){
		return this || (1, eval)('this');  
	}());
}
dk_assert('window');

//############ dk ############
window.dk = new Object;

//############ dk_call ############
if(!dk_valid("dk_call")){
	dk_call = function dk_call(){
		var _ARGV_ = "";
		for (var i = 0; i < arguments.length; i++) {_ARGV_ += ", "+arguments[i];}
		console.log("dk_call("+_ARGV_+")");

		var arry = arguments[0].split(".");
		if(!dk_valid("window")){ 
			console.error("window is invalid");
			return false; 
		}

		var currentObject = window;
		for (var i = 1; i < arry.length-1; i++) {
			console.log("\n")
			if(typeof currentObject[arry[i]] === "object"){
				currentObject = currentObject[arry[i]];
			}
			if(typeof currentObject[arry[i]] === "function"){
				currentObject = currentObject[arry[i]]();
			}
			console.log("typeof currentObject "+i+" = "+ typeof currentObject);
		}
	}
}

//############ DKBrowser ############
if(!dk_valid("DKBrowser")){
	DKBrowser = function DKBrowser_f(){
		var output = [];
		var hasNavigator = dk_valid('window.navigator');
		console.log("hasNavigator = "+hasNavigator);
		
		// Hta
		var isHta = dk_valid("window.ActiveXObject") && dk_valid("window.WScript");
		if(isHta){ output.push("isHta"); }

		// Brave
		var isBrave = dk_valid("window.navigator.brave.isBrave.name");
		if(isBrave){ output.push("isBrave"); }

		// Opera 8.0+
		var isOpera = dk_valid("window.opr.addons") || dk_valid("window.oprera") || (dk_valid("window.navigator.userAgent.indexOf") && (navigator.userAgent.indexOf(' OPR/') >= 0));
		if(isOpera){ output.push("isOpera"); }

		// Firefox 1.0+
		var isFirefox = dk_valid("window.InstallTrigger");
		if(isFirefox){ output.push("isFirefox"); }

		// Safari 3.0+ "[object HTMLElementConstructor]" 
		var isSafari = dk_valid("window.HTMLElement") && /constructor/i.test(window.HTMLElement) 
		|| (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && window['safari'].pushNotification));
		if(isSafari){ output.push("isSafari"); }

		// Internet Explorer 6-11
		var isIE = /*@cc_on!@*/false || dk_valid("document.documentMode");
		if(isIE){ output.push("isIE"); }

		// Edge 20+
		var isEdge = !isIE && dk_valid("window.StyleMedia");
		if(isEdge){ output.push("isEdge"); }

		// Chrome 1 - 79
		var isChrome = dk_valid("window.chrome") && dk_valid("window.chrome.webstore") || dk_valid("window.chrome.runtime");
		if(isChrome){ output.push("isChrome"); }

		// Edge (based on chromium) detection
		var isEdgeChromium = isChrome && dk_valid("window.navigator.userAgent.indexOf") && (window.navigator.userAgent.indexOf("Edg") != -1);
		if(isEdgeChromium){ output.push("isEdgeChromium"); }

		// Blink engine detection
		var isBlink = (isChrome || isOpera) && dk_valid("window.CSS");
		if(isBlink){ output.push("isBlink"); }

		return output.toString();
	}
}
dk_assert('DKBrowser');
console.log("DKBrowser() = "+DKBrowser());








//############ ARGV, ARGC ############
if(dk_valid("WScript.Arguments")){
	ARGC = WScript.Arguments.Count();
	var ARGV = new Array(ARGC);
    for(var i = 0; i < ARGV.length; ++i){
        ARGV[i] = WScript.Arguments(i);
		//console.log("ARGV["+i+"] = "+ARGV[i]);
    }
	//console.log("ARGV = "+ARGV+"\n");
	//console.log("ARGC = "+ARGC+"\n");
	dk_assert("ARGV");
	dk_assert("ARGC");
}








//############ String.prototype.replaceAll (polyfill) ############
if(!dk_valid("String.prototype.replaceAll")){
	String.prototype.replaceAll = function replaceAll(search, replace){ 
		return this.split(search).join(replace); 
	}
}
dk_assert('String.prototype.replaceAll');


//############ XMLHttpRequest ############
if(!dk_valid("XMLHttpRequest")){ // || !ie7xmlhttp){
	if(typeof ActiveXObject === "function"){
		XMLHttpRequest = function(){
			return new ActiveXObject("Msxml2.XMLHTTP.6.0");
		}
		console.log("XMLHttpRequest = "+typeof XMLHttpRequest);
	}
}
dk_assert('XMLHttpRequest');


//############ dk_source ############
if(!dk_valid("dk_source")){
	dk_source = function dk_source_f(url, dk_source_callback){
		//console.log("dk_source("+url+")");
		var url = url.replaceAll("\\", "/");
		//############ Msxml2.XMLHTTP.6.0 ############
		if(typeof WScript === "object"){
			if(USE_FILESYSTEM == 1){
				// C:/Path/Format
				var url = url.replaceAll("file:///", "");
				console.log("url = "+url);
				(1, eval)((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile(url, 1).ReadAll());
			} else {
				// file:///C:/Path/Format
				var xmlHttpRequest = new XMLHttpRequest;
				xmlHttpRequest.open("GET", url, true);
				xmlHttpRequest.send();
				
				//if(typeof xmlHttpRequest.responseText !== "undefined"){
					//console.log("###################################################################");
					//console.log("###################################################################");
					//console.log("###################################################################");
					//console.log(xmlHttpRequest.responseText);
					//eval(xmlHttpRequest.responseText);
					var fn = Function(xmlHttpRequest.responseText);
					fn();
					//console.log("###################################################################");
					//console.log("###################################################################");
					//console.log("###################################################################");
				//}
			}
			//console.log("checking for callback");
			if(dk_source_callback){
				//console.log("dk_source_callback");
				dk_source_callback();
				return;
			} else {
				//console.log("no dk_source_callback");
			}
		
		//################## Browsers ##################
		} else if(dk_valid("document.createElement")){ 
			// file:///C:/Path/Format
			var script = document.createElement("script");
			script.src = url;  
			if (dk_source_callback){
				script.onreadystatechange = function (){ // IE < 7, does not support onload
					if (script.readyState === "loaded" || script.readyState === "complete"){
						script.onreadystatechange = null; // no need to be notified again
						dk_source_callback();
					}
				};
				script.onload = function (){ // other browsers
					dk_source_callback();
				};
			}
			document.documentElement.firstChild.appendChild(script);
		}	
	}
}
dk_assert('dk_source');

//############ document ############
if(typeof document === "undefined"){ 
	if(typeof ActiveXObject === "function"){
		var document = new ActiveXObject("Msxml2.DOMDocument.6.0");
		console.log("document = "+typeof document);
		document.async = true;
		document.setProperty("ProhibitDTD", false);
		document.validateOnParse = false;
		document.load(index);
		if(document.parseError.errorCode !== 0){
			console.error("ERROR when loading " + index + ": " + document.parseError.reason);
		}
	}
}
dk_assert('document');

//############ WScript_Shell ############
if(typeof ActiveXObject === "function"){
	if(!dk_valid("WScript_Shell")){
		WScript_Shell = function(){
			WScript_Shell = new ActiveXObject("WScript.Shell");
			return WScript_Shell;
		}
	} 
}
//dk_assert('WScript_Shell');

/*
//############ documentElement ############
if(!dk_valid("documentElement")){ 
	var documentElement = document.documentElement;
	//console.log("documentElement: "+documentElement.xml+"\n\n");
}
dk_assert('documentElement');
*/

//############ location ############
if(!dk_valid("location")){
	var location = new Object;
}
dk_assert('location');

//######### location.href #########
if(!dk_valid("location.href")){
	if(typeof document.url !== "undefined"){
		location.href = document.url;
	}
}
dk_assert("location.href");
console.log("location.href = "+location.href);

//######### DKSCRIPT_PATH / DKSCRIPT_ARGS #########
if(!dk_valid("DKSCRIPT_PATH")){
		
	if(dk_valid("location.href")){
		var DKSCRIPT_PATH = location.href;
	}
	else if(dk_valid("WScript_Shell")){
		WScript_Shell();
		if(dk_valid("WScript_Shell.ExpandEnvironmentStrings")){
			var DKSCRIPT_PATH = WScript_Shell.ExpandEnvironmentStrings("%DKSCRIPT_PATH%");//.replaceAll("\\", "/");
			var DKSCRIPT_ARGS = WScript_Shell.ExpandEnvironmentStrings("%DKSCRIPT_ARGS%");
		}
	}
}
dk_assert("DKSCRIPT_PATH");
console.log("DKSCRIPT_PATH = "+DKSCRIPT_PATH);

//######### DKSCRIPT_DIR ############
if(!dk_valid("DKSCRIPT_DIR")){
	DKSCRIPT_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf("/"));
}
dk_assert("DKSCRIPT_DIR");
console.log("DKSCRIPT_DIR = "+DKSCRIPT_DIR);

//######### DKSCRIPT_FILE ############
if(!dk_valid("DKSCRIPT_FILE")){
	DKSCRIPT_FILE = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1); 
}
dk_assert("DKSCRIPT_FILE");
console.log("DKSCRIPT_FILE = "+DKSCRIPT_FILE);

//######### DKSCRIPT_NAME ############
if(!dk_valid("DKSCRIPT_NAME")){
	DKSCRIPT_NAME = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1, (DKSCRIPT_PATH.lastIndexOf(".") - DKSCRIPT_PATH.lastIndexOf("/")-1)); 
}
dk_assert("DKSCRIPT_NAME");
console.log("DKSCRIPT_NAME = "+DKSCRIPT_NAME);

//######### DKSCRIPT_EXT ############
if(!dk_valid("DKSCRIPT_EXT")){
	DKSCRIPT_EXT = DKSCRIPT_FILE.substr(DKSCRIPT_FILE.lastIndexOf(".")); 
}
dk_assert("DKSCRIPT_EXT");
console.log("DKSCRIPT_EXT = "+DKSCRIPT_EXT);

//###### DKHOME_DIR variables ######
if(!dk_valid("DIGITALKNOB")){ var DIGITALKNOB = "DigitalKnob"; }
var DKHOME_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf(DIGITALKNOB)-1).replaceAll("file:///", "");
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
var DKCPP_APPS_DIR = DKBRANCH_DIR+"/DKCpp/DKCpp/apps"
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
var DKCPP_APPS_DIR = DKCPP_DIR+"/DKCpp/apps"
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
var DKCPP_PLUGINS_DIR = DKBRANCH_DIR+"/DKPlugins"
var DKPOWERSHELL_DIR = DKBRANCH_DIR+"/DKPowershell"
var DKPOWERSHELL_FUNCTIONS_DIR = DKPOWERSHELL_DIR+"/functions"
var DKPOWERSHELL_FUNCTIONS_DIR_ = DKPOWERSHELL_DIR+"/functions/"
var DKPYTHON_DIR = DKBRANCH_DIR+"/DKPython"
var DKPYTHON_FUNCTIONS_DIR = DKPYTHON_DIR+"/functions"
var DKPYTHON_FUNCTIONS_DIR_ = DKPYTHON_DIR+"/functions/"
var DKVB_DIR = DKBRANCH_DIR+"/DKVb"
var DKVB_FUNCTIONS_DIR = DKVB_DIR+"/functions"
var DKVB_FUNCTIONS_DIR_ = DKVB_DIR+"/functions/"
var DK_JS = DKJAVASCRIPT_FUNCTIONS_DIR+"/DK.js";


//############ queryString ############
var queryString = "undefined"
if(typeof location === "object"){
	if(typeof location.search === "string"){
		queryString = location.search;
	}
	else if(typeof location.href === "string"){
		queryString = location.href.split('?')[1];
	}
}
//dk_assert('queryString');

//###### DKSCRIPT variables ######
//if(dk_valid("ARGV") && ARGV.length > 0){
//	if(ARGV.length > 1){
//		var href = ARGV(1).replaceAll("\\", "/");
//	} else {
//		var href = ARGV(0).replaceAll("\\", "/");
//	}
//	var DKSCRIPT_PATH = href;
//} else {
//	var DKSCRIPT_PATH = location.href;
//}

//############ alert() ############
if(!dk_valid("alert")){ dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js", function(){ /*alert("test");*/ }); }
dk_assert('alert');
//alert('test');

/*
//############ console ############
if(!dk_valid("console"){
	dk_source(assets+"/DKJavascript/polyfills/console.js", function(){
		console.log("loaded console.js");
	});
}
dk_assert('console');
*/

//############ onDOMContentLoaded() ############
if(!dk_valid("onDOMContentLoaded")){
	function onDOMContentLoaded(){
		console.log("onDOMContentLoaded()")
		if(!window){ alert("window is invalid"); return; }
		if(!document){ alert("document is invalid"); return; }
		if(!window.document){ alert("window.document is invalid"); return; }
			
		var DKHtml = 1;
		dkTitle = "DigitalKnob - " + location.href;
		if(typeof document.title !== "undefined"){
			document.title = dkTitle;
		}
	}
}
dk_assert('onDOMContentLoaded');

//############ document.addEventListener ############
if(dk_valid("document.addEventListener")){ 
	if(dk_valid("document.addEventListener")){
		document.addEventListener("DOMContentLoaded", onDOMContentLoaded());
	}
}


//############ body_onload ############
function body_onload(){
	console.log("body_onload()");
	
	dk_assert('window.document.body');
	/*
	if(!dk_valid("window.document.body")){ 
		alert("window.document.body is invalid"); 
		return; 
	}
	*/
	
	if(DKSCRIPT_FILE === "index.html"){
		var APP_NAME = DKSCRIPT_DIR.substr(DKSCRIPT_DIR.lastIndexOf("/")+1);
		dk_source(DKJAVASCRIPT_DIR+"/apps/"+APP_NAME+"/main.js", function dk_source_callback(){
			main();
		});
	}
}
dk_assert('body_onload');

//if(!dk_valid("globalThis"))		{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/globalThis.js"); 		}
//if(!dk_valid("window"))			{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/window.js"); 			}
//if(!dk_valid("Document"))			{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/Document.js"); 		}
//if(!dk_valid("alert"))			{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js"); 			}
//if(!dk_valid("addEventListener"))	{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/addEventListener.js"); }
//if(!dk_valid("FileSystem"))		{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/FileSystem.js"); 		}
//if(!dk_valid("WshShell"))			{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/WshShell.js"); 		}
//if(!dk_valid("replaceAll"))		{ dk_source(DKJAVASCRIPT_DIR+"/polyfills/replaceAll.js"); 		}
if(!dk_valid("dk_depend"))			{ dk_source(DKJAVASCRIPT_DIR+"/functions/dk_depend.js"); 		}
dk_depend("dk_color");
//dk_depend("DKPlugin");
//dk_depend("DKFile");
//dk_depend("DKGui");
//dk_depend("DKErrorHandler");
//dk_depend("dk_color", function dk_color_callback(){}); }


//############ DKTEST ############
if(dk_valid("ARGV")){ 
	if(ARGC > 0){ var JS_PATH = ARGV[0]; }
	if(ARGC > 1){ var JS_ARGS = ARGV[1]; }
	var JS_DIR = JS_PATH.substr(0, JS_PATH.lastIndexOf("/"));
	var JS_FILE = JS_PATH.substr(JS_PATH.lastIndexOf("/")+1);
	var JS_NAME = JS_PATH.substr(JS_PATH.lastIndexOf("/")+1, (JS_PATH.lastIndexOf(".") - JS_PATH.lastIndexOf("/")-1));
	var JS_EXT = JS_FILE.substr(JS_FILE.lastIndexOf("."));
	dk_source(JS_PATH, function dk_source_callback(){

		//############ DKTEST MODE ############
		if(JS_EXT !== ".js"){ return }
		//if(dk_fileContains(DKSCRIPT_PATH, "DKTEST = function DKTEST_callback()") > 1){ return }
		console.log(bg_magenta+white+"\n######## DKJAVASCRIPT TEST MODE ###### "+JS_FILE+" ######## DKJAVASCRIPT TEST MODE ######"+clr+"\n");
		DKTEST(); // if(DKTEST() !== 0){return;}
		console.log(bg_magenta+white+"\n######## DKJAVASCRIPT END TEST ####### "+JS_FILE+" ######## DKJAVASCRIPT END TEST #######"+clr+"\n");
		//dk_pause();
		//exit %errorlevel%
	});
	
} else {
	console.log("TODO");
}
		
/*
if(typeof ARGV !== "undefined"){
	FUNC_NAME = ARGV[0].substr(ARGV[0].lastIndexOf("/")+1, (ARGV[0].lastIndexOf(".") - ARGV[0].lastIndexOf("/")-1)); 
	alert("FUNC_NAME = "+FUNC_NAME);
		
	document.title = FUNC_NAME;
	if(typeof globalThis[FUNC_NAME] === "undefined"){

		dk_source(ARGV[0], function dk_source_callback(){
			//if(DKSCRIPT_EXT !== ".js"){ return }
			//if(!dk_fileContains(DKSCRIPT_PATH, ":DKTEST")){ return }
			console.log("")
			console.log(bg_magenta+white+"###### DKTEST MODE ###### "+DKSCRIPT_FILE+" ###### DKTEST MODE ######"+clr)
			console.log("")
			DKTEST()//function DKTEST_callback(){});
			console.log("")
			console.log(bg_magenta+white+"######## END TEST ####### "+DKSCRIPT_FILE+" ######## END TEST #######"+clr)
			console.log("")
		});
	}
} else {
	if(typeof ARGV !== "undefined"){ 
		if(ARGC > 0){ var JS_PATH = ARGV[0]; }
		if(ARGC > 1){ var JS_ARGS = ARGV[1]; }
		var JS_DIR = JS_PATH.substr(0, JS_PATH.lastIndexOf("/"));
		var JS_FILE = JS_PATH.substr(JS_PATH.lastIndexOf("/")+1);
		var JS_NAME = JS_PATH.substr(JS_PATH.lastIndexOf("/")+1, (JS_PATH.lastIndexOf(".") - JS_PATH.lastIndexOf("/")-1));
		var JS_EXT = JS_FILE.substr(JS_FILE.lastIndexOf("."));
		dk_source(JS_PATH, function dk_source_callback(){
			if(typeof JS_ARGS !== "undefined"){
				window[JS_NAME](JS_ARGS);
			} else {
				window[JS_NAME]();
			}
		});
	}
}
*/


// dk.sendRequest()
dk.sendRequest = function dk_sendRequest(httpMethod, url, dk_sendRequest_callback){
//    required({
//        httpMethod
//    }, {
//        url
//    }, {
//        dk_sendRequest_callback
//    });
    if (httpMethod){
        switch (httpMethod){
        case "GET":
        case "POST":
        case "PUT":
        case "HEAD":
        case "DELETE":
        case "PATCH":
        case "OPTIONS":
        case "CONNECT":
        case "TRACE":
            break;
        default:
            return error("httpMethod '" + httpMethod + "' invalid", dk_sendRequest_callback(false));
        }
    }
    if (dk_sendRequest_callback.length < 3)
        return error("dk_sendRequest_callback requires 3 arguments (success, url, data)", dk_sendRequest_callback(false));

    var xhr;
    try {
        !xhr && (xhr = new XMLHttpRequest());
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml3.XMLHTTP"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.6.0"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP.3.0"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Msxml2.XMLHTTP"));
    } catch (e){}
    try {
        !xhr && (xhr = new ActiveXObject("Microsoft.XMLHTTP"));
    } catch (e){}
    if (!xhr)
        return error("Error creating xhr object", dk_sendRequest_callback(false));

    //FIXME: duktape
    //url = encodeURIComponent(url).replace(";", "%3B");
    xhr.open(httpMethod, url, true);
    //https://en.wikipedia.org/wiki/List_of_HTTP_header_fields
    if (httpMethod === "POST" || httpMethod === "Put")
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.timeout = 20000;

    //Possible error codes
    //https://github.com/richardwilkes/cef/blob/master/cef/enums_gen.go
    xhr.onabort = function xhr_onabort(event){
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onabort");
        //console.debug("XMLHttpRequest.onabort(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onerror = function xhr_onerror(event){
        console.error && console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> onerror");
        //console.debug("XMLHttpRequest.onerror(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, xhr.responseText);
    }
    xhr.onload = function xhr_onload(event){
        //console.debug("XMLHttpRequest.onload(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(true, url, xhr.responseText);
    }
    xhr.onloadend = function xhr_onloadend(event){//console.debug("XMLHttpRequest.onloadend(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onloadstart = function xhr_onloadstart(event){//console.debug("XMLHttpRequest.onloadstart(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onprogress = function xhr_onprogress(event){//console.debug("XMLHttpRequest.onprogress(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    }
    xhr.onreadystatechange = function xhr_onreadystatechange(event){//console.log("XMLHttpRequest.onreadystatechange(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
    /*
        if (xhr.readyState === 4){
            if (xhr.status >= 200 && xhr.status < 400 || !xhr.status)
                dk_sendRequest_callback(true, url, xhr.responseText);
            else
                dk_sendRequest_callback(false, url, xhr.responseText);
        }
        */
    }
    xhr.ontimeout = function xhr_ontimeout(event){
        dk.console.error && dk.console.error("GET <a href=' " + url + " ' target='_blank' style='color:rgb(213,213,213)'>" + url + "</a> net::ERR_CONNECTION_TIMED_OUT");
        //console.debug("XMLHttpRequest.ontimeout(): " + file + " readyState:" + xhr.readyState + " status:" + xhr.status);
        return dk_sendRequest_callback(false, url, "ontimeout");
    }

    console.log("dk.sendRequest("+httpMethod+","+decodeURIComponent(url)+")")
    xhr.send();
}