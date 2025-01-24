//WScript.StdOut.Write("DKJSCRIPT.js\n");

var index = "../../DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";


//###### ARGV, ARGC (variables) ######
ARGV = WScript.Arguments;
ARGC = WScript.Arguments.Count();
for (i=0; i<ARGV.length; i++){
    WScript.Echo("ARGV"+i+" = "+ARGV(i)+"\n");
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

//###### XMLHttpRequest (class) ######
if(typeof XMLHttpRequest == "undefined" || !ie7xmlhttp) {
    XMLHttpRequest = function() {
		//return new ActiveXObject("Msxml3.XMLHTTP");
		return new ActiveXObject("Msxml2.XMLHTTP.6.0");
		//return new ActiveXObject("Msxml2.XMLHTTP.3.0");
		//return new ActiveXObject("Msxml2.XMLHTTP");
		//return new ActiveXObject("Microsoft.XMLHTTP");
	}
}
		
//###### dk_source (function) ######
dk_source = function(url){
	var IXMLHttpRequest = new XMLHttpRequest();
	IXMLHttpRequest.open("GET", url, false);
	IXMLHttpRequest.send();
	(1, eval)(IXMLHttpRequest.responseText);
//	if(arguments[1] !== "undefined"){
//		arguments[1]()
//	}
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

//###### location ######
var location = new Object;
location.href = objXMLDoc.url;


//###### document (variable) ######
var document = objXMLDoc.documentElement;
dk_check('document');
//WScript.StdOut.Write("document: "+document.xml+"\n\n");




//###### alert (function) ######
//dk_source(assets+"/DKJavascript/polyfills/alert.js");
//dk_check('alert');
//alert("test");

//###### console (class) ######
dk_source(assets+"/DKJavascript/polyfills/console.js");
dk_check('console');
//console.log("console.log test\n");

//###### dk_color (function) ######
//dk_source(assets+"/DKJavascript/functions/dk_color.js");
//dk_check('dk_color');
//DKTEST();


dk_source(assets+"/DKJavascript/functions/DK.js");
//dk_check('DK');

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







