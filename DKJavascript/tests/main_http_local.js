var index = "http://127.0.0.1:2393/DKHtml/index.html";
var assets = "file:///C:/Users/Administrator/digitalknob/Development";

var globalThis = (function (){  
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
objXMLDoc.load(index)
if(objXMLDoc.parseError.errorCode !== 0){
	WScript.StdOut.Write("ERROR when loading " + index + ": " + objXMLDoc.parseError.reason);
}

// the document object should now exist.
var document = objXMLDoc.documentElement;
WScript.StdOut.Write("document: "+document.xml+"\n\n");





//###### console ######
dk_source(assets+"/DKJavascript/JScript/console.js");
console.log("console.log test\n");

//###### alert ######
dk_source(assets+"/DKJavascript/JScript/alert.js");
alert("test");

/*###### JSON ###### 
var htmlfile = WSH.CreateObject('htmlfile'), JSON;
htmlfile.write('<meta http-equiv="x-ua-compatible" content="IE=9" />');
htmlfile.close(JSON = htmlfile.parentWindow.JSON);
str = JSON.stringify(global);
*/


