// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	// Properties
	Object.defineProperty(this, "body", {
		configurable: true,
		get: function(){
			console.log("Document.body");
			var address = DKDomDocument_body();
			if(!address){ return; }
			var element = new HTMLElement(address);
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
			var element = new HTMLElement(address);
			return element;
		} 
	});
	
	
	// Methods
	Object.defineProperty(this, "createElement", {
		configurable: true,
		value: function(tag){ 
			var address = DKDomDocument_createElement(tag);
			if(!address){ return; }
			var element = new HTMLElement(address);
			return element;
		} 
	});
	Object.defineProperty(this, "getElementById", {
		configurable: true,
		value: function(id){ 
			var address = DKDomDocument_getElementById(id);
			if(!address){ return; }
			var element = new HTMLElement(address);
			return element;
		} 
	});
	Object.defineProperty(this, "getElementsByTagName", {
		configurable: true,
		value: function(tag){
			console.log("Document.getElementsByTagName("+tag+")");
			var addresses = DKDomDocument_getElementsByTagName(tag);
			if(!addresses){ /*console.log("Document.getElementsByTagName("+tag+"): addresses invalid");*/ return; }
			var elements = new HTMLCollection(addresses);
			return elements;
		} 
	});
	
	return Node.call(this, pointer);
}
Document.prototype = Node.prototype;
Object.assign(Document.prototype, DocumentOrShadowRoot);
var document = new Document("document");