// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	Node.call(this, pointer);
	
	// Properties
	Object.defineProperty(this, "body", {
		configurable: true,
		get: function(){ 
			var address = DKDomDocument_body();
			if(!address){ return; }
			var element = HTMLElement(address);
			return element;
		},
		set: function(){
			if(!address){ return; }
			return DKDomDocument_body(address); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", {
		configurable: true,
		get: function(){ 
			var address = DKDomDocument_documentElement();
			if(!address){ return; }
			var element = HTMLElement(address);
			return element;
		} 
	});
	
	
	// Methods
	Object.defineProperty(this, "createElement", {
		configurable: true,
		value: function(tag){ 
			var address = DKDomDocument_createElement(tag);
			if(!address){ return; }
			var element = HTMLElement(address);
			return element;
		} 
	});
	Object.defineProperty(this, "getElementById", {
		configurable: true,
		value: function(id){ 
			var address = DKDomDocument_getElementById(id);
			if(!address){ return; }
			var element = HTMLElement(address);
			return element;
		} 
	});
	Object.defineProperty(this, "getElementsByTagName", {
		configurable: true,
		value: function(tag){
			//console.log("Document.getElementsByTagName("+tag+")");
			var addresses = DKDomDocument_getElementsByTagName(tag);
			if(!addresses){ /*console.log("Document.getElementsByTagName("+tag+"): addresses invalid");*/ return; }
			var elements = HTMLCollection(addresses);
			return elements;
		} 
	});
	
	Object.assign(this, DocumentOrShadowRoot);
	return this;
}
Document.prototype = Node.prototype;
//Object.assign(Document.prototype, DocumentOrShadowRoot);
var document = Document("document");