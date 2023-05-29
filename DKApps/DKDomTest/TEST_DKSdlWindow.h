#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow : public DKObjectT<TEST_DKSdlWindow>
{
public:
	DKSdlWindow dkSdlWindowA;
	DKSdlWindow dkSdlWindowB;
	
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKSdlWindow.h //////\n");
		
		//DKSdlWindow dkSdlWindow;
		printDKSdlWindowProperties(dkSdlWindowA);
		printDKSdlWindowProperties(dkSdlWindowB);
		return true;
	}

	static void printDKSdlWindowProperties(DKSdlWindow& dkSdlWindow){
		DKDEBUGFUNC(dkSdlWindow);
		
		TEST_Window::printWindowProperties(dynamic_cast<DKWindow&>(dkSdlWindow));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_DKSdlWindow, true);


#endif //TEST_DKSdlWindow_H