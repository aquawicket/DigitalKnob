// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	this.pointer = pointer;
	//console.log("var Document = function("+this.pointer+")");
	Node.call(this, pointer);
	
	// Properties
	Object.defineProperty(this, "body", {
		configurable: true,
		get: function(){ 
			var pointer = DKDomDocument_body();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		},
		set: function(){
			if(!pointer){ return; }
			return DKDomDocument_body(pointer); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", {
		configurable: true,
		get: function(){ 
			var pointer = DKDomDocument_documentElement();
			if(!pointer){ return; }
			var element = HTMLElement(pointer);
			return element;
		} 
	});
	
	
	// Methods
	Document.prototype.createElement = function(tag){
		var pointer = DKDomDocument_createElement(tag);
		if(!pointer){ return; }
		var element = HTMLElement(pointer);
		return element;
	}
	Document.prototype.getElementById = function(id){
		var pointer = DKDomDocument_getElementById(id);
		if(!pointer){ return; }
		var element = HTMLElement(pointer); //FIXME: if we don't declare new, addEventListener doesn't work. 
		return element;
	}
	Document.prototype.getElementsByTagName = function(tag){
		var pointers = DKDomDocument_getElementsByTagName(tag);
		if(!pointers){ return; }
		var elements = new HTMLCollection(pointers);
		return elements;
	}
	
	return this;
}
Document.prototype = Node.prototype;
Object.assign(Document.prototype, DocumentOrShadowRoot);
var document = new Document("document");