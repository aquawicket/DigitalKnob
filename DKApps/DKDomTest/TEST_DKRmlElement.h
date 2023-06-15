#pragma once
#ifndef TEST_DKRmlElement_H
#define TEST_DKRmlElement_H

#include "DKRmlElement/DKRmlElement.h"


class TEST_DKRmlElement //: public DKObjectT<TEST_DKRmlElement>
{
public:
	DKRmlElement* dkRmlElement;
	//std::unique_ptr<DKRmlElement> dkRmlElement;
	
	TEST_DKRmlElement() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlElement.h //////");
		
		dkRmlElement = new DKRmlElement(TEST_DKRmlInterface::dkRmlInterface, NULL);
		
		printDKRmlElementProperties(*dkRmlElement);
	}
	
	~TEST_DKRmlElement() {
		delete dkRmlElement;
	}
	
	static void printDKRmlElementProperties(DKRmlElement& dkRmlElement){
		DKDEBUGFUNC(dkRmlElement);
		
		TEST_Node::printNodeProperties(dynamic_cast<DKNode&>(dkRmlElement));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlElement, true);


#endif //TEST_DKRmlElement_H