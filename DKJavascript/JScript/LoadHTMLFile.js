var global = (function () {  
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
objXMLDoc.load("blank.html")
if(objXMLDoc.parseError.errorCode !== 0){
	WScript.StdOut.Write("ERROR when loading " + strFileName + ": " + objXMLDoc.parseError.reason);
}

var document = objXMLDoc.documentElement;
WScript.StdOut.Write("document: "+document.xml+"\n\n");






var assets = "file:///C:/Users/Administrator/digitalknob/Development/DKJavascript/JScript";

dk_source(assets+"/console.js");
console.log("console.log test\n");

dk_source(assets+"/alert.js");
alert("test");


//document.save("output.xml");