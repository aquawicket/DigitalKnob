//https://developer.mozilla.org/en-US/docs/Web/API/Document

var document;

////////////////////////////////
var Document = function(pointer)
{
	Object.defineProperty(this, "body", { 
		get: function(){ 
			var pointer = DKRocketDocument_body();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		},
		set: function(){
			if(!pointer){ return; }
			return DKRocketDocument_body(pointer); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", { 
		get: function(){ 
			var pointer = DKRocketDocument_documentElement();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		} 
	});
	
	Document.prototype.createElement = function(tag){
		var pointer = DKRocketDocument_createElement(tag);
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
	Document.prototype.getElementById = function(id){
		var pointer = DKRocketDocument_getElementById(id);
		if(!pointer){ return; }
		var element = new HTMLElement(pointer);
		return element;
	}
	Document.prototype.getElementsByTagName = function(tag){
		var pointers = DKRocketDocument_getElementsByTagName(tag);
		if(!pointers){ return; }
		var elements = new HTMLCollection(pointers);
		return elements;
	}
	
	Node.call(this, pointer);
}
Document.prototype = Node.prototype;	
document = new Document("document");