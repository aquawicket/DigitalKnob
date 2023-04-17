#pragma once
#ifndef TEST_FocusEvent_H
#define TEST_FocusEvent_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_FocusEvent : public DKObjectT<TEST_FocusEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_FocusEvent, true);


#endif //TEST_FocusEvent_H