// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef TEST_Node_H
#define TEST_Node_H

#include "DK/DK.h"
#include "DKNode/DKNode.h"


class TEST_Node : public DKObjectT<TEST_Node>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_Node.h ////// \n");
		return DKTODO();
	}
	
	static void printNodeProperties(DKNode& node){
		DKDEBUGFUNC(node);
		/*
		////// Instance properties //////
		DKINFO("node.baseURI = "		+toString(node.baseURI)			+"\n");	// [Node.baseURI](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/baseURI
		DKINFO("node.childNodes = "		+toString(node.childNodes)		+"\n");	// [Node.childNodes](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes
		DKINFO("node.firstChild = "		+toString(node.firstChild)		+"\n");	// [Node.firstChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/firstChild
		DKINFO("node.isConnected = "	+toString(node.isConnected)		+"\n");	// [Node.isConnected](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/isConnected
		DKINFO("node.lastChild = "		+toString(node.lastChild)		+"\n");	// [Node.lastChild](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/lastChild
		DKINFO("node.nextSibling = "	+toString(node.nextSibling)		+"\n");	// [Node.nextSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nextSibling
		DKINFO("node.nodeName = "		+toString(node.nodeName)		+"\n");	// [Node.nodeName](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeName
		DKINFO("node.nodeType = "		+toString(node.nodeType)		+"\n");	// [Node.nodeType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
		DKINFO("node.nodeValue = "		+toString(node.nodeValue)		+"\n");	// [Node.nodeValue] https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeValue
		DKINFO("node.ownerDocument = "	+toString(node.ownerDocument)	+"\n");	// [Node.ownerDocument](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/ownerDocument
		DKINFO("node.parentNode = "		+toString(node.parentNode)		+"\n");	// [Node.parentNode](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentNode
		DKINFO("node.parentElement = "	+toString(node.parentElement)	+"\n");	// [Node.parentElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/parentElement
		DKINFO("node.previousSibling = "+toString(node.previousSibling)	+"\n");	// [Node.previousSibling](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Node/previousSibling
		DKINFO("node.textContent = "	+toString(node.textContent)		+"\n");	// [Node.textContent] https://developer.mozilla.org/en-US/docs/Web/API/Node/textContent
		*/
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H