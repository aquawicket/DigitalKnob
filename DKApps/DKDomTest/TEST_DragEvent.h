// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef TEST_DragEvent_H
#define TEST_DragEvent_H

#include "DKDragEvent/DKDragEvent.h"


class TEST_DragEvent : public DKObjectT<TEST_DragEvent>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_DragEvent.h //////");
	
		DKEventTarget eventTarget;
		eventTarget.addEventListener("dragEvent", &TEST_DragEvent::onDragEvent);
		DKDragEvent dragEvent("dragEvent", "");
		eventTarget.dispatchEvent(dragEvent);
		return true;
	}
	
	static void printDragEventProperties(DKDragEvent& dragEvent){
		DKDEBUGFUNC(dragEvent);
		
		// constructor(DOMString type, optional DragEventInit eventInitDict = {});
		// function
		
		// readonly attribute DataTransfer? dataTransfer;
		DKConsole::log("dragEvent.dataTransfer() = "	+toString(dragEvent.dataTransfer()));
		
		TEST_MouseEvent::printMouseEventProperties(dynamic_cast<DKMouseEvent&>(dragEvent));	//TODO: try to remove the need for dynamic_cast
	}
	
	static bool onDragEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKConsole::log("TEST_DragEvent::onDragEvent()");
		printDragEventProperties(dynamic_cast<DKDragEvent&>(event));						//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H