ARGV = WScript.Arguments;
ARGC = WScript.Arguments.Count();
for (i=0; i<ARGV.length; i++){
    WScript.Echo(ARGV(i));
}

var index = "../../DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";

//###### dk_check (function) ######
dk_check = function(object){
	if(typeof this[object] !== 'undefined'){WScript.StdOut.Write(object+" is valid\n");} else {WScript.StdOut.Write(object+" is invalid\n");}
}

//###### globalThis (variable) ######
var globalThis = (function (){  
    return this || (1, eval)('this');  
}());  

//###### window (variable) ######
var window = (function (){  
    return this || (1, eval)('this');  
}());  

//###### dk_func (function) ######
dk_func = function(url){
	var IXMLHttpRequest = new ActiveXObject("MSXML2.XMLHTTP.6.0");
	IXMLHttpRequest.open("GET", url, false);
	IXMLHttpRequest.send();
	return IXMLHttpRequest.responseText;
}
//###### dk_source (function) ######
dk_source = function(url){ 
	(1, eval)(dk_func(url)); 
};

//###### Instantiate the DOM object ######
var objXMLDoc = new ActiveXObject("Msxml2.DOMDocument.6.0");  
objXMLDoc.async = false;
objXMLDoc.setProperty("ProhibitDTD", false);
objXMLDoc.validateOnParse = false;
objXMLDoc.load(index)
if(objXMLDoc.parseError.errorCode !== 0){
	WScript.StdOut.Write("ERROR when loading " + index + ": " + objXMLDoc.parseError.reason);
}

//###### document (variable) ######
var document = objXMLDoc.documentElement;
WScript.StdOut.Write("document: "+document.xml+"\n\n");

//###### alert (function) ######
dk_source(assets+"/DKJavascript/JScript/alert.js");
//alert("test");

//###### console (class) ######
dk_source(assets+"/DKJavascript/JScript/console.js");
console.log("console.log test\n");

//###### dk_color (function) ######
dk_source(assets+"/DKJavascript/functions/dk_color.js");
DKTEST();




dk_check('alert');
dk_check('console');
dk_check('globalThis');
dk_check('window');
dk_check('document');
dk_check('dk_func');
dk_check('dk_source');







/*###### JSON ###### 
var htmlfile = WSH.CreateObject('htmlfile'), JSON;
htmlfile.write('<meta http-equiv="x-ua-compatible" content="IE=9" />');
htmlfile.close(JSON = htmlfile.parentWindow.JSON);
str = JSON.stringify(global);
*/


