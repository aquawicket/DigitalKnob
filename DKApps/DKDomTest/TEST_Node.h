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
		DKINFO("\n////// TEST_Node.h //////\n");
		
		DKNode node;
		printNodeProperties(node);
		return true;
	}
	
	static void printNodeProperties(DKNode& node){
		DKDEBUGFUNC(node);
		
		// const unsigned short ELEMENT_NODE = 1;
		DKINFO("node.ELEMENT_NODE() = "								+toString(node.ELEMENT_NODE())								+"\n");
		
		// const unsigned short ATTRIBUTE_NODE = 2;
		DKINFO("node.ATTRIBUTE_NODE() = "							+toString(node.ATTRIBUTE_NODE())							+"\n");
		
		// const unsigned short TEXT_NODE = 3;
		DKINFO("node.TEXT_NODE() = "								+toString(node.TEXT_NODE())									+"\n");
		
		// const unsigned short CDATA_SECTION_NODE = 4;
		DKINFO("node.CDATA_SECTION_NODE() = "						+toString(node.CDATA_SECTION_NODE())						+"\n");
		
		// const unsigned short ENTITY_REFERENCE_NODE = 5; // legacy
		DKINFO("node.ENTITY_REFERENCE_NODE() = "					+toString(node.ENTITY_REFERENCE_NODE())						+"\n");
		
		// const unsigned short ENTITY_NODE = 6; // legacy
		DKINFO("node.ENTITY_NODE() = "								+toString(node.ENTITY_NODE())								+"\n");
		
		// const unsigned short PROCESSING_INSTRUCTION_NODE = 7;
		DKINFO("node.PROCESSING_INSTRUCTION_NODE() = "				+toString(node.PROCESSING_INSTRUCTION_NODE())				+"\n");
		
		// const unsigned short COMMENT_NODE = 8;
		DKINFO("node.COMMENT_NODE() = "								+toString(node.COMMENT_NODE())								+"\n");
		
		// const unsigned short DOCUMENT_NODE = 9;
		DKINFO("node.DOCUMENT_NODE() = "							+toString(node.DOCUMENT_NODE())								+"\n");
		
		// const unsigned short DOCUMENT_TYPE_NODE = 10;
		DKINFO("node.DOCUMENT_TYPE_NODE() = "						+toString(node.DOCUMENT_TYPE_NODE())						+"\n");
		
		// const unsigned short DOCUMENT_FRAGMENT_NODE = 11;
		DKINFO("node.DOCUMENT_FRAGMENT_NODE() = "					+toString(node.DOCUMENT_FRAGMENT_NODE())					+"\n");
		
		// const unsigned short NOTATION_NODE = 12; // legacy
		DKINFO("node.NOTATION_NODE() = "							+toString(node.NOTATION_NODE())								+"\n");
		
		// readonly attribute unsigned short nodeType;
		DKINFO("node.nodeType() = "									+toString(node.nodeType())									+"\n");
		
		// readonly attribute DOMString nodeName;
		DKINFO("node.nodeName() = "									+toString(node.nodeName())									+"\n");
		
		// readonly attribute USVString baseURI;
		DKINFO("node.baseURI() = "									+toString(node.baseURI())									+"\n");
		
		// readonly attribute boolean isConnected;
		DKINFO("node.isConnected() = "								+toString(node.isConnected())								+"\n");
		
		// readonly attribute Document? ownerDocument;
		DKINFO("node.ownerDocument() = "							+toString(node.ownerDocument())								+"\n");
		
		// Node getRootNode(optional GetRootNodeOptions options = {});
		// function
		
		// readonly attribute Node? parentNode;
		DKINFO("node.parentNode() = "								+toString(node.parentNode())								+"\n");
		
		// readonly attribute Element? parentElement;
		DKINFO("node.parentElement() = "							+toString(node.parentElement())								+"\n");
		
		// boolean hasChildNodes();
		// function
		
		// [SameObject] readonly attribute NodeList childNodes;
		DKINFO("node.childNodes() = "								+toString(node.childNodes())								+"\n");
		
		// readonly attribute Node? firstChild;
		DKINFO("node.firstChild() = "								+toString(node.firstChild())								+"\n");
		
		// readonly attribute Node? lastChild;
		DKINFO("node.lastChild() = "								+toString(node.lastChild())									+"\n");
		
		// readonly attribute Node? previousSibling;
		DKINFO("node.previousSibling() = "							+toString(node.previousSibling())							+"\n");
		
		// readonly attribute Node? nextSibling;
		DKINFO("node.nextSibling() = "								+toString(node.nextSibling())								+"\n");
		
		// [CEReactions] attribute DOMString? nodeValue;
		DKINFO("node.nodeValue() = "								+toString(node.nodeValue())									+"\n");
		
		// [CEReactions] attribute DOMString? textContent;
		DKINFO("node.textContent() = "								+toString(node.textContent())								+"\n");
		
		// [CEReactions] undefined normalize();
		// function
		
		// [CEReactions, NewObject] Node cloneNode(optional boolean deep = false);
		// function
		
		// boolean isEqualNode(Node? otherNode);
		// function
		
		// boolean isSameNode(Node? otherNode); // legacy alias of ===
		// function
		
		// const unsigned short DOCUMENT_POSITION_DISCONNECTED = 0x01;
		DKINFO("node.DOCUMENT_POSITION_DISCONNECTED() = "			+toString(node.DOCUMENT_POSITION_DISCONNECTED())			+"\n");
		
		// const unsigned short DOCUMENT_POSITION_PRECEDING = 0x02;
		DKINFO("node.DOCUMENT_POSITION_PRECEDING() = "				+toString(node.DOCUMENT_POSITION_PRECEDING())				+"\n");
		
		// const unsigned short DOCUMENT_POSITION_FOLLOWING = 0x04;
		DKINFO("node.DOCUMENT_POSITION_FOLLOWING() = "				+toString(node.DOCUMENT_POSITION_FOLLOWING())				+"\n");
		
		// const unsigned short DOCUMENT_POSITION_CONTAINS = 0x08;
		DKINFO("node.DOCUMENT_POSITION_CONTAINS() = "				+toString(node.DOCUMENT_POSITION_CONTAINS())				+"\n");
		
		// const unsigned short DOCUMENT_POSITION_CONTAINED_BY = 0x10;
		DKINFO("node.DOCUMENT_POSITION_CONTAINED_BY() = "			+toString(node.DOCUMENT_POSITION_CONTAINED_BY())			+"\n");
		
		// const unsigned short DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = 0x20;
		DKINFO("node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC() = "+toString(node.DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC())	+"\n");
		
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
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H