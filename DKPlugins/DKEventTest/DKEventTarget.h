#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "DKEventTest/DKEvent.h"
#include "DKDuktape/DKDuktape.h"


template <typename EventType>
struct EventObject {
    DKString type;
    std::function<void(EventType*)> listener;
	DKString eventTargetAddress;
};

// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:

	////// Constructor //////
	// [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
	bool Init(){
		DKDEBUGFUNC();
		//DKINFO("DKEventTarget::Init() \n");
		return true;
	}
	bool End(){
		DKDEBUGFUNC();
		DKINFO("DKEventTarget::End() \n");
		return true;
	}


	////// Instance methods //////
	// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	template <typename EventType>
	static void addEventListener(const DKString& type, std::function<void(EventType*)> listener, const DKString& eventTargetAddress){
		DKDEBUGFUNC(type, listener, eventTargetAddress);
		DKINFO("DKEventTarget.h: addEventListener("+type+", listener, "+eventTargetAddress+") \n");
		EventObject<EventType> eventObj;
        eventObj.type = type;
        eventObj.listener = listener;
        eventObj.eventTargetAddress = eventTargetAddress;
        events<EventType>.push_back(eventObj);
		
		/// Print event list
		/*
		unsigned int i=0;
		for (auto& eventObj : events<EventType>) {
			DKINFO("event["+toString(i)+"] = ("+eventObj.type+","+eventObj.eventTargetAddress+") \n");
			i++;
        }
		*/
	}
	
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	template <typename EventType>
	static void removeEventListener(const DKString& type, std::function<void(EventType*)> listener, const DKString& eventTargetAddress){
		DKDEBUGFUNC(type, listener, eventTargetAddress);
		DKINFO("DKEventTarget.h: removeEventListener("+type+", listener, "+eventTargetAddress+") \n");
		DKTODO();
	}
	
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	template <typename EventType>
    static void dispatchEvent(EventType* event, const DKString& eventTargetAddress){
		DKDEBUGFUNC(event, eventTargetAddress);
		DKINFO("DKEventTarget.h: dispatchEvent("+event->type+", "+eventTargetAddress+") \n");	
        for (auto& eventObj : events<EventType>) {
			//DKINFO("event("+eventObj.type+", "+eventObj.eventTargetAddress+") \n");	
			if(eventObj.type == event->type && eventObj.eventTargetAddress == eventTargetAddress)
				eventObj.listener(event);
        }
    }
	
	
	////// DK properties //////	
	template <typename EventType>
	static std::vector<EventObject<EventType>> events;
};

template <typename EventType>
std::vector<EventObject<EventType>> DKEventTarget::events;


REGISTER_OBJECT(DKEventTarget, true);


#endif //DKEventTarget_H