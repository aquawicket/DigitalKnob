#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"
#include "CPPEventsTest/DKEvent.h"

struct Event { // This structure is named "event"
  DKString type;
  std::function<bool()> listener;
  void* pointer;
};


// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:
	bool Init();
	bool End();

	////// Instance methods //////
	static void addEventListener(const DKString& type, std::function<bool()> listener, void* pointer);		// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	static void removeEventListener(const DKString& type, std::function<bool()> listener, void* pointer);	// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	static void dispatchEvent(DKEvent event);																// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	
	static std::vector<Event> events;
};
REGISTER_OBJECT(DKEventTarget, false);


#endif //DKEventTarget_H