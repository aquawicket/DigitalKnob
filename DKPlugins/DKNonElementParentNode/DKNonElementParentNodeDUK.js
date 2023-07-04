// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
var NonElementParentNode = {
	//console.log("NonElementParentNode("+this.address+")")
	
	// Element? getElementById(DOMString elementId);
	getElementById(elementId){
		console.log("NonElementParentNode.prototype.getElementById("+elementId+")");
		return new Element(CPP_DKNonElementParentNodeDUK_getElementById(this.address, elementId));
	}
};
Object.assign(Document.prototype, NonElementParentNode);
