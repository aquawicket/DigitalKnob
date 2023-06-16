#pragma once
#ifndef TEST_DKRmlInterface_H
#define TEST_DKRmlInterface_H

#include "DKRmlInterface/DKRmlInterface.h"
#include "TEST_DKSdlWindow.h"


class TEST_DKRmlInterface //: public DKObjectT<TEST_DKRmlInterface>
{
public:
	static DKRmlInterface* dkRmlInterface;				// must delete
	//std::unique_ptr<DKRmlInterface> dkRmlInterface;
	
	TEST_DKRmlInterface() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlInterface.h //////");
		
		dkRmlInterface = new DKRmlInterface(TEST_DKSdlWindow::dkSdlWindow);
		//dkRmlInterface = std::make_unique<DKRmlInterface>(TEST_DKSdlWindow::dkSdlWindow);	
		
		printDKRmlInterfaceProperties(*dkRmlInterface);
	}
	
	~TEST_DKRmlInterface() {
		delete dkRmlInterface;
	}
	
	static void printDKRmlInterfaceProperties(DKRmlInterface& dkRmlInterface){
		//DKDEBUGFUNC(dkRmlInterface);
		
		//TEST_Interface::printNodeProperties(dynamic_cast<DKInterface&>(dkRmlInterface));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlInterface, true);

DKRmlInterface* TEST_DKRmlInterface::dkRmlInterface;

#endif //TEST_DKRmlInterface_H