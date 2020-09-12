// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	// Properties
	Object.defineProperty(this, "body", {
		get: function(){
			var address = DKDomDocument_body();
			if(!address){ return; }
			return new HTMLElement(address);
		},
		set: function(){
			if(!address){ return; }
			return DKDomDocument_body(address); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", {
		get: function(){ 
			var address = DKDomDocument_documentElement();
			if(!address){ return; }
			return new HTMLElement(address);
		} 
	});
	
	
	// Methods
	Document.prototype.createElement = function(tag){
		var address = DKDomDocument_createElement(tag);
		if(!address){ return; }
		return new HTMLElement(address);
	}
	Document.prototype.getElementById = function(id){
		var address = DKDomDocument_getElementById(id);
		if(!address){ return; }
		return new HTMLElement(address);
	}

	Document.prototype.getElementsByTagName = function(tag){
		var addresses = DKDomDocument_getElementsByTagName(tag);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	
	
	//return Node.call(this, pointer);
	return HTMLElement.call(this, pointer);
}
Document.prototype = Node.prototype;
Object.assign(Document.prototype, DocumentOrShadowRoot); //mixin
//Object.assign(Document.prototype, GlobalEventHandlers); //mixin
var document = new Document("document");