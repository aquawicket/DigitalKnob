// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/EventTarget.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "DKEvent/DKEvent.h"

struct EventObject {
    DKString type;
	DKString interfaceAddress;
    std::function<void(DKEvent&)> listener;
};


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKEventTarget
{
public:

	// constructor();
	DKEventTarget() { // [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
		DKDEBUGFUNC();
		interfaceName = "EventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKEventTarget("+interfaceAddress+") \n");
	}
	virtual ~DKEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	void addEventListener(const DKString& type, std::function<void(DKEvent&)> listener){ // [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
		DKDEBUGFUNC(type, listener);
		//DKINFO("DKEventTarget::addEventListener("+type+", listener) \n");
		EventObject eventObj;
        eventObj.type = type;
        eventObj.listener = listener;
        eventObj.interfaceAddress = interfaceAddress;
        events.push_back(eventObj);
		
		/// Print event list
		/*
		unsigned int i=0;
		for (auto& eventObj : events) {
			DKINFO("event["+toString(i)+"] = ("+eventObj.type+","+eventObj.interfaceAddress+") \n");
			i++;
        }
		*/
	}
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	void removeEventListener(const DKString& type, std::function<void(DKEvent&)> listener){ // [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
		DKDEBUGFUNC(type, listener);
		//DKINFO("DKEventTarget::removeEventListener("+type+", listener) \n");
		for(auto it = events.begin(); it != events.end();){
			if(it->type == type && it->interfaceAddress == interfaceAddress) // && it->listener == listener)
				it = events.erase(it);
			else
				++it;
		}
	}
	
	// boolean dispatchEvent(Event event);
    void dispatchEvent(DKEvent& event){	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
		DKDEBUGFUNC(event);
		//DKINFO("DKEventTarget::dispatchEvent("+event+") \n");	
		for (auto& eventObj : events) {
			//DKINFO("	eventObj("+eventObj.type+", "+eventObj.interfaceAddress) \n");	
			if(eventObj.type == event.type && eventObj.interfaceAddress == interfaceAddress){
				//DKINFO("		event("+event.type+") \n");	
				event.currentTarget = interfaceAddress;
				event.target = interfaceAddress;
				eventObj.listener(event);
			}
        }
    }
	void dispatchEvent(DKEvent* event){	dispatchEvent(*event); }
	
	
	////// DK properties //////	
	static std::vector<EventObject> events;
	DKString interfaceName = "";
	DKString interfaceAddress = "";
};


#endif //DKEventTarget_H