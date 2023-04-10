#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "DKEventTargetTest/DKEvent.h"
#include "DKDuktape/DKDuktape.h"


struct EventObject {
    DKString type;
	DKString eventTargetAddress;
    std::function<void(DKEvent*)> listener;
};


// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget// : public DKObjectT<DKEventTarget>
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
		//DKINFO("DKEventTarget::End() \n");
		return true;
	}


	////// Instance methods //////
	// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	void addEventListener(const DKString& type, std::function<void(DKEvent*)> listener){
		DKString eventTargetAddress = DKDuktape::pointerToAddress(this);
		DKDEBUGFUNC(type, listener, eventTargetAddress);
		//DKINFO("DKEventTarget::addEventListener("+type+", listener, "+eventTargetAddress+") \n");
		EventObject eventObj;
        eventObj.type = type;
        eventObj.listener = listener;
        eventObj.eventTargetAddress = eventTargetAddress;
        events.push_back(eventObj);
		
		/// Print event list
		/*
		unsigned int i=0;
		for (auto& eventObj : events) {
			DKINFO("event["+toString(i)+"] = ("+eventObj.type+","+eventObj.eventTargetAddress+") \n");
			i++;
        }
		*/
	}
	
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	void removeEventListener(const DKString& type, std::function<void(DKEvent*)> listener){
		DKString eventTargetAddress = DKDuktape::pointerToAddress(this);
		DKDEBUGFUNC(type, listener, eventTargetAddress);
		//DKINFO("DKEventTarget::removeEventListener("+type+", listener, "+eventTargetAddress+") \n");
		for(auto it = events.begin(); it != events.end();){
			if(it->type == type && it->eventTargetAddress == eventTargetAddress) // && it->listener == listener)
				it = events.erase(it);
			else
				++it;
		}
	}
	
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
    void dispatchEvent(DKEvent* event){
		DKString eventTargetAddress = DKDuktape::pointerToAddress(this);
		DKDEBUGFUNC(event, eventTargetAddress);
		//DKINFO("DKEventTarget::dispatchEvent("+event->type+", "+eventTargetAddress+") \n");	
		for (auto& eventObj : events) {
			//DKINFO("	eventObj("+eventObj.type+", "+eventObj.eventTargetAddress+") \n");	
			if(eventObj.type == event->type && eventObj.eventTargetAddress == eventTargetAddress){
				//DKINFO("		event("+event->type+") \n");	
				event->currentTarget = eventTargetAddress;
				event->target = eventTargetAddress;
				eventObj.listener(event);
			}
        }
    }
	
	
	////// DK properties //////	
	static std::vector<EventObject> events;

};


#endif //DKEventTarget_H