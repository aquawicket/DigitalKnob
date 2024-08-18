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
var document = new ActiveXObject("Msxml2.DOMDocument.6.0");  
document.async = false;
document.validateOnParse = true;
document.resolveExternals = true;
document.load("blank.html");
var assets = "file:///C:/Users/Administrator/digitalknob/Development/DKJavascript/JScript";
WScript.StdOut.Write("document: "+document.xml);

dk_source(assets+"/console.js");
console.log("console.log test\n");

dk_source(assets+"/alert.js");
alert("test");

console.log("document: "+document.xml);

document.validate();
document.save("output.xml");