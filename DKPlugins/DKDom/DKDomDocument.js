// https://developer.mozilla.org/en-US/docs/Web/API/Document

////////////////////////////////
var Document = function(pointer)
{
	// Properties
	Object.defineProperty(this, "body", {
		get: function(){
			var address = DKCPP_DKDomDocument_body();
			if(!address){ return; }
			return new HTMLElement(address);
		},
		set: function(){
			if(!address){ return; }
			return DKCPP_DKDomDocument_body(address); //TODO
		} 
	});
	Object.defineProperty(this, "documentElement", {
		get: function(){ 
			var address = DKCPP_DKDomDocument_documentElement();
			if(!address){ return; }
			return new HTMLElement(address);
		} 
	});
	
	
	// Methods
	Document.prototype.createElement = function(tag){
		var address = DKCPP_DKDomDocument_createElement(tag);
		if(!address){ return; }
		return new HTMLElement(address);
	}
	Document.prototype.getElementById = function(id){
		var address = DKCPP_DKDomDocument_getElementById(id);
		if(!address){ return; }
		return new HTMLElement(address);
	}

	Document.prototype.getElementsByTagName = function(tag){
		var addresses = DKCPP_DKDomDocument_getElementsByTagName(tag);
		if(!addresses){ return; }
		return new HTMLCollection(addresses);
	}
	
	//return Node.call(this, pointer);
	return HTMLElement.call(this, pointer); //we have to call HTMKElement instead of Node for .style to work
}
Document.prototype = Node.prototype;
Object.assign(Document.prototype, DocumentOrShadowRoot); //mixin
Object.assign(Document.prototype, GlobalEventHandlers); //mixin
//var document = new Document("0xaddress"); //Created in cpp from DKRml