// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DKInterface/DKInterface.h"
#include "DKEvent/DKEvent.h"


////// EventListener //////
typedef std::function<void(DKEvent&)> DKEventListener;

struct EventObject {
	DKString interfaceAddress;
	DKEventTarget* dkEventTarget;
    DOMString type;
	DKEventListener callback;
};



// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKEventTarget : virtual public DKInterface
{
public:
	// constructor();
	DKEventTarget() : DKInterface() {
		DKDEBUGFUNC();
		interfaceName = "EventTarget";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKEventTarget("+interfaceAddress+") \n");
	}
	virtual ~DKEventTarget(){}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	virtual void addEventListener(const DOMString& type, DKEventListener callback) {
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
	virtual void removeEventListener(const DOMString& type, DKEventListener callback) {
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
    virtual bool dispatchEvent(DKEvent& event) {
		DKDEBUGFUNC(event);
		//DKINFO("DKEventTarget::dispatchEvent("+event+") \n");	
		for (auto& eventObj : events) {
			//DKINFO("	eventObj("+eventObj.type+", "+eventObj.interfaceAddress) \n");	
			if(eventObj.type == event.type() && eventObj.interfaceAddress == interfaceAddress){
				//DKINFO("		event("+event.type()+") \n");	
			
				event.currentTarget(*this);
				event.target(*this);
				event.srcElement(*this);
				
				eventObj.callback(event);
			}
        }
		return true; 
    }
	virtual bool dispatchEvent(DKEvent* event){	return dispatchEvent(*event); }
	
	
	////// DK properties //////	
	static std::vector<EventObject> events;
	
	////// toString //////
	virtual operator std::string() const { return "[object EventTarget]"; }	
};


class DKNullEventTarget : public DKEventTarget
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKEventTarget_H