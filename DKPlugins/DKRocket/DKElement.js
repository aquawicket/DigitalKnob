var document;

////////////////////////////////
var Document = function(pointer)
{
	//DKDEBUGFUNC();
	console.warn("Document("+pointer+")");
	
	Object.defineProperty(this, "location", { get: function(){ return location; } });
	
	Document.prototype.createElement = function(tagName){
		var pointer = DKRocket_createElement(tagName);
		var htmlElement = new HTMLElement(pointer);
		return htmlElement;
	}
	Document.prototype.getElementById = function(id){
		var pointer = DKRocket_getElementById(id);
		if(!pointer){ return null; }
		var htmlElement = new HTMLElement(pointer); //MDN specs say getElementById returns an Element object, but then we have no access to .style
		return htmlElement;
	}
	
	Element.call(this, pointer);
	
	this.body = this.getElementsByTagName("body")[0];
	this.documentElement = this.getElementsByTagName("html")[0];
}
Document.prototype = Element.prototype;

document = new Document("document");