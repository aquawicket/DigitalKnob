#pragma once
#ifndef TEST_EventTarget_H
#define TEST_EventTarget_H

#include "DK/DK.h"
#include "DKEventTarget/DKEventTarget.h"


class TEST_EventTarget : public DKObjectT<TEST_EventTarget>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_EventTarget, true);


#endif //TEST_EventTarget_H