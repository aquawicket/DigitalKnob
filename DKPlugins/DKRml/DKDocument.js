//https://developer.mozilla.org/en-US/docs/Web/API/Document

var document;

////////////////////////////////
var Document = function(pointer)
{
	Object.defineProperty(this, "body",   { 
		get: function(){ 
			var pointer = DKDocument_body();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		} 
	});
	
	Object.defineProperty(this, "documentElement",   { 
		get: function(){ 
			var pointer = DKDocument_documentElement();
			if(!pointer){ return; }
			var element = new Element(pointer);
			return element;
		} 
	});
	
	Document.prototype.getElementById = function(id){
		var pointer = DKDocument_getElementById(id);
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
}

document = new Document("document");