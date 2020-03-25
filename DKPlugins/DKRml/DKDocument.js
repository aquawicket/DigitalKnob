//https://developer.mozilla.org/en-US/docs/Web/API/Document

var document;

////////////////////////////////
var Document = function(pointer)
{
	Document.prototype.documentElement = function(){
		console.log("****************************************documentElement");
		var pointer = DKDocument_documentElement();
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
	
	Document.prototype.getElementById = function(id){
		var pointer = DKDocument_getElementById(id);
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
}

document = new Document("document");