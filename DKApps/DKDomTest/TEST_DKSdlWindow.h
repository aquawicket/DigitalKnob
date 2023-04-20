#pragma once
#ifndef TEST_DKSdlWindow_H
#define TEST_DKSdlWindow_H

#include "DK/DK.h"
#include "DKSdlWindow/DKSdlWindow.h"


class TEST_DKSdlWindow : public DKObjectT<TEST_DKSdlWindow>
{
public:
	bool Init(){
		DKINFO("////// TEST_DKSdlWindow.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_DKSdlWindow, true);


#endif //TEST_DKSdlWindow_H