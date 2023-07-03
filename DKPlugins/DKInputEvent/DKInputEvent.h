// [IDL] https://w3c.github.io/uievents/#idl-inputevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent
#pragma once
#ifndef DKInputEvent_H
#define DKInputEvent_H

#include "DKUIEvent/DKUIEvent.h"

////// InputEventInit //////
typedef std::string InputEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface InputEvent : UIEvent {
class DKInputEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional InputEventInit eventInitDict = {});
	DKInputEvent(const DOMString& type, const InputEventInit& eventInitDict = "{}") : DKUIEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "InputEvent";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	//virtual ~DKInputEvent(){}
	
	// readonly attribute DOMString? data;
	DOMString _data = "";
	virtual const DOMString& 	data()									{ return _data; }					// getter
	virtual void 				data(const DOMString& data) 			{ _data = data; }					// setter
	
	//readonly attribute boolean isComposing;
	bool _isComposing = false;
	virtual const bool&			isComposing()							{ return _isComposing; }			// getter
	virtual void 				isComposing(const bool& isComposing) 	{ _isComposing = isComposing; }		// setter
	
	//readonly attribute DOMString inputType;
	DOMString _inputType = "";
	virtual const DOMString& 	inputType()								{ return _inputType; }				// getter
	virtual void 				inputType(const DOMString& inputType) 	{ _inputType = inputType; }			// setter
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	// readonly attribute DataTransfer? dataTransfer;
	DKString _dataTransfer = "";
	virtual const DKString& 	dataTransfer()							{ return _dataTransfer; }			// getter
	virtual void 				dataTransfer(const DKString& dataTransfer) 	{ _dataTransfer = dataTransfer; }	// setter
	
	// sequence<StaticRange> getTargetRanges();
	DKString _getTargetRanges = "";
	virtual const DKString& getTargetRanges() {
		DKDEBUGFUNC();
		DKTODO();
		return _getTargetRanges;
	}
	// };
	
	
	////// toString //////
	operator std::string() const { return "[object InputEvent]"; }
};


#endif //DKInputEvent_H