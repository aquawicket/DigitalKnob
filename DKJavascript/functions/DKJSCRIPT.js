//WScript.StdOut.Write("DKJSCRIPT.js\n");

var index = "../../DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";


//###### ARGV, ARGC (variables) ######
ARGV = WScript.Arguments;
ARGC = WScript.Arguments.Count();
for (i=0; i<ARGV.length; i++){
    //WScript.Echo("ARGV"+i+" = "+ARGV(i)+"\n");
}

//###### dk_check (function) ######
dk_check = function(object){
	if(typeof this[object] == 'undefined'){WScript.StdOut.Write(object+" is invalid\n");}
	//if(typeof this[object] != 'undefined'){WScript.StdOut.Write(object+" is valid\n");}
}

//###### globalThis (variable) ######
var globalThis = (function () {  
    return this || (1, eval)('this');  
}());
dk_check('globalThis');

//###### window (variable) ######
var window = (function () {  
    return this || (1, eval)('this');  
}());
dk_check('window');

//###### String.prototype.replaceAll (polyfill) ######
if(typeof String.prototype.replaceAll === "undefined") {
	String.prototype.replaceAll = function replaceAll(search, replace) { 
		return this.split(search).join(replace); 
	}
}

//###### XMLHttpRequest (class) ######
if(typeof XMLHttpRequest == "undefined" || !ie7xmlhttp) {
    XMLHttpRequest = function() {
		return new ActiveXObject("Msxml2.XMLHTTP.6.0");
	}
}
	
//###### dk_source (function) ######
dk_source = function(url, callback){
	if(typeof ActiveXObject === "OFF function OFF"){ //<---- turned off
		var url = url.replaceAll("file:///", "");
		(1, eval)((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile(url, 1).ReadAll());
	} else {
		var jsfile = "file:///"+url.replaceAll("\\", "/");
		var xmlHttpRequest = new XMLHttpRequest;
		xmlHttpRequest.open("GET", url, true);
		xmlHttpRequest.send();
		eval(xmlHttpRequest.responseText);
	}
	if(callback){
		callback();
	}
}
dk_check('dk_source');

//###### DOMDocument (class) ######
var objXMLDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");  
objXMLDoc.async = false;
objXMLDoc.setProperty("ProhibitDTD", false);
objXMLDoc.validateOnParse = false;
objXMLDoc.load(index);
if(objXMLDoc.parseError.errorCode !== 0){
	WScript.StdOut.Write("ERROR when loading " + index + ": " + objXMLDoc.parseError.reason);
}
dk_check('objXMLDoc');

//###### location ######
var location = new Object;
location.href = objXMLDoc.url;
//dk_check('location.href');
WScript.Echo("location.href = "+location.href);

//###### documentElement ######
var document = objXMLDoc.documentElement;
dk_check('document');
//WScript.StdOut.Write("document: "+document.xml+"\n\n");

//###### alert (function) ######
dk_source(assets+"/DKJavascript/polyfills/alert.js", function(){
	dk_check('alert');
	//alert("test");
});

//###### console (class) ######
dk_source(assets+"/DKJavascript/polyfills/console.js");
dk_check('console');
console.log("console.log test\n");

//###### dk_color (function) ######
//dk_source(assets+"/DKJavascript/functions/dk_color.js");
//dk_check('dk_color');
//DKTEST();

dk_source(assets+"/DKJavascript/polyfills/addEventListener.js", function(){
	//dk_check('document.addEventListener');
});

dk_source(assets+"/DKJavascript/functions/DK.js", function(){
	//dk_check('DK');
});


/*###### JSON ###### 
var htmlfile = WSH.CreateObject('htmlfile'), JSON;
htmlfile.write('<meta http-equiv="x-ua-compatible" content="IE=9" />');
htmlfile.close(JSON = htmlfile.parentWindow.JSON);
str = JSON.stringify(global);
*/


// https://stackoverflow.com/questions/3054321/how-to-reference-a-jscript-file-from-another-one
// A object to which library functions can be attached
//var library = new Object;
//eval((new ActiveXObject("Scripting.FileSystemObject")).OpenTextFile("DK.js", 1).ReadAll());



//###### LOAD FILE (ARGV0) ######
//WScript.StdOut.Write("dk_source("+ARGV(0)+")");
//dk_source(ARGV(0));
//DKTEST();







