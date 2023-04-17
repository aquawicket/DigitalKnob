// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node


// [Node()]
var Node = function Node(address) {
	//console.log("Node("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKNodeDUK();

	
	////// Instance properties //////
	// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
	// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
	// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
	// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
	// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
	// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
	// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
	// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
	// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
	// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
	// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
	// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
	// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
	// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
	
	
	////// Instance methods //////
	// [Node.appendChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild
	// [Node.cloneNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode
	// [Node.compareDocumentPosition()] https://developer.mozilla.org/en-US/docs/Web/API/Node/compareDocumentPosition
	// [Node.contains()] https://developer.mozilla.org/en-US/docs/Web/API/Node/contains
	// [Node.getRootNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/getRootNode
	// [Node.hasChildNodes()] https://developer.mozilla.org/en-US/docs/Web/API/Node/hasChildNodes
	// [Node.insertBefore()] https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
	// [Node.isDefaultNamespace()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isDefaultNamespace
	// [Node.isEqualNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isEqualNode
	// [Node.isSameNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isSameNode
	// [Node.lookupPrefix()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupPrefix
	// [Node.lookupNamespaceURI()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupNamespaceURI
	// [Node.normalize()] https://developer.mozilla.org/en-US/docs/Web/API/Node/normalize
	// [Node.removeChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild
	// [Node.replaceChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Node]" }
	
	
	return EventTarget.call(this)
}
Node.prototype = EventTarget.prototype
