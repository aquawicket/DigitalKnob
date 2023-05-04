// [IDL] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef TEST_WheelEvent_H
#define TEST_WheelEvent_H

#include "DK/DK.h"
#include "DKWheelEvent/DKWheelEvent.h"


class TEST_WheelEvent : public DKObjectT<TEST_WheelEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_WheelEvent.h ////// \n");
		
		DKINFO("\n");
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("wheelevent", &TEST_WheelEvent::onwheelevent);
		DKWheelEvent wheelevent("wheelevent", "");
		myEventTarget.dispatchEvent(wheelevent);
		return true;
	}

	static void printWheelEventProperties(DKWheelEvent& wheelevent){
		DKDEBUGFUNC(wheelevent);
		////// Instance properties //////
		DKINFO("wheelevent.deltaX = "		+toSring(wheelevent.deltaX)		+"\n");
		DKINFO("wheelevent.deltaY = "		+toSring(wheelevent.deltaY)		+"\n");
		DKINFO("wheelevent.deltaZ = "		+toSring(wheelevent.deltaZ)		+"\n");
		DKINFO("wheelevent.deltaMode = "	+toSring(wheelevent.deltaMode)	+"\n");
		DKINFO("wheelevent.wheelDelta = "	+toSring(wheelevent.wheelDelta)	+"\n");
		DKINFO("wheelevent.wheelDeltaX = "	+toSring(wheelevent.wheelDeltaX)+"\n");
		DKINFO("wheelevent.wheelDeltaY = "	+toSring(wheelevent.wheelDeltaY)+"\n");
	}

	static bool onwheelevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_WheelEvent::onwheelevent() \n");
		printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));					//TODO: try to remove the need for dynamic_cast
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_WheelEvent, true);


#endif //TEST_WheelEvent_H