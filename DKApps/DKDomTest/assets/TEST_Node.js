// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
console.log("////// TEST_Node.js //////")


function printNodeProperties(node){
	////// Instance properties //////
	console.log("node.baseURI = "			+node.baseURI)			// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
	console.log("node.childNodes = "		+node.childNodes)		// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
	console.log("node.firstChild = "		+node.firstChild)		// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
	console.log("node.isConnected = "		+node.isConnected)		// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
	console.log("node.lastChild = "			+node.lastChild)		// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
	console.log("node.nextSibling = "		+node.nextSibling)		// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
	console.log("node.nodeName = "			+node.nodeName)			// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
	console.log("node.nodeType = "			+node.nodeType)			// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
	console.log("node.nodeValue = "			+node.nodeValue)		// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
	console.log("node.ownerDocument = "		+node.ownerDocument)	// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
	console.log("node.parentNode = "		+node.parentNode)		// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
	console.log("node.parentElement = "		+node.parentElement)	// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
	console.log("node.previousSibling = "	+node.previousSibling)	// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
	console.log("node.textContent = "		+node.textContent)		// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
}

