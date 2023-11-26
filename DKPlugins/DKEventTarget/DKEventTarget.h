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
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
	virtual void addEventListener(const DOMString& type, DKCallback callback) {
		DKDEBUGFUNC(type, callback);
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
		for(auto it = eventListeners.begin(); it != eventListeners.end();){
			if(it->type == type && it->interfaceAddress == interfaceAddress) // && it->callback == callback)
				it = eventListeners.erase(it);
			else
				++it;
		}
	}
	
	// boolean dispatchEvent(Event event);
    virtual bool dispatchEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		for (auto& eventListener : eventListeners) {
			if(eventListener.type == event->type() && eventListener.interfaceAddress == interfaceAddress){
				event->currentTarget(this);
				event->target(this);
				event->srcElement(this);
				eventListener.callback(event);
			}
        }
		return true; 
    }
	
	////// DK properties //////	
	static std::vector<DKEventListener> eventListeners;
};

#endif //DKEventTarget_H