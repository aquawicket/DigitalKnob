// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	// Properties
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
			var element = new HTMLElement(pointer);
			return element;
		} 
	});
	
	
	// Methods
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
	
	Node.call(this, pointer);
}

Document.prototype = Node.prototype;	
var document = new Document("document");  //Create the global document object