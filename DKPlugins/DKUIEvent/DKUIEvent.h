// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/UIEvent.idl
// [SOURCE] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#pragma once
#ifndef DKUIEvent_H
#define DKUIEvent_H

#include "DKEvent/DKEvent.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface UIEvent : Event {
class DKUIEvent : public DKEvent
{
public:
	//constructor(DOMString type, optional UIEventInit eventInitDict = {});
	DKUIEvent(DKString _type, DKString _eventInitDict) : DKEvent(_type, _eventInitDict) {
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "UIEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKUIEvent("+interfaceAddress+") \n");
	}
	virtual ~DKUIEvent(){}
	
	// readonly attribute Window? view;
	DKString view = ""; // https://w3c.github.io/uievents/#dom-uievent-view
	
	// readonly attribute long detail;
	unsigned int detail = 0; // https://w3c.github.io/uievents/#dom-uievent-detail
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			DKString sourceCapabilities = ""; // https://wicg.github.io/input-device-capabilities/#dom-uieventinit-sourcecapabilities
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			void initUIEvent(){ // https://w3c.github.io/uievents/#dom-uievent-inituievent
				DKDEPRECATED();
			}
	//	};
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			unsigned int which = 0; // https://w3c.github.io/uievents/#dom-uievent-which
	// };
};


#endif //DKUIEvent_H