//https://developer.mozilla.org/en-US/docs/Web/API/Document

var document;

////////////////////////////////
var Document = function(pointer)
{
	Object.defineProperty(this, "body", { 
		get: function(){ 
			var pointer = DKDocument_body();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		},
		set: function(){
			if(!pointer){ return; }
			return DKDocument_body(pointer); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", { 
		get: function(){ 
			var pointer = DKDocument_documentElement();
			if(!pointer){ return; }
			var element = new Element(pointer);
			return element;
		} 
	});
	
	Document.prototype.createElement = function(tag){
		var pointer = DKDocument_createElement(tag);
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
	Document.prototype.getElementsByTagName = function(tag){
		var pointers = DKDocument_getElementsByTagName(tag);
		if(!pointers){ return; }
		var elements = new HTMLCollection(pointers);
		return elements;
	}
}

document = new Document("document");