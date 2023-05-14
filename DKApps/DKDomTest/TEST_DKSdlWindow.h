#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow : public DKObjectT<TEST_DKSdlWindow>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKSdlWindow.h //////\n");
		
		DKSdlWindow dksdlwindow;
		printDKSdlWindowProperties(dksdlwindow);
		return true;
	}

	static void printDKSdlWindowProperties(DKSdlWindow& dksdlwindow){
		DKDEBUGFUNC(dksdlwindow);
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_DKSdlWindow, true);


#endif //TEST_DKSdlWindow_H