#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "DKEventTestB/DKEvent.h"
#include "DKDuktape/DKDuktape.h"

/*
typedef std::function<bool(const DKString&, const DKString&)> AddEventListenerFunc;
typedef std::map<DKString, AddEventListenerFunc> AddEventListenerMap;

typedef std::function<bool(const DKString&, const DKString&)> RemoveEventListenerFunc;
typedef std::map<DKString, RemoveEventListenerFunc> RemoveEventListenerMap;

typedef std::function<bool(const DKString&, const DKString&)> DispatchEventFunc;
typedef std::map<DKString, DispatchEventFunc> DispatchEventMap;
*/

struct EventObject {
    DKString type;
	DKString eventTargetAddress;
    std::function<void(DKEvent*)> listener;
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
	void addEventListener(const DKString& type, std::function<void(DKEvent*)> listener){
		DKString eventTargetAddress = DKDuktape::pointerToAddress(this);
		DKDEBUGFUNC(type, listener, eventTargetAddress);
		DKINFO("DKEventTarget::addEventListener("+type+", listener, "+eventTargetAddress+") \n");
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
		DKINFO("DKEventTarget::dispatchEvent("+event->type+", "+eventTargetAddress+") \n");	
		for (auto& eventObj : events) {
			DKINFO("	eventObj("+eventObj.type+", "+eventObj.eventTargetAddress+") \n");	
			if(eventObj.type == event->type && eventObj.eventTargetAddress == eventTargetAddress){
				DKINFO("		event("+event->type+") \n");	
				event->currentTarget = eventTargetAddress;
				event->target = eventTargetAddress;
				eventObj.listener(event);
			}
        }
    }
	
	
	////// DK properties //////	
	static std::vector<EventObject> events;
	
	/*
	static AddEventListenerMap* addEventListenerMap;
	static RemoveEventListenerMap* removeEventListenerMap;
	static DispatchEventMap* dispatchEventMap;
	
	template<class T>
	static bool LinkAddEventListenerFunc(const DKString& name, bool (T::*func) (const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(name);//, func, _this);
		//DKINFO("DKEventTarget::LinkAddEventListenerFunc("+name+", func(DKString,DKString)) \n");
		if(!addEventListenerMap)
			addEventListenerMap = new AddEventListenerMap();
		(*addEventListenerMap)[name] = std::bind(func, _this, std::placeholders::_1, std::placeholders::_2);
		return true;
	}
	
	static bool CallAddEventListenerFunc(const DKString& type, const DKString& eventTargetAddress){
		DKDEBUGFUNC(type, eventTargetAddress);
		//DKINFO("DKEventTarget::CallAddEventListenerFunc("+type+", "+eventTargetAddress+") \n");
		if(!addEventListenerMap)
			return DKERROR("addEventListenerMap invalid! \n");
		if(addEventListenerMap->empty())
			return DKERROR("addEventListenerMap empty! \n");
		if(addEventListenerMap->find(type) == addEventListenerMap->end())
			return DKERROR(type+" not registered to a function! \n");
		return (*addEventListenerMap)[type](type, eventTargetAddress);
	}
	
	template<class T>
	static bool LinkRemoveEventListenerFunc(const DKString& name, bool (T::*func) (const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(name);//, func, _this);
		//DKINFO("DKEventTarget::LinkRemoveEventListenerFunc("+name+", func(DKString,DKString)) \n");
		if(!removeEventListenerMap)
			removeEventListenerMap = new RemoveEventListenerMap();
		(*removeEventListenerMap)[name] = std::bind(func, _this, std::placeholders::_1, std::placeholders::_2);
		return true;
	}
	
	static bool CallRemoveEventListenerFunc(const DKString& type, const DKString& eventTargetAddress){
		DKDEBUGFUNC(type, eventTargetAddress);
		//DKINFO("DKEventTarget::CallRemoveEventListenerFunc("+type+", "+eventTargetAddress+") \n");
		if(!removeEventListenerMap)
			return DKERROR("removeEventListenerMap invalid! \n");
		if(removeEventListenerMap->empty())
			return DKERROR("removeEventListenerMap empty! \n");
		if(removeEventListenerMap->find(type) == removeEventListenerMap->end())
			return DKERROR(type+" not registered to a function! \n");
		return (*removeEventListenerMap)[type](type, eventTargetAddress);
	}
	
	template<class T>
	static bool LinkDispatchEventFunc(const DKString& name, bool (T::*func) (const DKString&, const DKString&), T* _this){
		DKDEBUGFUNC(name);//, func, _this);
		//DKINFO("DKEventTarget::LinkDispatchEventFunc("+name+", func(DKString,DKString)) \n");
		if(!dispatchEventMap)
			dispatchEventMap = new DispatchEventMap();
		(*dispatchEventMap)[name] = std::bind(func, _this, std::placeholders::_1, std::placeholders::_2);
		return true;
	}
	static bool CallDispatchEventFunc(const DKString& eventAddress, const DKString& eventTargetAddress){
		DKDEBUGFUNC(eventAddress, eventTargetAddress);
		//DKINFO("DKEventTarget::CallDispatchEventFunc("+eventAddress+", "+eventTargetAddress+") \n");
		if(!dispatchEventMap)
			return DKERROR("dispatchEventMap invalid! \n");
		if(dispatchEventMap->empty())
			return DKERROR("dispatchEventMap empty! \n");
		if(dispatchEventMap->find(eventAddress) == dispatchEventMap->end())
			return DKERROR(eventAddress+" not registered to a function! \n");
		return (*dispatchEventMap)[eventAddress](eventAddress, eventTargetAddress);
	}
	*/
};




REGISTER_OBJECT(DKEventTarget, true);


#endif //DKEventTarget_H