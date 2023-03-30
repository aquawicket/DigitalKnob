#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "CPPEventsTest/DKEvent.h"
#include "DKDuktape/DKDuktape.h"


template <typename EventType>
struct EventObject {
    DKString type;
    std::function<void(EventType)> listener;
    void* pointer;
	DKString address;
};

// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:

	////// Constructor //////
	// [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("DKEventTarget::Init() \n");
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
	static void addEventListener(const DKString& type, std::function<void(EventType)> listener, const DKString& address){
		DKDEBUGFUNC(type, listener, address);
		EventObject<EventType> eventObj;
        eventObj.type = type;
        eventObj.listener = listener;
        eventObj.address = address;
        events<EventType>.push_back(eventObj);
	}
	
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	template <typename EventType>
	static void removeEventListener(const DKString& type, std::function<void(EventType)> listener, void* pointer){
		DKDEBUGFUNC(type, listener, pointer);
		// TODO
	}
	
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	template <typename EventType>
    static void dispatchEvent(EventType event, const DKString& address){
		DKDEBUGFUNC(event, address);
        for (auto& eventObj : events<EventType>) {
			if(eventObj.type == event.type && eventObj.address == address)
				eventObj.listener(event);
        }
    }
	
	
	////// DK properties //////	
	template <typename EventType>
	static std::vector<EventObject<EventType>> events;
};

template <typename EventType>
std::vector<EventObject<EventType>> DKEventTarget::events;

REGISTER_OBJECT(DKEventTarget, false);


#endif //DKEventTarget_H