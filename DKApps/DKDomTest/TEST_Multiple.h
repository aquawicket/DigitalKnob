#pragma once
#ifndef TEST_Multiple_H
#define TEST_Multiple_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Multiple //: public DKObjectT<TEST_Multiple>
{
public:
	DKSdlWindow* 		dkSdlWindowA;
	DKRmlInterface* 	dkRmlInterfaceA;
	DKRmlEventListener* dkRmlEventListenerA;
	DKRmlLocation*		dkRmlLocationA;
	
	//DKSdlWindow* 			dkSdlWindowB;
	//DKRmlInterface* 		dkRmlInterfaceB;
	//DKRmlEventListener* 	dkRmlEventListenerB;
	//DKRmlLocation*		dkRmlLocationB;

	TEST_Multiple(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Multiple.h //////");
		
		dkSdlWindowA = 			new DKSdlWindow();
		dkRmlInterfaceA = 		new DKRmlInterface(dkSdlWindowA);
		dkRmlEventListenerA = 	new DKRmlEventListener();
		dkRmlLocationA = 		new DKRmlLocation(dkRmlInterfaceA, dkRmlEventListenerA);
		dkRmlLocationA->href("DKWebTest/index.html");
		
		//dkSdlWindowB = 		new DKSdlWindow();
		//dkRmlInterfaceB = 	new DKRmlInterface(dkSdlWindowB);
		//dkRmlEventListenerB = new DKRmlEventListener();
		//dkRmlLocationB = 		new DKRmlLocation(dkRmlInterfaceB, dkRmlEventListenerB);
		//dkRmlLocationB->href("DKWebTest/index.html");
	}
	
	~TEST_Multiple(){
		delete dkSdlWindowA;
		delete dkRmlInterfaceA;
		delete dkRmlEventListenerA;
		delete dkRmlLocationA;
		
		//delete dkSdlWindowB;
		//delete dkRmlInterfaceB;
		//delete dkRmlEventListenerB;
		//delete dkRmlLocationB;
	}
};
//REGISTER_OBJECT(TEST_Multiple, true);


#endif //TEST_Multiple_H