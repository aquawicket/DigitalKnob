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
		DKINFO("node.ELEMENT_NODE = "				+toString(node.ELEMENT_NODE)				+"\n");
		DKINFO("node.ATTRIBUTE_NODE = "				+toString(node.ATTRIBUTE_NODE)				+"\n");
		DKINFO("node.TEXT_NODE = "					+toString(node.TEXT_NODE)					+"\n");
		DKINFO("node.CDATA_SECTION_NODE = "			+toString(node.CDATA_SECTION_NODE)			+"\n");
		DKINFO("node.ENTITY_REFERENCE_NODE = "		+toString(node.ENTITY_REFERENCE_NODE)		+"\n");
		DKINFO("node.ENTITY_NODE = "				+toString(node.ENTITY_NODE)					+"\n");
		DKINFO("node.PROCESSING_INSTRUCTION_NODE = "+toString(node.PROCESSING_INSTRUCTION_NODE)	+"\n");
		DKINFO("node.COMMENT_NODE = "				+toString(node.COMMENT_NODE)				+"\n");
		DKINFO("node.DOCUMENT_NODE = "				+toString(node.DOCUMENT_NODE)				+"\n");
		DKINFO("node.DOCUMENT_TYPE_NODE = "			+toString(node.DOCUMENT_TYPE_NODE)			+"\n");
		DKINFO("node.DOCUMENT_FRAGMENT_NODE = "		+toString(node.DOCUMENT_FRAGMENT_NODE)		+"\n");
		DKINFO("node.NOTATION_NODE = "				+toString(node.NOTATION_NODE)				+"\n");
		//DKINFO("node.nodeType = "					+toString(node.nodeType)					+"\n");
		//DKINFO("node.nodeName = "					+toString(node.nodeName)					+"\n");
		//DKINFO("node.baseURI = "					+toString(node.baseURI)						+"\n");
		//DKINFO("node.isConnected = "				+toString(node.isConnected)					+"\n");
		//DKINFO("node.ownerDocument = "			+toString(node.ownerDocument)				+"\n");
		DKTODO();
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H