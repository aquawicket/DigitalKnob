#pragma once
#ifndef DKInputEvent_H
#define DKInputEvent_H

#include "DKEventTestB/DKUIEvent.h"


// [W3C] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
class DKInputEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
	DKInputEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKInputEvent("+_type+", "+_options+") \n");
		
		eventClass = "InputEvent";
		
		////// Instance properties //////
		//data = ""; //FIXME: data is already a member of DKObject
		dataTransfer = "";
		inputType = "";
		isComposing = false;
	}
	

	////// Instance properties //////
	// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	//DKString data; //FIXME: data is already a member of DKObject
	// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	DKString dataTransfer;
	// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	DKString inputType;
	// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	bool isComposing;

	
	////// Instance methods //////
	// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	void getTargetRanges() {
		DKTODO();
	}

	
	////// Events //////
	// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
	// [input] https://w3c.github.io/uievents/#event-type-input
};


#endif //DKInputEvent_H