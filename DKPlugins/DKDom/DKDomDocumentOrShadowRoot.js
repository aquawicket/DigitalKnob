// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot

////////////////////////////////////////////
var DocumentOrShadowRoot = function(pointer)
{
	// Properties
	Object.defineProperty(this, "activeElement", { 
		get: function(){ 
			var pointer = DKDomDocumentOrShadowRoot_activeElement();
			if(!pointer){ return; }
			var element = new HTMLElement(pointer);
			return element;
		},
	});
		
	// Methods
	Document.prototype.caretPositionFromPoint = function(){
		var caretPosition = DKDomDocumentOrShadowRoot_caretPositionFromPoint();
		if(!CaretPosition ){ return; }
		//TODO
	}
	
	//Node.call(this, pointer);
}

//DocumentOrShadowRoot.prototype = Node.prototype;	