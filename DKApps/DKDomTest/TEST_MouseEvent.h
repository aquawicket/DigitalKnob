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
		DKINFO("\n////// TEST_MouseEvent.h //////\n");
		
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
		DKINFO("mouseEvent.screenX() = "		+toString(mouseEvent.screenX())			+"\n");
		
		// readonly attribute long screenY;
		DKINFO("mouseEvent.screenY() = "		+toString(mouseEvent.screenY())			+"\n");
		
		// readonly attribute long clientX;
		DKINFO("mouseEvent.clientX() = "		+toString(mouseEvent.clientX())			+"\n");
		
		// readonly attribute long clientY;
		DKINFO("mouseEvent.clientY() = "		+toString(mouseEvent.clientY())			+"\n");
		
		// readonly attribute boolean ctrlKey;
		DKINFO("mouseEvent.ctrlKey() = "		+toString(mouseEvent.ctrlKey())			+"\n");
		
		// readonly attribute boolean shiftKey;
		DKINFO("mouseEvent.shiftKey() = "		+toString(mouseEvent.shiftKey())		+"\n");
		
		// readonly attribute boolean altKey;
		DKINFO("mouseEvent.altKey() = "			+toString(mouseEvent.altKey())			+"\n");
		
		// readonly attribute boolean metaKey;
		DKINFO("mouseEvent.metaKey() = "		+toString(mouseEvent.metaKey())			+"\n");
		
		// readonly attribute short button;
		DKINFO("mouseEvent.button() = "			+toString(mouseEvent.button())			+"\n");
		
		// readonly attribute unsigned short buttons;		
		DKINFO("mouseEvent.buttons() = "		+toString(mouseEvent.buttons())			+"\n");
		
		// readonly attribute EventTarget? relatedTarget;
		DKINFO("mouseEvent.relatedTarget() = "	+toString(mouseEvent.relatedTarget())	+"\n");
		
		// boolean getModifierState(DOMString keyArg);
		// function
		
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface MouseEvent {
		//  	readonly attribute double pageX;
				DKINFO("mouseEvent.pageX() = "			+toString(mouseEvent.pageX())		+"\n");
		//  	readonly attribute double pageY;
				DKINFO("mouseEvent.pageY() = "			+toString(mouseEvent.pageY())		+"\n");
		//  	readonly attribute double x;
				DKINFO("mouseEvent.x() = "				+toString(mouseEvent.x())			+"\n");
		//  	readonly attribute double y;
				DKINFO("mouseEvent.y() = "				+toString(mouseEvent.y())			+"\n");
		//  	readonly attribute double offsetX; 
				DKINFO("mouseEvent.offsetX() = "		+toString(mouseEvent.offsetX())		+"\n");
		//  	readonly attribute double offsetY;
				DKINFO("mouseEvent.offsetY() = "		+toString(mouseEvent.offsetY())		+"\n");
		// };
	
		// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
		// partial interface MouseEvent {
		//   	readonly attribute double movementX;
				DKINFO("mouseEvent.movementX() = "		+toString(mouseEvent.movementX())	+"\n");
		//   	readonly attribute double movementY;
				DKINFO("mouseEvent.movementY() = "		+toString(mouseEvent.movementY())	+"\n");
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
		DKINFO("TEST_MouseEvent::onMouseEvent() \n");
		printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));				//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H