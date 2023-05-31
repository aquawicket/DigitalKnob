// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DKInterface/DKInterface.h"


////// EventInit //////
typedef std::string EventInit;

////// DOMHighResTimeStamp //////
typedef double DOMHighResTimeStamp;

////// EventTarget //////
class DKEventTarget;


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface Event {
class DKEvent : public DKInterface
{
public:
	// constructor(DOMString type, optional EventInit eventInitDict = {});
	DKEvent(DOMString type, EventInit eventInitDict) : DKInterface(){
		DKDEBUGFUNC(type, eventInitDict);
		interfaceName = "Event";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKEvent("+interfaceAddress+") \n");
		
		long ticks;
		DKUtil::GetTicks(ticks);
		_timeStamp = ticks / 1000000.0;
		
		_type = type;
		
		_eventInitDict = eventInitDict;
	}
	virtual ~DKEvent(){}
	
	// readonly attribute DOMString type;
	DOMString _type = ""; // https://dom.spec.whatwg.org/#dom-event-type
	virtual const DOMString& 	type()															{ return _type; }							// getter
	virtual void 				type(const DOMString& type) 									{ _type = type; } 							// setter
	
	// readonly attribute EventTarget? target;
	DKString _target = ""; // https://dom.spec.whatwg.org/#dom-event-target
	virtual const DKString& 	target()														{ return _target; }							// getter
	virtual void 				target(const DOMString& target)									{ _target = target; } 						// setter
	
	// readonly attribute EventTarget? srcElement; // legacy
	DKString _srcElement = ""; // https://dom.spec.whatwg.org/#dom-event-srcelement
	virtual const DKString& 	srcElement()													{ return _srcElement; }						// getter
	virtual void 				srcElement(const DOMString& srcElement) 						{ _srcElement = srcElement; } 				// setter
	
	// readonly attribute EventTarget? currentTarget;
	DKString _currentTarget = ""; // https://dom.spec.whatwg.org/#dom-event-currenttarget
	virtual const DKString& 	currentTarget()													{ return _currentTarget; }					// getter
	virtual void 				currentTarget(const DOMString& currentTarget) 					{ _currentTarget = currentTarget; }			// setter
	
	// sequence<EventTarget> composedPath();
	void composedPath() { // https://dom.spec.whatwg.org/#dom-event-composedpath
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// const unsigned short NONE = 0;
	const unsigned short _NONE = 0; //https://dom.spec.whatwg.org/#dom-event-none
	virtual const unsigned short& 		NONE()													{ return _NONE; }							// getter
	//virtual void 						NONE(const unsigned short& NONE) 						{ _NONE = NONE; }			 				// setter
	
	// const unsigned short CAPTURING_PHASE = 1;
	const unsigned short _CAPTURING_PHASE = 1; // https://dom.spec.whatwg.org/#dom-event-capturing_phase
	virtual const unsigned short& 		CAPTURING_PHASE()										{ return _CAPTURING_PHASE; }				// getter
	//virtual void 						CAPTURING_PHASE(const unsigned short& CAPTURING_PHASE) 	{ _CAPTURING_PHASE = CAPTURING_PHASE; }		// setter
	
	// const unsigned short AT_TARGET = 2;
	const unsigned short _AT_TARGET = 2; // https://dom.spec.whatwg.org/#dom-event-at_target
	virtual const unsigned short& 		AT_TARGET()												{ return _AT_TARGET; }						// getter
	//virtual void 						AT_TARGET(const unsigned short& AT_TARGET) 				{ _AT_TARGET = AT_TARGET; }					// setter
	
	// const unsigned short BUBBLING_PHASE = 3;
	const unsigned short _BUBBLING_PHASE = 3; // https://dom.spec.whatwg.org/#dom-event-bubbling_phase
	virtual const unsigned short& 		BUBBLING_PHASE()										{ return _BUBBLING_PHASE; }					// getter
	//virtual void 						BUBBLING_PHASE(const unsigned short& BUBBLING_PHASE) 	{ _BUBBLING_PHASE = BUBBLING_PHASE; }		// setter
	
	// readonly attribute unsigned short eventPhase;
	unsigned short _eventPhase = 0; // https://dom.spec.whatwg.org/#dom-event-eventphase
	virtual const unsigned short &		eventPhase()											{ return _eventPhase; }						// getter
	virtual void 						eventPhase(const unsigned short& eventPhase) 			{ _eventPhase = eventPhase; }				// setter
	
	// undefined stopPropagation();
	void stopPropagation() { // https://dom.spec.whatwg.org/#dom-event-stoppropagation
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	bool _cancelBubble = false; // https://dom.spec.whatwg.org/#dom-event-cancelbubble
	virtual const bool& 				cancelBubble()											{ return _cancelBubble; }					// getter
	virtual void 						cancelBubble(const bool& cancelBubble) 					{ _cancelBubble = cancelBubble; }			// setter
	
	// undefined stopImmediatePropagation();
	void stopImmediatePropagation() { // https://dom.spec.whatwg.org/#dom-event-stopimmediatepropagation
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// readonly attribute boolean bubbles;
	bool _bubbles = false;
	virtual const bool& 				bubbles()												{ return _bubbles; }						// getter
	virtual void 						bubbles(const bool& bubbles) 							{ _bubbles = bubbles; }						// setter
	
	// readonly attribute boolean cancelable;
	bool _cancelable = false; // https://dom.spec.whatwg.org/#dom-event-cancelable
	virtual const bool& 				cancelable()											{ return _cancelable; }						// getter
	virtual void 						cancelable(const bool& cancelable) 						{ _cancelable = cancelable; }				// setter
	
	// attribute boolean returnValue;  // legacy
	bool _returnValue = false; // https://dom.spec.whatwg.org/#dom-event-returnvalue
	virtual const bool& 				returnValue()											{ return _returnValue; }					// getter
	virtual void 						returnValue(const bool& returnValue) 					{ _returnValue = returnValue; }				// setter
	
	// undefined preventDefault();
	void preventDefault() { // https://dom.spec.whatwg.org/#dom-event-preventdefault
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// readonly attribute boolean defaultPrevented;
	bool _defaultPrevented = false; // https://dom.spec.whatwg.org/#dom-event-defaultprevented
	virtual const bool& 				defaultPrevented()										{ return _defaultPrevented; }				// getter
	virtual void 						defaultPrevented(const bool& defaultPrevented) 			{ _defaultPrevented = defaultPrevented; }	// setter
	
	// readonly attribute boolean composed;
	bool _composed = false; // https://dom.spec.whatwg.org/#dom-event-composed
	virtual const bool& 				composed()												{ return _composed; }						// getter
	virtual void 						composed(const bool& composed) 							{ _composed = composed; }					// setter
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	bool _isTrusted = false; // https://dom.spec.whatwg.org/#dom-event-istrusted
	virtual const bool& 				isTrusted()												{ return _isTrusted; }						// getter
	virtual void 						isTrusted(const bool& isTrusted) 						{ _isTrusted = isTrusted; }					// setter
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	DOMHighResTimeStamp _timeStamp = 0; // https://dom.spec.whatwg.org/#dom-event-timestamp
	virtual const DOMHighResTimeStamp& 	timeStamp()												{ return _timeStamp; }						// getter
	virtual void 				 		timeStamp(const DOMHighResTimeStamp& timeStamp) 		{ _timeStamp = timeStamp; }					// setter
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	void initEvent(DOMString& type, bool& bubbles, bool& cancelable) { // https://dom.spec.whatwg.org/#dom-event-initevent
		DKDEBUGFUNC(type, bubbles, cancelable);
		DKTODO();
	}
	
	
	////// DK properties //////
	DKString _eventInitDict = "{}";
};


#endif //DKEvent_H