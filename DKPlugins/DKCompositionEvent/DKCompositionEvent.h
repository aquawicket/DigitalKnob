// [IDL] https://w3c.github.io/uievents/#idl-compositionevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent
#pragma once
#ifndef DKCompositionEvent_H
#define DKCompositionEvent_H

#include "DKUIEvent/DKUIEvent.h"


////// CompositionEventInit //////
typedef std::string CompositionEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface CompositionEvent : UIEvent {
class DKCompositionEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional CompositionEventInit eventInitDict = {});
	DKCompositionEvent(const DOMString& type, const CompositionEventInit& eventInitDict = "{}") : DKUIEvent(type, eventInitDict) { // [CompositionEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CompositionEvent/CompositionEvent
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "CompositionEvent";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	virtual ~DKCompositionEvent(){}
	
	// readonly attribute DOMString data;
	DOMString _data = "";
	virtual const DOMString& 	data()						{ return _data; }	// getter
	virtual void 				data(const DOMString& data) { _data = data; }	// setter
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface CompositionEvent {
	// Originally introduced (and deprecated) in this specification
	// undefined initCompositionEvent(DOMString typeArg,
	// optional boolean bubblesArg = false,
	// optional boolean cancelableArg = false,
	// optional WindowProxy? viewArg = null,
	// optional DOMString dataArg = "");
	virtual void initCompositionEvent(
		const DOMString& typeArg, 
		const bool& bubblesArg = false, 
		const bool& cancelableArg = false, 
		DKWindow* viewArg = NULL,		// FIXME: change to DKWindowProxy
		const DOMString& dataArg = "") {
		DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, dataArg);
		DKTODO();
	}
	// };
	
	
	////// toString //////
	operator std::string() const { return "[object CompositionEvent]"; }
};


#endif //DKCompositionEvent_H