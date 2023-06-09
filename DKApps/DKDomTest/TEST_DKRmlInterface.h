#pragma once
#ifndef TEST_DKRmlInterface_H
#define TEST_DKRmlInterface_H

#include "DKRmlInterface/DKRmlInterface.h"


class TEST_DKRmlInterface //: public DKObjectT<TEST_DKRmlInterface>
{
public:
	//DKRmlInterface dkRmlInterface;					// goes out of scope
	DKRmlInterface* dkRmlInterface;						// must delete
	//std::unique_ptr<DKRmlInterface> dkRmlInterface;
	
	TEST_DKRmlInterface() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlInterface.h //////");
		
		dkRmlInterface = new DKRmlInterface(TEST_DKRmlDocument::dkRmlDocument);
		
		printDKRmlInterfaceProperties(*dkRmlInterface);
	}
	
	~TEST_DKRmlInterface() {
		delete dkRmlInterface;
	}
	
	static void printDKRmlInterfaceProperties(DKRmlInterface& dkRmlInterface){
		DKDEBUGFUNC(dkRmlInterface);
		
		TEST_Node::printNodeProperties(dynamic_cast<DKNode&>(dkRmlInterface));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlInterface, true);


#endif //TEST_DKRmlInterface_H