// [IDL] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef TEST_MouseEvent_H
#define TEST_MouseEvent_H

#include "DK/DK.h"
#include "DKMouseEvent/DKMouseEvent.h"


class TEST_MouseEvent : public DKObjectT<TEST_MouseEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("////// TEST_MouseEvent.h ////// \n");
		
		DKINFO("\n");
		DKEventTarget myEventTarget;
		myEventTarget.addEventListener("mouseevent", &TEST_MouseEvent::onmouseevent);
		DKMouseEvent mouseevent("mouseevent", "");
		myEventTarget.dispatchEvent(mouseevent);
		return true;	
	}

	static void printMouseEventProperties(DKMouseEvent& mouseevent){
		DKDEBUGFUNC(mouseevent);
		////// Instance properties //////
		DKINFO("mouseevent.altKey = "			+toString(mouseevent.altKey)		+"\n");
		DKINFO("mouseevent.button = "			+toString(mouseevent.button)		+"\n");
		DKINFO("mouseevent.buttons = "			+toString(mouseevent.buttons)		+"\n");
		DKINFO("mouseevent.clientX = "			+toString(mouseevent.clientX)		+"\n");
		DKINFO("mouseevent.clientY = "			+toString(mouseevent.clientY)		+"\n");
		DKINFO("mouseevent.ctrlKey = "			+toString(mouseevent.ctrlKey)		+"\n");
		//DKINFO("mouseevent.layerX = "			+toString(mouseevent.layerX)		+"\n");
		//DKINFO("mouseevent.layerY = "			+toString(mouseevent.layerY)		+"\n");
		DKINFO("mouseevent.metaKey = "			+toString(mouseevent.metaKey)		+"\n");
		DKINFO("mouseevent.movementX = "		+toString(mouseevent.movementX)		+"\n");
		DKINFO("mouseevent.movementY = "		+toString(mouseevent.movementY)		+"\n");
		DKINFO("mouseevent.offsetX = "			+toString(mouseevent.offsetX)		+"\n");
		DKINFO("mouseevent.offsetY = "			+toString(mouseevent.offsetY)		+"\n");
		DKINFO("mouseevent.pageX = "			+toString(mouseevent.pageX)			+"\n");
		DKINFO("mouseevent.pageY = "			+toString(mouseevent.pageY)			+"\n");
		DKINFO("mouseevent.relatedTarget = "	+toString(mouseevent.relatedTarget)	+"\n");
		DKINFO("mouseevent.screenX = "			+toString(mouseevent.screenX)		+"\n");
		DKINFO("mouseevent.screenY = "			+toString(mouseevent.screenY)		+"\n");
		DKINFO("mouseevent.shiftKey = "			+toString(mouseevent.shiftKey)		+"\n");
		//DKINFO("mouseevent.mozPressure = "	+toString(mouseevent.mozPressure)	+"\n");
		//DKINFO("mouseevent.mozInputSource = "	+toString(mouseevent.mozInputSource)+"\n");
		//DKINFO("mouseevent.webkitForce = "	+toString(mouseevent.webkitForce)	+"\n");
		DKINFO("mouseevent.x = "				+toString(mouseevent.x)				+"\n");
		DKINFO("mouseevent.y = "				+toString(mouseevent.y)				+"\n");
	}

	static bool onmouseevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_MouseEvent::onmouseevent() \n");
		printMouseEventProperties(dynamic_cast<DKMouseEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H