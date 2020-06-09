// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

////////////////////////////////////////////
var DocumentOrShadowRoot = function(pointer)
{
	// Properties
	Object.defineProperty(this, "activeElement", { 
		get: function(){ 
			var elementAddress = DKDomDocumentOrShadowRoot_activeElement();
			if(!elementAddress){ return; }
			var element = new HTMLElement(elementAddress);
			return element;
		},
	});
		
	// Methods
	Document.prototype.caretPositionFromPoint = function(){
		var caretPosition = DKDomDocumentOrShadowRoot_caretPositionFromPoint();
		if(!CaretPosition ){ return; }
		//TODO
	}
	Document.prototype.elementFromPoint = function(){
		var elementAddress = DKDomDocumentOrShadowRoot_elementFromPoint();
		if(!elementAddress ){ return; }
		var element = new HTMLElement(elementAddress);
		return element;
	}
}