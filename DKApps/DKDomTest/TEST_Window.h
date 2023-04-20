#pragma once
#ifndef TEST_Window_H
#define TEST_Window_H

#include "DK/DK.h"
#include "DKWindow/DKWindow.h"


class TEST_Window : public DKObjectT<TEST_Window>
{
public:
	bool Init(){
		DKINFO("////// TEST_Window.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Window, true);


#endif //TEST_Window_H