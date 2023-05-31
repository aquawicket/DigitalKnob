// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKEvent/DKEvent.h"

////// UIEventInit //////
typedef std::string UIEventInit;


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface UIEvent : Event {
class DKUIEvent : public DKEvent
{
public:
	// constructor(DOMString type, optional UIEventInit eventInitDict = {});
	DKUIEvent(DOMString type, UIEventInit eventInitDict) : DKEvent(type, eventInitDict) { // https://w3c.github.io/uievents/#dom-uievent-uievent
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "UIEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKUIEvent("+interfaceAddress+") \n");
	}
	virtual ~DKUIEvent(){}
	
	// readonly attribute Window? view;
	DKString _view = ""; // https://w3c.github.io/uievents/#dom-uievent-view
	virtual DKString &	view()										{ return _view; }								// getter
	virtual void 		view(const DKString& view) 					{ _view = view; } 								// setter
	
	// readonly attribute long detail;
	int _detail = 0; // https://w3c.github.io/uievents/#dom-uievent-detail
	virtual int& 		detail()									{ return _detail; }								// getter
	virtual void 		detail(const int& detail) 					{ _detail = detail; } 							// setter
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			DKString _sourceCapabilities = ""; // https://wicg.github.io/input-device-capabilities/#dom-uieventinit-sourcecapabilities
			virtual DKString& 	sourceCapabilities()									{ return _sourceCapabilities; }					// getter
			virtual void 		sourceCapabilities(const DKString& sourceCapabilities) 	{ _sourceCapabilities = sourceCapabilities; } 	// setter
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			void initUIEvent(DOMString& typeArg, bool& bubblesArg, bool& cancelableArg, DKString& viewArg, int& detailArg){ // https://w3c.github.io/uievents/#dom-uievent-inituievent
				DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, detailArg);
				DKTODO();
			}
	//	};
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			unsigned int _which = 0; // https://w3c.github.io/uievents/#dom-uievent-which
			virtual unsigned int& 	which()								{ return _which; }						// getter
			virtual void 			which(const int& which) 			{ _which = which; } 					// setter
	// };
};


#endif //DKUIEvent_H