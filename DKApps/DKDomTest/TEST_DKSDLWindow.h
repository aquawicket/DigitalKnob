#pragma once
#ifndef TEST_DKSDLWindow_H
#define TEST_DKSDLWindow_H

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"


class TEST_DKSDLWindow : public DKObjectT<TEST_DKSDLWindow>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_DKSDLWindow, true);


#endif //TEST_DKSDLWindow_H