#pragma once
#ifndef DKNode_H
#define DKNode_H

#include "DKEventTarget/DKEventTarget.h"


// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
class DKNode : public DKEventTarget
{
public:
	////// Constructor //////
	// [Node()] 
	DKNode() : DKEventTarget() {
		DKDEBUGFUNC();
		eventTargetClass = "Node";
		eventTargetAddress = pointerToAddress(this);
	}
	
	
	////// Instance properties //////
	// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
	virtual bool baseURI(DKString&, bool) { return false; }
	// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
	virtual bool childNodes(DKString&, bool) { return false; }
	// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
	virtual bool firstChild(DKString&, bool) { return false; }
	// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
	virtual bool isConnected(bool&, bool) { return false; }
	// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
	virtual bool lastChild(DKString&, bool) { return false; }
	// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
	virtual bool nextSibling(DKString&, bool) { return false; }
	// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
	virtual bool nodeName(DKString&, bool) { return false; }
	// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
	virtual bool nodeType(DKString&, bool) { return false; }
	// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
	virtual bool nodeValue(DKString&, bool) { return false; }
	// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
	virtual bool ownerDocument(DKString&, bool) { return false; }
	// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
	virtual bool parentNode(DKString&, bool) { return false; }
	// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
	virtual bool parentElement(DKString&, bool) { return false; }
	// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
	virtual bool previousSibling(DKString&, bool) { return false; }
	// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
	virtual bool textContent(DKString&, bool) { return false; }


	////// Instance methods //////
	// [Node.appendChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/appendChild
	virtual bool appendChild(DKString& aChild) {
		DKDEBUGFUNC(aChild);
		return DKTODO();
	}
	// [Node.cloneNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode
	virtual bool cloneNode() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.compareDocumentPosition()] https://developer.mozilla.org/en-US/docs/Web/API/Node/compareDocumentPosition
	virtual bool compareDocumentPosition() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.contains()] https://developer.mozilla.org/en-US/docs/Web/API/Node/contains
	virtual bool contains() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.getRootNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/getRootNode
	virtual bool getRootNode() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.hasChildNodes()] https://developer.mozilla.org/en-US/docs/Web/API/Node/hasChildNodes
	virtual bool hasChildNodes() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.insertBefore()] https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
	virtual bool insertBefore() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.isDefaultNamespace()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isDefaultNamespace
	virtual bool isDefaultNamespace() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.isEqualNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isEqualNode
	virtual bool isEqualNode() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.isSameNode()] https://developer.mozilla.org/en-US/docs/Web/API/Node/isSameNode
	virtual bool isSameNode() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.lookupPrefix()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupPrefix
	virtual bool lookupPrefix() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.lookupNamespaceURI()] https://developer.mozilla.org/en-US/docs/Web/API/Node/lookupNamespaceURI
	virtual bool lookupNamespaceURI() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.normalize()] https://developer.mozilla.org/en-US/docs/Web/API/Node/normalize
	virtual bool normalize() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.removeChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/removeChild
	virtual bool removeChild() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Node.replaceChild()] https://developer.mozilla.org/en-US/docs/Web/API/Node/replaceChild
	virtual bool replaceChild() {
		DKDEBUGFUNC();
		return DKTODO();
	}
};


#endif //DKNode_H