#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"


typedef std::function<bool(const DKString&, const DKString&)> AddEventListenerFunc;
typedef std::map<DKString, AddEventListenerFunc> AddEventListenerMap;

typedef std::function<bool(const DKString&, const DKString&)> RemoveEventListenerFunc;
typedef std::map<DKString, RemoveEventListenerFunc> RemoveEventListenerMap;

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
		//DKINFO("DKEventTarget.h: addEventListener("+type+", listener, "+eventTargetAddress+") \n");
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
		//DKINFO("DKEventTarget.h: removeEventListener("+type+", listener, "+eventTargetAddress+") \n");
		for(auto it = events<EventType>.begin(); it != events<EventType>.end();){
			if(it->type == type && it->eventTargetAddress == eventTargetAddress) // && it->listener == listener)
				it = events<EventType>.erase(it);
			else
				++it;
		}
	}
	
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	template <typename EventType>
    static void dispatchEvent(EventType* event, const DKString& eventTargetAddress){
		DKDEBUGFUNC(event, eventTargetAddress);
		//DKINFO("DKEventTarget.h: dispatchEvent("+event->type+", "+eventTargetAddress+") \n");	
		for (auto& eventObj : events<EventType>) {
			//DKINFO("event("+eventObj.type+", "+eventObj.eventTargetAddress+") \n");	
			if(eventObj.type == event->type && eventObj.eventTargetAddress == eventTargetAddress){
				event->currentTarget = eventTargetAddress;
				event->target = eventTargetAddress;
				eventObj.listener(event);
			}
        }
    }
	
	
	////// DK properties //////	
	template <typename EventType>
	static std::vector<EventObject<EventType>> events;
	
	static AddEventListenerMap* addEventListenerMap;
	static RemoveEventListenerMap* removeEventListenerMap;
	
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
};

template <typename EventType>
std::vector<EventObject<EventType>> DKEventTarget::events;


REGISTER_OBJECT(DKEventTarget, true);


#endif //DKEventTarget_H