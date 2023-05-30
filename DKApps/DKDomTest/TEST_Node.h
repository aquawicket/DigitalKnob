// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef TEST_Node_H
#define TEST_Node_H

#include "DKNode/DKNode.h"


class TEST_Node : public DKObjectT<TEST_Node>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_Node.h //////\n");
		
		DKNode node;
		printNodeProperties(node);
		return true;
	}
	
	static void printNodeProperties(DKNode& node){
		DKDEBUGFUNC(node);
		
		// const unsigned short ELEMENT_NODE = 1;
		DKConsole::log("node.ELEMENT_NODE() = "								+toString(node.ELEMENT_NODE()));
		
		// const unsigned short ATTRIBUTE_NODE = 2;
		DKConsole::log("node.ATTRIBUTE_NODE() = "							+toString(node.ATTRIBUTE_NODE()));
		
		// const unsigned short TEXT_NODE = 3;
		DKConsole::log("node.TEXT_NODE() = "								+toString(node.TEXT_NODE()));
		
		// const unsigned short CDATA_SECTION_NODE = 4;
		DKConsole::log("node.CDATA_SECTION_NODE() = "						+toString(node.CDATA_SECTION_NODE()));
		
		// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
		DKConsole::log("node.ENTITY_REFERENCE_NODE() = "					+toString(node.ENTITY_REFERENCE_NODE()));
		
		// const unsigned short ENTITY_NODE = 6; // legacy
		DKConsole::log("node.ENTITY_NODE() = "								+toString(node.ENTITY_NODE()));
		
		// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
		DKConsole::log("node.PROCESSING_INSTRUCTION_NODE() = "				+toString(node.PROCESSING_INSTRUCTION_NODE()));
		
		// const unsigned short COMMENT_NODE = 8;
		DKConsole::log("node.COMMENT_NODE() = "								+toString(node.COMMENT_NODE()));
		
		// const unsigned short DOCUMENT_NODE = 9;
		DKConsole::log("node.DOCUMENT_NODE() = "							+toString(node.DOCUMENT_NODE()));
		
		// const unsigned short DOCUMENT_TYPE_NODE = 10;
		DKConsole::log("node.DOCUMENT_TYPE_NODE() = "						+toString(node.DOCUMENT_TYPE_NODE()));
		
		// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
		DKConsole::log("node.DOCUMENT_FRAGMENT_NODE() = "					+toString(node.DOCUMENT_FRAGMENT_NODE()));
		
		// const unsigned short NOTATION_NODE = 12; // legacy
		DKConsole::log("node.NOTATION_NODE() = "							+toString(node.NOTATION_NODE()));
		
		// readonly attribute unsigned short nodeType;
		DKConsole::log("node.nodeType() = "									+toString(node.nodeType()));
		
		// readonly attribute DOMString nodeName;
		DKConsole::log("node.nodeName() = "									+toString(node.nodeName()));
		
		// readonly attribute USVString baseURI;
		DKConsole::log("node.baseURI() = "									+toString(node.baseURI()));
		
		// readonly attribute boolean isConnected;
		DKConsole::log("node.isConnected() = "								+toString(node.isConnected()));
		
		// readonly attribute Document? ownerDocument;
		DKConsole::log("node.ownerDocument() = "							+toString(node.ownerDocument()));
		
		// Node getRootNode(optional GetRootNodeOptions options = {});
		// function
		
		// readonly attribute Node? parentNode;
		DKConsole::log("node.parentNode() = "								+toString(node.parentNode()));
		
		// readonly attribute Element? parentElement;
		DKConsole::log("node.parentElement() = "							+toString(node.parentElement()));
		
		// boolean hasChildNodes();
		// function
		
		// [SameObject] readonly attribute NodeList childNodes;
		DKConsole::log("node.childNodes() = "								+toString(node.childNodes()));
		
		// readonly attribute Node? firstChild;
		DKConsole::log("node.firstChild() = "								+toString(node.firstChild()));
		
		// readonly attribute Node? lastChild;
		DKConsole::log("node.lastChild() = "								+toString(node.lastChild()));
		
		// readonly attribute Node? previousSibling;
		DKConsole::log("node.previousSibling() = "							+toString(node.previousSibling()));
		
		// readonly attribute Node? nextSibling;
		DKConsole::log("node.nextSibling() = "								+toString(node.nextSibling()));
		
		// [CEReactions] attribute DOMString? nodeValue;
		DKConsole::log("node.nodeValue() = "								+toString(node.nodeValue()));
		
		// [CEReactions] attribute DOMString? textContent;
		DKConsole::log("node.textContent() = "								+toString(node.textContent()));
		
		// [CEReactions] undefined normalize();
		// function
		
		// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
		// function
		
		// boolean isEqualNode(Node? otherNode);
		// function
		
		// boolean isSameNode(Node? otherNode); // legacy alias of ===
		// function
		
		// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
		DKConsole::log("node.DOCUMENT_POSITION_DISCONNECTED() = "			+toString(node.DOCUMENT_POSITION_DISCONNECTED()));
		
		// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
		DKConsole::log("node.DOCUMENT_POSITION_PRECEDING() = "				+toString(node.DOCUMENT_POSITION_PRECEDING()));
		
		// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
		DKConsole::log("node.DOCUMENT_POSITION_FOLLOWING() = "				+toString(node.DOCUMENT_POSITION_FOLLOWING()));
		
		// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
		DKConsole::log("node.DOCUMENT_POSITION_CONTAINS() = "				+toString(node.DOCUMENT_POSITION_CONTAINS()));
		
		// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
		DKConsole::log("node.DOCUMENT_POSITION_CONTAINED_BY() = "			+toString(node.DOCUMENT_POSITION_CONTAINED_BY()));
		
		// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
		DKConsole::log("node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC() = "+toString(node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC()));
		
		// unsigned short compareDocumentPosition(Node other);
		// function
		
		// boolean contains(Node? other);
		// function
		
		// DOMString? lookupPrefix(DOMString? namespace);
		// function
		
		// DOMString? lookupNamespaceURI(DOMString? prefix);
		// function
		
		// boolean isDefaultNamespace(DOMString? namespace);
		// function
		
		// [CEReactions] Node insertBefore(Node node, Node? child);
		// function
		
		// [CEReactions] Node appendChild(Node node);
		// function
		
		// [CEReactions] Node replaceChild(Node node, Node child);
		// function
		
		// [CEReactions] Node removeChild(Node child);
		// function
		
		TEST_EventTarget::printEventTargetProperties(dynamic_cast<DKEventTarget&>(node));	//TODO: try to remove the need for dynamic_cast
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H