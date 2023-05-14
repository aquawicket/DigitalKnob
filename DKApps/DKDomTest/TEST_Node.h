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
		DKINFO("node.ELEMENT_NODE = "	+toString(node.ELEMENT_NODE)	+"\n");
		DKTODO();
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H