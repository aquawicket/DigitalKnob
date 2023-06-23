#pragma once
#ifndef TEST_Multiple_H
#define TEST_Multiple_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_Multiple //: public DKObjectT<TEST_Multiple>
{
public:
	DKSdlWindow* dkSdlWindowA;
	DKSdlWindow* dkSdlWindowB;

	TEST_Multiple(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Multiple.h //////");
		
		dkSdlWindowA = new DKSdlWindow();
		dkSdlWindowB = new DKSdlWindow();
	}
	
	~TEST_Multiple(){
		delete dkSdlWindowA;
		delete dkSdlWindowB;
	}
};
//REGISTER_OBJECT(TEST_Multiple, true);


#endif //TEST_Multiple_H