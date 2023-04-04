#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DK/DK.h"
#include "DKEventTest/DKEventTarget.h"


// https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEvent
{
public:
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	DKEvent(DKString _type, DKString _options){
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
		
		options = _options;
		//pointer = _pointer;
		//targetAddress = _targetAddress;
		//currentTargetAddress = _targetAddress;
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
	// TODO
	// [Event.preventDefault()] https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault
	// TODO
	// [Event.stopImmediatePropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopImmediatePropagation
	// TODO
	// [Event.stopPropagation()] https://developer.mozilla.org/en-US/docs/Web/API/Event/stopPropagation
	// TODO


	////// Deprecated methods //////
	// [Event.initEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/initEvent
	// TODO
	
	
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
	//void* pointer;
	//DKString targetAddress;
	//DKString currentTargetAddress;
};


#endif //DKEvent_H