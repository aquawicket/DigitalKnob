// [IDL] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#pragma once
#ifndef TEST_InputEvent_H
#define TEST_InputEvent_H

#include "DK/DK.h"
#include "DKInputEvent/DKInputEvent.h"


class TEST_InputEvent : public DKObjectT<TEST_InputEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_InputEvent.h ////// \n");
		
		////// Constructor //////
		// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
	
		
		////// Instance properties //////
		// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
		// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
		// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
		// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	
	
		////// Instance methods //////
		// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	
	
		////// Events //////
		// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
		// [input] https://w3c.github.io/uievents/#event-type-input
	
	
		return DKTODO();
	}
	
};
REGISTER_OBJECT(TEST_InputEvent, true);


#endif //TEST_InputEvent_H