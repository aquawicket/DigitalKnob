// [IDL] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef TEST_UIEvent_H
#define TEST_UIEvent_H

#include "DK/DK.h"
#include "DKUIEvent/DKUIEvent.h"


class TEST_UIEvent : public DKObjectT<TEST_UIEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_UIEvent.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_UIEvent, true);


#endif //TEST_UIEvent_H