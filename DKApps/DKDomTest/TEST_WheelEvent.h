// [IDL] https://w3c.github.io/uievents/#idl-wheelevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef TEST_WheelEvent_H
#define TEST_WheelEvent_H

//#include "DK/DK.h"
#include "DKWheelEvent/DKWheelEvent.h"


class TEST_WheelEvent : public DKObjectT<TEST_WheelEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_WheelEvent.h //////\n");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("wheelEvent", &TEST_WheelEvent::onWheelEvent);
		DKWheelEvent wheelEvent("wheelEvent", "");
		eventTarget.dispatchEvent(wheelEvent);
		return true;
	}

	static void printWheelEventProperties(DKWheelEvent& wheelEvent){
		DKDEBUGFUNC(wheelEvent);
		DKINFO("wheelEvent.deltaX = "		+toString(wheelEvent.deltaX)		+"\n");
		DKINFO("wheelEvent.deltaY = "		+toString(wheelEvent.deltaY)		+"\n");
		DKINFO("wheelEvent.deltaZ = "		+toString(wheelEvent.deltaZ)		+"\n");
		DKINFO("wheelEvent.deltaMode = "	+toString(wheelEvent.deltaMode)		+"\n");
	}

	static bool onWheelEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_WheelEvent::onWheelEvent() \n");
		printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));					//TODO: try to remove the need for dynamic_cast
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_WheelEvent, true);


#endif //TEST_WheelEvent_H