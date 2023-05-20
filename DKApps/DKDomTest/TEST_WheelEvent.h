// [IDL] https://w3c.github.io/uievents/#idl-wheelevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef TEST_WheelEvent_H
#define TEST_WheelEvent_H

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
		
		// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
		// function
		
	#if (!EMSCRIPTEN)
		// DeltaModeCode
		// const unsigned long DOM_DELTA_PIXEL = 0x00;
		DKINFO("wheelEvent.DOM_DELTA_PIXEL() = "+toString(wheelEvent.DOM_DELTA_PIXEL())	+"\n");
		
		// const unsigned long DOM_DELTA_LINE  = 0x01;
		DKINFO("wheelEvent.DOM_DELTA_LINE() = "	+toString(wheelEvent.DOM_DELTA_LINE())	+"\n");
		
		// const unsigned long DOM_DELTA_PAGE  = 0x02;
		DKINFO("wheelEvent.DOM_DELTA_PAGE() = "	+toString(wheelEvent.DOM_DELTA_PAGE())	+"\n");
	#endif
		
		// readonly attribute double deltaX;
		DKINFO("wheelEvent.deltaX() = "			+toString(wheelEvent.deltaX())			+"\n");
		
		// readonly attribute double deltaY;
		DKINFO("wheelEvent.deltaY() = "			+toString(wheelEvent.deltaY())			+"\n");
		
		// readonly attribute double deltaZ;
		DKINFO("wheelEvent.deltaZ() = "			+toString(wheelEvent.deltaZ())			+"\n");
		
		// readonly attribute unsigned long deltaMode;
		DKINFO("wheelEvent.deltaMode() = "		+toString(wheelEvent.deltaMode())		+"\n");
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