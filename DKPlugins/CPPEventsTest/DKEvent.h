#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DK/DK.h"


// https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEvent
{
public:
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	/*
	DKEvent(DKString _type, DKString _options, void* _pointer){
		bubbles = false;
		cancelable = false;
		composed = false;
		currentTarget = _pointer;
		defaultPrevented = false;
		eventPhase = 0;
		isTrusted = false;
		target = _pointer;
		timeStamp = 0;
		type = _type;
		
		options = _options;
		pointer = _pointer;
		//targetAddress = _targetAddress;
		//currentTargetAddress = _targetAddress;
	}
	DKEvent(DKString _type, DKString _options, DKString _targetAddress){
		bubbles = false;
		cancelable = false;
		composed = false;
		//currentTarget = _pointer;
		defaultPrevented = false;
		eventPhase = 0;
		isTrusted = false;
		//target = _pointer;
		timeStamp = 0;
		type = _type;
		
		options = _options;
		//pointer = _pointer;
		targetAddress = _targetAddress;
		currentTargetAddress = _targetAddress;
	}
	*/
	DKEvent(DKString _type, DKString _options){
		bubbles = false;
		cancelable = false;
		composed = false;
		//currentTarget = _pointer;
		defaultPrevented = false;
		eventPhase = 0;
		isTrusted = false;
		//target = _pointer;
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
	void* currentTarget;
	// [Event.defaultPrevented](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/defaultPrevented
	bool defaultPrevented;
	// [Event.eventPhase](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/eventPhase
	int eventPhase;
	// [Event.isTrusted](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/isTrusted
	bool isTrusted;
	// [Event.target](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/target
	void* target;
	// [Event.timeStamp](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/timeStamp
	unsigned long timeStamp;
	// [Event.type](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/type
	DKString type;
	
	
	////// Legacy and non-standard properties //////
	// [Event.cancelBubble](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/cancelBubble
	// TODO
	// [Event.explicitOriginalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitOriginalTarget
	// TODO
	// [Event.originalTarget](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Event/explicitTarget
	// TODO
	// [Event.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/returnValue
	// TODO
	// [Event.scoped](Read only)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Event/scoped
	// TODO
	
	
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
	
	
	////// DK properties //////
	DKString options;
	void* pointer;
	DKString targetAddress;
	DKString currentTargetAddress;
};


#endif //DKEvent_H