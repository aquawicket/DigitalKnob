// [IDL] https://w3c.github.io/uievents/#events-compositionevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef TEST_CompositionEvent_H
#define TEST_CompositionEvent_H

#include "DK/DK.h"
#include "DKCompositionEvent/DKCompositionEvent.h"


class TEST_CompositionEvent : public DKObjectT<TEST_CompositionEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_CompositionEvent.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_CompositionEvent, true);


#endif //TEST_CompositionEvent_H