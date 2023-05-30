// [IDL] https://w3c.github.io/uievents/#idl-mouseevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef TEST_MouseEvent_H
#define TEST_MouseEvent_H

#include "DKMouseEvent/DKMouseEvent.h"


class TEST_MouseEvent : public DKObjectT<TEST_MouseEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_MouseEvent.h //////");
		
		DKEventTarget eventTarget;
		eventTarget.addEventListener("mouseEvent", &TEST_MouseEvent::onMouseEvent);
		DKMouseEvent mouseEvent("mouseEvent", "");
		eventTarget.dispatchEvent(mouseEvent);
		return true;	
	}

	static void printMouseEventProperties(DKMouseEvent& mouseEvent){
		DKDEBUGFUNC(mouseEvent);
		
		// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
		// function
		
		// readonly attribute long screenX;
		DKConsole::log("mouseEvent.screenX() = "		+toString(mouseEvent.screenX()));
		
		// readonly attribute long screenY;
		DKConsole::log("mouseEvent.screenY() = "		+toString(mouseEvent.screenY()));
		
		// readonly attribute long clientX;
		DKConsole::log("mouseEvent.clientX() = "		+toString(mouseEvent.clientX()));
		
		// readonly attribute long clientY;
		DKConsole::log("mouseEvent.clientY() = "		+toString(mouseEvent.clientY()));
		
		// readonly attribute boolean ctrlKey;
		DKConsole::log("mouseEvent.ctrlKey() = "		+toString(mouseEvent.ctrlKey()));
		
		// readonly attribute boolean shiftKey;
		DKConsole::log("mouseEvent.shiftKey() = "		+toString(mouseEvent.shiftKey()));
		
		// readonly attribute boolean altKey;
		DKConsole::log("mouseEvent.altKey() = "			+toString(mouseEvent.altKey()));
		
		// readonly attribute boolean metaKey;
		DKConsole::log("mouseEvent.metaKey() = "		+toString(mouseEvent.metaKey()));
		
		// readonly attribute short button;
		DKConsole::log("mouseEvent.button() = "			+toString(mouseEvent.button()));
		
		// readonly attribute unsigned short buttons;		
		DKConsole::log("mouseEvent.buttons() = "		+toString(mouseEvent.buttons()));
		
		// readonly attribute EventTarget? relatedTarget;
		DKConsole::log("mouseEvent.relatedTarget() = "	+toString(mouseEvent.relatedTarget()));
		
		// boolean getModifierState(DOMString keyArg);
		// function
		
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface MouseEvent {
		//  	readonly attribute double pageX;
				DKConsole::log("mouseEvent.pageX() = "			+toString(mouseEvent.pageX()));
		//  	readonly attribute double pageY;
				DKConsole::log("mouseEvent.pageY() = "			+toString(mouseEvent.pageY()));
		//  	readonly attribute double x;
				DKConsole::log("mouseEvent.x() = "				+toString(mouseEvent.x()));
		//  	readonly attribute double y;
				DKConsole::log("mouseEvent.y() = "				+toString(mouseEvent.y()));
		//  	readonly attribute double offsetX; 
				DKConsole::log("mouseEvent.offsetX() = "		+toString(mouseEvent.offsetX()));
		//  	readonly attribute double offsetY;
				DKConsole::log("mouseEvent.offsetY() = "		+toString(mouseEvent.offsetY()));
		// };
	
		// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
		// partial interface MouseEvent {
		//   	readonly attribute double movementX;
				DKConsole::log("mouseEvent.movementX() = "		+toString(mouseEvent.movementX()));
		//   	readonly attribute double movementY;
				DKConsole::log("mouseEvent.movementY() = "		+toString(mouseEvent.movementY()));
		// };
	
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface MouseEvent {
		//		Deprecated in this specification
		//	  	undefined initMouseEvent(DOMString typeArg,
		//		optional boolean bubblesArg = false,
		//		optional boolean cancelableArg = false,
		//		optional Window? viewArg = null,
		//		optional long detailArg = 0,
		//		optional long screenXArg = 0,
		//		optional long screenYArg = 0,
		//		optional long clientXArg = 0,
		//		optional long clientYArg = 0,
		//		optional boolean ctrlKeyArg = false,
		//		optional boolean altKeyArg = false,
		//		optional boolean shiftKeyArg = false,
		//		optional boolean metaKeyArg = false,
		//		optional short buttonArg = 0,
		//		optional EventTarget? relatedTargetArg = null);
				// function
		// };
		
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(mouseEvent));	//TODO: try to remove the need for dynamic_cast
	}

	static bool onMouseEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKConsole::log("TEST_MouseEvent::onMouseEvent()");
		printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H