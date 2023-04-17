#pragma once
#ifndef TEST_WheelEvent_H
#define TEST_WheelEvent_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_WheelEvent : public DKObjectT<TEST_WheelEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_WheelEvent, true);


#endif //TEST_WheelEvent_H