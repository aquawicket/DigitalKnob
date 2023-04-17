#pragma once
#ifndef TEST_MouseEvent_H
#define TEST_MouseEvent_H

#include "DK/DK.h"
#include "DKConsole/DKConsole.h"


class TEST_MouseEvent : public DKObjectT<TEST_MouseEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H