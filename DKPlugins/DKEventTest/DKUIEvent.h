#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKEventTest/DKEvent.h"


// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
class DKUIEvent : public DKEvent
{
public:
	////// Constructor //////
	// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
	DKUIEvent(DKString _type, DKString _options) : DKEvent(_type, _options) {
		detail = 0;
		sourceCapabilities = NULL;
		view = NULL;
		which = 0;
	}
	
	
	////// Instance properties //////
	// [UIEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail
	unsigned int detail;
	// [UIEvent.sourceCapabilities](Experimental)(Read only)
	void* sourceCapabilities;
	// [UIEvent.view](Read only)
	void* view;
	// [UIEvent.which](Deprecated)(Read only)
	unsigned int which;
};


#endif //DKUIEvent_H