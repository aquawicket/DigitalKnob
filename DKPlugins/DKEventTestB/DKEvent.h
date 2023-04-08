#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DK/DK.h"
#include "DKEventTest/DKEventTarget.h"


// [INTERFACE] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEvent
{
public:
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	DKEvent(DKString _type, DKString _options){
		
		////// Instance properties //////
		bubbles = false;
		cancelable = false;
		composed = false;
		currentTarget = "";
		defaultPrevented = false;
		eventPhase = 0;
		isTrusted = false;
		target = "";
		timeStamp = 0;
		type = _type;
		
		////// Legacy and non-standard properties //////
		cancelBubble = false;
		explicitOriginalTarget = "";
		originalTarget = "";
		returnValue = false;
		scoped = false;
		
		////// DK properties //////
		options = _options; // TODO
	}
	
	
	////// Instance properties //////
	// [Event.bubbles](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/bubbles
	bool bubbles;
	// [Event.cancelable](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelable
	bool cancelable;
	// [Event.composed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
	bool composed;
	// [Event.currentTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/currentTarget
	DKString currentTarget;
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	bool defaultPrevented;
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	int eventPhase;
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	bool isTrusted;
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	DKString target;
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	unsigned long timeStamp;
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	DKString type;
	
	
	////// Legacy and non-standard properties //////
	// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
	bool cancelBubble;
	// [Event.explicitOriginalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	DKString explicitOriginalTarget;
	// [Event.originalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/originalTarget
	DKString originalTarget;
	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	bool returnValue;
	// [Event.scoped](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/scoped
	bool scoped;
	
	
	////// Instance methods //////
	// [Event.composedPath()] https://developer.mozilla.org/en-US/docs/Web/API/Event/composedPath
	void composedPath() {
		DKTODO();
	}
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	void preventDefault() {
		DKTODO();
	}
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	void stopImmediatePropagation() {
		DKTODO();
	}
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	void stopPropagation() {
		DKTODO();
	}


	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	void initEvent() {
		DKDEPRECATED();
	}
	
	
	////// Events //////
	// [afterscriptexecute] https://developer.mozilla.org/en-US/docs/Web/API/Element/afterscriptexecute_event
	// [beforematch] https://developer.mozilla.org/en-US/docs/Web/API/Element/beforematch_event
	// [beforescriptexecute] https://developer.mozilla.org/en-US/docs/Web/API/Element/beforescriptexecute_event
	// [error] https://developer.mozilla.org/en-US/docs/Web/API/Element/error_event
	// [fullscreenchange] https://developer.mozilla.org/en-US/docs/Web/API/Element/fullscreenchange_event
	// [fullscreenerror] https://developer.mozilla.org/en-US/docs/Web/API/Element/fullscreenerror_event
	// [scroll] https://developer.mozilla.org/en-US/docs/Web/API/Element/scroll_event
	// [scrollend] https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollend_event
	
	
	////// DK properties //////
	DKString options;
};


#endif //DKEvent_H