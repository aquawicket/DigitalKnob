#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "CPPEventsTest/DKEvent.h"
#include "CPPEventsTest/DKKeyboardEvent.h"


struct Event {
	DKString type;
	std::function<bool(DKEvent)> listener;
	void* pointer;
};


// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:

	////// Constructor //////
	// [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
	bool Init();
	bool End();


	////// Instance methods //////
	// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	static void addEventListener(const DKString& type, std::function<bool(DKEvent)> listener, void* pointer){
		DKDEBUGFUNC(type, listener, pointer);
		Event event;
		event.type = type;
		event.listener = listener;
		event.pointer = pointer;
		events.push_back(event);
	}
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	static void removeEventListener(const DKString& type, std::function<bool(DKEvent)> listener, void* pointer){
		DKDEBUGFUNC(type, listener, pointer);
		// TODO
	}
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	static void dispatchEvent(DKEvent event){
		DKDEBUGFUNC(event);
		for (unsigned int n = 0; n < events.size(); ++n) {
			if (event.type == events[n].type && event.pointer == events[n].pointer) {
				events[n].listener(event);
			}
		}
	}
	
	
	////// DK properties //////
	static std::vector<Event> events;
};
REGISTER_OBJECT(DKEventTarget, false);


#endif //DKEventTarget_H