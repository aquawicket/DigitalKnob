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
	DKInputEvent(DOMString type, InputEventInit eventInitDict) : DKUIEvent(type, eventInitDict) {
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "InputEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKInputEvent("+interfaceAddress+") \n");
	}
	virtual ~DKInputEvent(){}
	
	// readonly attribute DOMString? data;
	DOMString _data = "";
	virtual DOMString 	data()									{ return _data; }				// getter
	virtual void 		data(const DOMString& data) 			{ _data = data; }				// setter
	
	//readonly attribute boolean isComposing;
	bool _isComposing = false;
	virtual bool 		isComposing()							{ return _isComposing; }		// getter
	virtual void 		isComposing(const bool& isComposing) 	{ _isComposing = isComposing; }	// setter
	
	//readonly attribute DOMString inputType;
	DOMString _inputType = "";
	virtual DOMString 	inputType()								{ return _inputType; }			// getter
	virtual void 		inputType(const DOMString& inputType) 	{ _inputType = inputType; }		// setter
	
	// Source: Input Events Level 2 (https://www.w3.org/TR/input-events-2/)
	// partial interface InputEvent {
	//    	readonly attribute DataTransfer? dataTransfer;
			DKString _dataTransfer = "";
			virtual DKString 	dataTransfer()								{ return _dataTransfer; }			// getter
			virtual void 		dataTransfer(const DKString& dataTransfer) 	{ _dataTransfer = dataTransfer; }	// setter
	//		
	//    	sequence<StaticRange> getTargetRanges();
			void getTargetRanges() {
				DKDEBUGFUNC();
				DKTODO();
			}
	// };
};


#endif //DKInputEvent_H