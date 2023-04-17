#pragma once
#ifndef TEST_InputEvent_H
#define TEST_InputEvent_H

#include "DK/DK.h"
#include "DKInputEvent/DKInputEvent.h"


class TEST_InputEvent : public DKObjectT<TEST_InputEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_InputEvent, true);


#endif //TEST_InputEvent_H