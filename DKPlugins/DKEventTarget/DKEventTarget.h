// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DKInterface/DKInterface.h"
#include "DKEvent/DKEvent.h"


////// EventListener //////
typedef std::function<void(DKEvent*)> DKEventListener;

struct EventObject {
	DKString interfaceAddress;
	DKEventTarget* dkEventTarget;
    DOMString type;
	DKEventListener callback;
};



// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKEventTarget : public DKInterface
{
public:
	//operator std::string() const { return "Object EventTarget"; }
	
	// constructor();
	DKEventTarget() : DKInterface() { // https://dom.spec.whatwg.org/#dom-eventtarget-eventtarget
		DKDEBUGFUNC();
		interfaceName = "EventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKEventTarget("+interfaceAddress+") \n");
	}
	virtual ~DKEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	void addEventListener(const DOMString& type, DKEventListener callback){ // https://dom.spec.whatwg.org/#dom-eventtarget-addeventlistener
		DKDEBUGFUNC(type, callback);
		//DKINFO("DKEventTarget::addEventListener("+type+", callback) \n");
		EventObject eventObj;
        eventObj.type = type;
        eventObj.callback = callback;
        eventObj.interfaceAddress = interfaceAddress;
		eventObj.dkEventTarget = this;
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
	void removeEventListener(const DOMString& type, DKEventListener callback){ // https://dom.spec.whatwg.org/#dom-eventtarget-removeeventlistener
		DKDEBUGFUNC(type, callback);
		//DKINFO("DKEventTarget::removeEventListener("+type+", callback) \n");
		for(auto it = events.begin(); it != events.end();){
			if(it->type == type && it->interfaceAddress == interfaceAddress) // && it->callback == callback)
				it = events.erase(it);
			else
				++it;
		}
	}
	
	// boolean dispatchEvent(Event event);
    bool dispatchEvent(DKEvent* event){	// https://dom.spec.whatwg.org/#dom-eventtarget-dispatchevent
		DKDEBUGFUNC(event);
		if(!event)
			return DKERROR("event invalid! \n");
			
		//DKINFO("DKEventTarget::dispatchEvent("+event+") \n");	
		for (auto& eventObj : events) {
			//DKINFO("	eventObj("+eventObj.type+", "+eventObj.interfaceAddress) \n");	
			if(eventObj.type == event->type() && eventObj.interfaceAddress == interfaceAddress){
				//DKINFO("		event("+event.type()+") \n");	
				
				//event.currentTarget = interfaceAddress;
				event->currentTarget(this);
				
				//event.target = interfaceAddress;
				event->target(this);
				event->srcElement(this);
				//event.target = (DKEventTarget*)addressToPointer(interfaceAddress);
				
				eventObj.callback(event);
			}
        }
		return true; 
    }
	//bool dispatchEvent(DKEvent* event){	return dispatchEvent(*event); }
	
	
	////// DK properties //////	
	static std::vector<EventObject> events;
};


#endif //DKEventTarget_H