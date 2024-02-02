#pragma once
#ifndef TEST_DKRmlInterface_H
#define TEST_DKRmlInterface_H

#include "DKRmlInterface/DKRmlInterface.h"
#include "TEST_DKSDLWindow.h"


class TEST_DKRmlInterface //: public DKObjectT<TEST_DKRmlInterface>
{
public:
	static DKRmlInterface* _dkRmlInterface;
	
	TEST_DKRmlInterface() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlInterface.h //////");
		
		_dkRmlInterface = new DKRmlInterface(TEST_DKSDLWindow::_dkSdlWindow);
		
		printDKRmlInterfaceProperties(*_dkRmlInterface);
	}
	
	~TEST_DKRmlInterface() {
		delete _dkRmlInterface;
	}
	
	static void printDKRmlInterfaceProperties(DKRmlInterface& dkRmlInterface){
		DKDEBUGFUNC(dkRmlInterface);
		
		console.log("dkRmlInterface = "				+toString(dkRmlInterface));
		
		//TEST_Interface::printInterfaceProperties(dkRmlInterface);
	}
};
//REGISTER_OBJECT(TEST_DKRmlInterface, true);

DKRmlInterface* TEST_DKRmlInterface::_dkRmlInterface = nullptr;

#endif //TEST_DKRmlInterface_H