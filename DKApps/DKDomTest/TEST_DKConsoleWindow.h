#pragma once
#ifndef TEST_DKConsoleWindow_H
#define TEST_DKConsoleWindow_H

#include "DKConsoleWindow/DKConsoleWindow.h"


class TEST_DKConsoleWindow : public DKObjectT<TEST_DKConsoleWindow>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_DKConsoleWindow.h ////// \n");
		
		DKConsoleWindow dkConsoleWindow;
		printDKConsoleWindowProperties(dkConsoleWindow);
		return true;
	}

	static void printDKConsoleWindowProperties(DKConsoleWindow& dkConsoleWindow){
		DKDEBUGFUNC(dkConsoleWindow);
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_DKConsoleWindow, true);


#endif //TEST_DKConsoleWindow_H