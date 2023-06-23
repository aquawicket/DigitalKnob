#pragma once
#ifndef TEST_Multiple_H
#define TEST_Multiple_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Multiple //: public DKObjectT<TEST_Multiple>
{
public:
	DKSdlWindow* dkSdlWindowA;
	DKRmlInterface* dkRmlInterfaceA;
	
	DKSdlWindow* dkSdlWindowB;
	DKRmlInterface* dkRmlInterfaceB;

	TEST_Multiple(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Multiple.h //////");
		
		dkSdlWindowA = new DKSdlWindow();
		dkRmlInterfaceA = new DKRmlInterface(dkSdlWindowA);
		
		dkSdlWindowB = new DKSdlWindow();
		dkRmlInterfaceB = new DKRmlInterface(dkSdlWindowB);
	}
	
	~TEST_Multiple(){
		delete dkSdlWindowA;
		delete dkSdlWindowB;
		delete dkRmlInterfaceA;
		delete dkRmlInterfaceB;
	}
};
//REGISTER_OBJECT(TEST_Multiple, true);


#endif //TEST_Multiple_H