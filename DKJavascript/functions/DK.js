var index = "file:///C:/Users/Administrator/digitalknob/Development/DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";
var USE_FILESYSTEM = 1;
var USE_NODEJS=0;


//###### console.log ######
(function(con){
	'use strict';
	var prop, method;
	var empty = {};
	if(typeof ActiveXObject === "function"){
		if(typeof WScript === "object"){
			if(typeof WScript.StdOut !== "undefined")
			var print = function(msg){ WScript.StdOut.Write(msg+"\n"); };
		} else {
			var print = function(msg){
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
}

//############ NodeJS ############
if(USE_NODEJS){
	dk_validate(DKIMPORTS_DIR, "dk_DKIMPORTS_DIR");
	dk_validate(NODEJS_EXE, DKIMPORTS_DIR+"/nodejs/dk_install.js")
	
	//COMSPEC = dk_env("%COMSPEC%")
	WShell = new ActiveXObject("WScript.Shell");
	WShell.Run('start '+NODEJS_EXE+' '+DKJAVASCRIPT_FUNCTIONS_DIR+'\DKNodeServer.js')
	WShell.Run('explorer "http://127.0.0.1:8080/Users/Administrator/digitalknob/Development/DKHtml/index.html?DKTEST="+DKSCRIPT_PATH')
}

//########### DKENGINE ###########
if(typeof DKScriptEngine === "undefined"){
	if(typeof ScriptEngine !== "undefined"){
		var DKScriptEngine = ScriptEngine();
		var DKScriptEngine_Version = ScriptEngineMajorVersion()+"."+ScriptEngineMinorVersion()+"."+ScriptEngineBuildVersion();
	}
}
dk_check('DKScriptEngine');
dk_check('DKScriptEngine_Version');


//############ globalThis ############
if(typeof globalThis === "undefined"){
	var globalThis = (function (){  
		return this || (1, eval)('this');  
	}());
	console.log("globalThis = "+typeof globalThis);
}
dk_check('globalThis');



//############ window ############
if(typeof window === "undefined"){
	var window = (function Window(){
		return this || (1, eval)('this');  
	}());
	
	window.constructor = (function Constructor(){
		return this || (1, eval)('this');  
	}());
	
	window.constructor.name = "window";
	console.log("window = "+typeof window);
}
dk_check('window');



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
	if(typeof globalThis === "undefined"){
		console.error("dk_valid(): requires a valid globalThis object.");
		return -1;
	}
	
	var arry = arguments[0].split(".");
	if(arry[0] === "globalThis"){ arry.shift(); }
	if(arry[0] === "window"){ arry.shift(); }
	if(arry[0] === "self"){ arry.shift(); }

	currentObject = globalThis;
	result = true;
	
	for (var i = 0; i < arry.length; i++) {
		result = false;
		if(typeof currentObject[arry[i]] !== "undefined"){
			currentObject = currentObject[arry[i]];
			result = true;
		}
		if(result === false){
			break;
		}
	}
	
	return result;
}


dk_call = function dk_call(){
	var _ARGV_ = "";
	for (var i = 0; i < arguments.length; i++) {_ARGV_ += ", "+arguments[i];}
	console.log("dk_call("+_ARGV_+")");

	var arry = arguments[0].split(".");
	if(typeof window === "undefined"){ 
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
		

		/*
		if(typeof window[arry[i]] !== "undefined"){
			console.log("typeof currentObject.arry["+i+"] = "+ typeof currentObject.arry[i]);
		}
		*/
	}
	
	/*
	if(arry.length > 0){ dk_call.valid = (typeof window !== "undefined") }
	if(dk_call.valid && (arry.length > 1)){ dk_call.valid = (typeof window[arry[1]] !== "undefined") }
	if(dk_call.valid && (arry.length > 1)){
		console.log("typeof window[arry[1]] = "+typeof window[arry[1]]);
		if(typeof window[arry[1]] === "function"){
			console.log('call -> window['+arry[1]+']()');
			dk_call.value = window[arry[1]]();
		}
	}
	
	console.log("typeof dk_call.value = "+ typeof dk_call.value);
	return dk_call.value;
	*/
}

//############ DKBrowser ############
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
	var isOpera = dk_valid("window.opr.addons") || dk_valid("window.oprera") || (dk_valid("navigator.userAgent.indexOf") && (navigator.userAgent.indexOf(' OPR/') >= 0));
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
console.log("DKBrowser() = "+DKBrowser());

//dk_check('DKBrowser');






//############ ARGV, ARGC ############
if(typeof WScript === "object"){
	ARGC = WScript.Arguments.Count();
	var ARGV = new Array(ARGC);
    for(var i = 0; i < ARGV.length; ++i){
        ARGV[i] = WScript.Arguments(i);
		//console.log("ARGV["+i+"] = "+ARGV[i]);
    }
	//console.log("ARGV = "+ARGV+"\n");
	//console.log("ARGC = "+ARGC+"\n");
}







//############ String.prototype.replaceAll (polyfill) ############
if(typeof String.prototype.replaceAll === "undefined"){
	String.prototype.replaceAll = function replaceAll(search, replace){ 
		return this.split(search).join(replace); 
	}
}
//dk_check('String.prototype.replaceAll');


//############ XMLHttpRequest ############
if(typeof XMLHttpRequest == "undefined"){ // || !ie7xmlhttp){
	if(typeof ActiveXObject === "function"){
		XMLHttpRequest = function(){
			return new ActiveXObject("Msxml2.XMLHTTP.6.0");
		}
		console.log("XMLHttpRequest = "+typeof XMLHttpRequest);
	}
}
dk_check('XMLHttpRequest');


//############ dk_source ############
if(typeof dk_source === "undefined"){
	dk_source = function(url, dk_source_callback){
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
					eval(xmlHttpRequest.responseText);
					//console.log("###################################################################");
					//console.log("###################################################################");
					//console.log("###################################################################");
				//}
			}
			//console.log("checking for callback");
			if(dk_source_callback){
				console.log("dk_source_callback");
				dk_source_callback();
				return;
			} else {
				console.log("no dk_source_callback");
			}
		} else { //############ Browsers ############
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
dk_check('dk_source');


//############ DOMDocument ############
if(typeof ActiveXObject === "function"){
	if(typeof document === "undefined"){ 
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
dk_check('document');


//############ WShell ############
if(typeof ActiveXObject === "function"){
	if(typeof WShell === "undefined"){ 
		var WShell = new ActiveXObject("WScript.Shell");
		console.log("WShell = "+typeof WShell);
	}
}
//dk_check('WShell');

/*
//############ documentElement ############
if(typeof documentElement === "undefined"){ 
	var documentElement = document.documentElement;
	//console.log("documentElement: "+documentElement.xml+"\n\n");
}
dk_check('documentElement');
*/


//############ location ############
if(typeof location === "undefined"){ 
	var location = new Object;
}
dk_check('location');

//######### location.href #########
if(typeof location.href === "undefined"){
	if(typeof document.url !== "undefined"){
		location.href = document.url;
	}
}
console.log("location.href = "+location.href);

//######### DKSCRIPT_PATH / DKSCRIPT_ARGS #########
if(typeof DKSCRIPT_PATH === "undefined"){
	if(typeof WScript_Shell !== "undefined"){ 
		var DKSCRIPT_PATH = WScript_Shell.ExpandEnvironmentStrings("%DKSCRIPT_PATH%").replaceAll("\\", "/");
		var DKSCRIPT_ARGS = WScript_Shell.ExpandEnvironmentStrings("%DKSCRIPT_ARGS%");
	} else if(typeof location.href !== "undefined"){
		var DKSCRIPT_PATH = location.href;
	}
}
if(typeof DKSCRIPT_PATH === "undefined"){
	console.error("DKSCRIPT_PATH invalid");
}
console.log("DKSCRIPT_PATH = "+DKSCRIPT_PATH);

//######### DKSCRIPT_DIR ############
if(typeof DKSCRIPT_DIR === "undefined"){
	DKSCRIPT_DIR = DKSCRIPT_PATH.substr(0, DKSCRIPT_PATH.lastIndexOf("/"));
	console.log("DKSCRIPT_DIR = "+DKSCRIPT_DIR);
}
//######### DKSCRIPT_FILE ############
if(typeof DKSCRIPT_FILE === "undefined"){
	DKSCRIPT_FILE = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1); 
	console.log("DKSCRIPT_FILE = "+DKSCRIPT_FILE);
}
//######### DKSCRIPT_NAME ############
if(typeof DKSCRIPT_NAME === "undefined"){
	DKSCRIPT_NAME = DKSCRIPT_PATH.substr(DKSCRIPT_PATH.lastIndexOf("/")+1, (DKSCRIPT_PATH.lastIndexOf(".") - DKSCRIPT_PATH.lastIndexOf("/")-1)); 
	console.log("DKSCRIPT_NAME = "+DKSCRIPT_NAME);
}
//######### DKSCRIPT_EXT ############
if(typeof DKSCRIPT_EXT === "undefined"){
	DKSCRIPT_EXT = DKSCRIPT_FILE.substr(DKSCRIPT_FILE.lastIndexOf(".")); 
	console.log("DKSCRIPT_EXT = "+DKSCRIPT_EXT);
}


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
		queryString=location.href.split('?')[1];
	}
}
//dk_check('queryString');

//###### DKSCRIPT variables ######
//if(typeof ARGV !== "undefined" && ARGV.length > 0){
//	if(ARGV.length > 1){
//		var href = ARGV(1).replaceAll("\\", "/");
//	} else {
//		var href = ARGV(0).replaceAll("\\", "/");
//	}
//	var DKSCRIPT_PATH = href;
//} else {
//	var DKSCRIPT_PATH = location.href;
//}





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
		console.log("loaded console.js");
	});
}
dk_check('console');
*/

//############ onDOMContentLoaded ############
if(typeof onDOMContentLoaded === "undefined"){
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
dk_check('onDOMContentLoaded');

//############ document.addEventListener ############
if(typeof document.addEventListener !== "undefined"){
	document.addEventListener("DOMContentLoaded", onDOMContentLoaded());
}
//dk_check('document.addEventListener');

//############ body_onload ############
function body_onload(){
	console.log("body_onload()")
	if(!window.document.body){ 
		alert("window.document.body is invalid"); 
		return; 
	}
		
	if(DKSCRIPT_FILE === "index.html"){
		var APP_NAME = DKSCRIPT_DIR.substr(DKSCRIPT_DIR.lastIndexOf("/")+1);
		dk_source(DKJAVASCRIPT_DIR+"/apps/"+APP_NAME+"/main.js", function dk_source_callback(){
			main();
		});
	}
}
dk_check('body_onload');

//dk_source(DKJAVASCRIPT_DIR+"/polyfills/globalThis.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/window.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/Document.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/alert.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/addEventListener.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/FileSystem.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/WshShell.js");
//dk_source(DKJAVASCRIPT_DIR+"/polyfills/replaceAll.js");
dk_source(DKJAVASCRIPT_DIR+"/functions/dk_color.js", function dk_color_callback(){});



//############ DKTEST ############
if(typeof ARGV !== "undefined"){ 
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


