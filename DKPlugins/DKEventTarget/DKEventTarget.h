// [IDL] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DKInterface/DKInterface.h"
#include "DKEventListener/DKEventListener.h"
#include "DKEvent/DKEvent.h"


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
	virtual void addEventListener(const DOMString& type, DKCallback callback) {
		DKDEBUGFUNC(type, callback);
		//DKINFO("DKEventTarget::addEventListener("+type+", callback) \n");
		DKEventListener eventListener;
        eventListener.type = type;
        eventListener.callback = callback;
        eventListener.interfaceAddress = interfaceAddress;
		eventListener.dkEventTarget = this;
        eventListeners.push_back(eventListener);
		
		/// Print event list
		/*
		unsigned int i=0;
		for (auto& eventListener : eventListeners) {
			DKINFO("event["+toString(i)+"] = ("+eventListener.type+","+eventListener.interfaceAddress+") \n");
			i++;
        }
		*/
	}
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
	virtual void removeEventListener(const DOMString& type, DKCallback callback) {
		DKDEBUGFUNC(type, callback);
		//DKINFO("DKEventTarget::removeEventListener("+type+", callback) \n");
		for(auto it = eventListeners.begin(); it != eventListeners.end();){
			if(it->type == type && it->interfaceAddress == interfaceAddress) // && it->callback == callback)
				it = eventListeners.erase(it);
			else
				++it;
		}
	}
	
	// boolean dispatchEvent(Event event);
    virtual bool dispatchEvent(DKEvent& event) {
		DKDEBUGFUNC(event);
		//DKINFO("DKEventTarget::dispatchEvent("+event+") \n");	
		for (auto& eventListener : eventListeners) {
			//DKINFO("	eventObj("+eventObj.type+", "+eventObj.interfaceAddress) \n");	
			if(eventListener.type == event.type() && eventListener.interfaceAddress == interfaceAddress){
				//DKINFO("		event("+event.type()+") \n");	
			
				event.currentTarget(*this);
				event.target(*this);
				event.srcElement(*this);
				
				eventListener.callback(event);
			}
        }
		return true; 
    }
	virtual bool dispatchEvent(DKEvent* event){	return dispatchEvent(*event); }
	
	
	////// DK properties //////	
	//static std::vector<EventObject> events;
	static std::vector<DKEventListener> eventListeners;
	
	////// toString //////
	operator std::string() const { return "[object EventTarget]"; }	
};


class DKNullEventTarget : public DKEventTarget
{
public:
	operator std::string() const { return "null"; }
};


#endif //DKEventTarget_H