// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Event.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-event
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
		DKINFO("DKEvent("+_type+", "+_eventInitDict+") \n");
		
		eventClass = "Event";
		eventAddress = pointerToAddress(this);
		
		long ticks;
		DKUtil::GetTicks(ticks);
		timeStamp = ticks / 1000000.0;
		
		type = _type;
		
		eventInitDict = _eventInitDict;
	}
	virtual ~DKEvent(){}
	
	// readonly attribute DOMString type;
	DKString type = ""; 				// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	
	// readonly attribute EventTarget? target;
	DKString target = ""; 				// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	
	// readonly attribute EventTarget? srcElement; // legacy
	DKString srcElement = "";
	
	// readonly attribute EventTarget? currentTarget;
	DKString currentTarget = ""; 		// [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
	
	// sequence<EventTarget> composedPath();
	void composedPath() {				// [Event.composedPath()] https://developer.mozilla.org/en-US/docs/Web/API/Event/composedPath
		DKTODO();
	}
	
	// const unsigned short NONE = 0;
	
	// const unsigned short CAPTURING_PHASE = 1;
	
	// const unsigned short AT_TARGET = 2;
	
	// const unsigned short BUBBLING_PHASE = 3;
	
	// readonly attribute unsigned short eventPhase;
	int eventPhase = 0;					// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	
	// undefined stopPropagation();
	void stopPropagation() {			// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
		DKTODO();
	}
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	bool cancelBubble = false;			// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
	
	// undefined stopImmediatePropagation();
	void stopImmediatePropagation() {	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
		DKTODO();
	}
	
	// readonly attribute boolean bubbles;
	bool bubbles = false;				// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
	
	// readonly attribute boolean cancelable;
	bool cancelable = false;			// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
	
	// attribute boolean returnValue;  // legacy
	bool returnValue = false;			// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	
	// undefined preventDefault();
	void preventDefault() {				// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
		DKTODO();
	}
	
	// readonly attribute boolean defaultPrevented;
	bool defaultPrevented = false;		// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	
	// readonly attribute boolean composed;
	bool composed = false;				// [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	bool isTrusted = false;				// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	double timeStamp = 0;				// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	void initEvent() {					// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
		DKDEPRECATED();
	}
	
	
	////// DK properties //////
	DKString eventClass = "";
	DKString eventAddress = "";
	DKString eventInitDict = "{}";
};


#endif //DKEvent_H