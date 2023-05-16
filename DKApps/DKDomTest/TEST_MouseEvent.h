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
		DKINFO("mouseEvent.altKey = "			+toString(mouseEvent.altKey)		+"\n");
		DKINFO("mouseEvent.button = "			+toString(mouseEvent.button)		+"\n");
		DKINFO("mouseEvent.buttons = "			+toString(mouseEvent.buttons)		+"\n");
		DKINFO("mouseEvent.clientX = "			+toString(mouseEvent.clientX)		+"\n");
		DKINFO("mouseEvent.clientY = "			+toString(mouseEvent.clientY)		+"\n");
		DKINFO("mouseEvent.ctrlKey = "			+toString(mouseEvent.ctrlKey)		+"\n");
		DKINFO("mouseEvent.metaKey = "			+toString(mouseEvent.metaKey)		+"\n");
		DKINFO("mouseEvent.movementX = "		+toString(mouseEvent.movementX)		+"\n");
		DKINFO("mouseEvent.movementY = "		+toString(mouseEvent.movementY)		+"\n");
		DKINFO("mouseEvent.offsetX = "			+toString(mouseEvent.offsetX)		+"\n");
		DKINFO("mouseEvent.offsetY = "			+toString(mouseEvent.offsetY)		+"\n");
		DKINFO("mouseEvent.pageX = "			+toString(mouseEvent.pageX)			+"\n");
		DKINFO("mouseEvent.pageY = "			+toString(mouseEvent.pageY)			+"\n");
		DKINFO("mouseEvent.relatedTarget = "	+toString(mouseEvent.relatedTarget)	+"\n");
		DKINFO("mouseEvent.screenX = "			+toString(mouseEvent.screenX)		+"\n");
		DKINFO("mouseEvent.screenY = "			+toString(mouseEvent.screenY)		+"\n");
		DKINFO("mouseEvent.shiftKey = "			+toString(mouseEvent.shiftKey)		+"\n");
		DKINFO("mouseEvent.x = "				+toString(mouseEvent.x)				+"\n");
		DKINFO("mouseEvent.y = "				+toString(mouseEvent.y)				+"\n");
	}

	static bool onMouseEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_MouseEvent::onMouseEvent() \n");
		printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H