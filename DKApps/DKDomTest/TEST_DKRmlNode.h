#pragma once
#ifndef TEST_DKRmlNode_H
#define TEST_DKRmlNode_H

#include "DKRmlNode/DKRmlNode.h"


class TEST_DKRmlNode //: public DKObjectT<TEST_DKRmlNode>
{
public:
	DKRmlNode* dkRmlNode;
	
	TEST_DKRmlNode() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlNode.h //////");
		
		dkRmlNode = new DKRmlNode(TEST_DKRmlEventListener::_dkRmlEventListener, NULL);
		
		printDKRmlNodeProperties(dkRmlNode);
	}
	
	~TEST_DKRmlNode() {
		delete dkRmlNode;
	}
	
	static void printDKRmlNodeProperties(DKRmlNode* dkRmlNode){
		DKDEBUGFUNC(dkRmlNode);
		
		console.log("dkRmlNode = "		+toString(dkRmlNode));
		
		TEST_Node::printNodeProperties(dkRmlNode);
	}
};
//REGISTER_OBJECT(TEST_DKRmlNode, true);


#endif //TEST_DKRmlNode_H