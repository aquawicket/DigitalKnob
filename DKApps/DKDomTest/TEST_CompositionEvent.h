#pragma once
#ifndef TEST_CompositionEvent_H
#define TEST_CompositionEvent_H

#include "DK/DK.h"
#include "DKCompositionEvent/DKCompositionEvent.h"


class TEST_CompositionEvent : public DKObjectT<TEST_CompositionEvent>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}


};
REGISTER_OBJECT(TEST_CompositionEvent, true);


#endif //TEST_CompositionEvent_H