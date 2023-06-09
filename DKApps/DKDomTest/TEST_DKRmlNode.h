#pragma once
#ifndef TEST_DKRmlNode_H
#define TEST_DKRmlNode_H

#include "DKRmlNode/DKRmlNode.h"


class TEST_DKRmlNode //: public DKObjectT<TEST_DKRmlNode>
{
public:
	DKRmlNode* dkRmlNode;
	//std::unique_ptr<DKRmlNode> dkRmlNode;
	
	TEST_DKRmlNode() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlNode.h //////");
		
		dkRmlNode = new DKRmlNode(TEST_DKRmlInterface::dkRmlInterface);
		
		printDKRmlNodeProperties(*dkRmlNode);
	}
	
	~TEST_DKRmlNode() {
		delete dkRmlNode;
	}
	
	static void printDKRmlNodeProperties(DKRmlNode& dkRmlNode){
		DKDEBUGFUNC(dkRmlNode);
		
		TEST_Node::printNodeProperties(dynamic_cast<DKNode&>(dkRmlNode));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlNode, true);


#endif //TEST_DKRmlNode_H