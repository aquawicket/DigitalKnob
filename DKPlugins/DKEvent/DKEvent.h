// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DK/DK.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface Event {
class DKEvent
{
public:
	// constructor(DOMString type, optional EventInit eventInitDict = {});  // [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	DKEvent(DKString _type, DKString _eventInitDict){
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "Event";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKEvent("+interfaceAddress+") \n");
		
		long ticks;
		DKUtil::GetTicks(ticks);
		timeStamp = ticks / 1000000.0;
		
		type = _type;
		
		eventInitDict = _eventInitDict;
	}
	virtual ~DKEvent(){}
	
	// readonly attribute DOMString type;
	DKString type = ""; // https://dom.spec.whatwg.org/#dom-event-type
	
	// readonly attribute EventTarget? target;
	DKString target = ""; // https://dom.spec.whatwg.org/#dom-event-target
	
	// readonly attribute EventTarget? srcElement; // legacy
	DKString srcElement = ""; // https://dom.spec.whatwg.org/#dom-event-srcelement
	
	// readonly attribute EventTarget? currentTarget;
	DKString currentTarget = ""; // https://dom.spec.whatwg.org/#dom-event-currenttarget
	
	// sequence<EventTarget> composedPath();
	void composedPath() { // https://dom.spec.whatwg.org/#dom-event-composedpath
		DKTODO();
	}
	
	// const unsigned short NONE = 0;
	const unsigned short NONE = 0; //https://dom.spec.whatwg.org/#dom-event-none
	
	// const unsigned short CAPTURING_PHASE = 1;
	const unsigned short CAPTURING_PHASE = 1; // https://dom.spec.whatwg.org/#dom-event-capturing_phase
	
	// const unsigned short AT_TARGET = 2;
	const unsigned short AT_TARGET = 2; // https://dom.spec.whatwg.org/#dom-event-at_target
	
	// const unsigned short BUBBLING_PHASE = 3;
	const unsigned short BUBBLING_PHASE = 3; // https://dom.spec.whatwg.org/#dom-event-bubbling_phase
	
	// readonly attribute unsigned short eventPhase;
	unsigned short eventPhase = 0; // https://dom.spec.whatwg.org/#dom-event-eventphase
	
	// undefined stopPropagation();
	void stopPropagation() { // https://dom.spec.whatwg.org/#dom-event-stoppropagation
		DKTODO();
	}
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	bool cancelBubble = false; // https://dom.spec.whatwg.org/#dom-event-cancelbubble
	
	// undefined stopImmediatePropagation();
	void stopImmediatePropagation() { // https://dom.spec.whatwg.org/#dom-event-stopimmediatepropagation
		DKTODO();
	}
	
	// readonly attribute boolean bubbles;
	bool bubbles = false; // https://dom.spec.whatwg.org/#dom-event-bubbles
	
	// readonly attribute boolean cancelable;
	bool cancelable = false; // https://dom.spec.whatwg.org/#dom-event-cancelable
	
	// attribute boolean returnValue;  // legacy
	bool returnValue = false; // https://dom.spec.whatwg.org/#dom-event-returnvalue
	
	// undefined preventDefault();
	void preventDefault() { // https://dom.spec.whatwg.org/#dom-event-preventdefault
		DKTODO();
	}
	
	// readonly attribute boolean defaultPrevented;
	bool defaultPrevented = false; // https://dom.spec.whatwg.org/#dom-event-defaultprevented
	
	// readonly attribute boolean composed;
	bool composed = false; // https://dom.spec.whatwg.org/#dom-event-composed
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	bool isTrusted = false; // https://dom.spec.whatwg.org/#dom-event-istrusted
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	double timeStamp = 0; // https://dom.spec.whatwg.org/#dom-event-timestamp
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	void initEvent(DKString& type, bool& bubbles, bool& cancelable) { // https://dom.spec.whatwg.org/#dom-event-initevent
		DKDEBUGFUNC(type, bubbles, cancelable);
		DKTODO();
	}
	
	
	////// DK properties //////
	DKString interfaceName = "";
	DKString interfaceAddress = "";
	DKString eventInitDict = "{}";
};


#endif //DKEvent_H