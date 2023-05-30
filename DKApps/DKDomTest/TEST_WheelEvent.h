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
		DKConsole::log("\n////// TEST_WheelEvent.h //////");
		
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
		
	#if !EMSCRIPTEN
		// DeltaModeCode
		// const unsigned long DOM_DELTA_PIXEL = 0x00;
		DKConsole::log("wheelEvent.DOM_DELTA_PIXEL() = "+toString(wheelEvent.DOM_DELTA_PIXEL()));
		
		// const unsigned long DOM_DELTA_LINE  = 0x01;
		DKConsole::log("wheelEvent.DOM_DELTA_LINE() = "	+toString(wheelEvent.DOM_DELTA_LINE()));
		
		// const unsigned long DOM_DELTA_PAGE  = 0x02;
		DKConsole::log("wheelEvent.DOM_DELTA_PAGE() = "	+toString(wheelEvent.DOM_DELTA_PAGE()));
	#endif
		
		// readonly attribute double deltaX;
		DKConsole::log("wheelEvent.deltaX() = "			+toString(wheelEvent.deltaX()));
		
		// readonly attribute double deltaY;
		DKConsole::log("wheelEvent.deltaY() = "			+toString(wheelEvent.deltaY()));
		
		// readonly attribute double deltaZ;
		DKConsole::log("wheelEvent.deltaZ() = "			+toString(wheelEvent.deltaZ()));
		
		// readonly attribute unsigned long deltaMode;
		DKConsole::log("wheelEvent.deltaMode() = "		+toString(wheelEvent.deltaMode()));
		
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(wheelEvent));	//TODO: try to remove the need for dynamic_cast
	}

	static bool onWheelEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKConsole::log("TEST_WheelEvent::onWheelEvent()");
		printWheelEventProperties(dynamic_cast<DKWheelEvent&>(event));					//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_WheelEvent, true);


#endif //TEST_WheelEvent_H