#pragma once
#ifndef TEST_KeyboardEvent_H
#define TEST_KeyboardEvent_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_KeyboardEvent : public DKObjectT<TEST_KeyboardEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_KeyboardEvent, true);


#endif //TEST_KeyboardEvent_H