// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef TEST_DragEvent_H
#define TEST_DragEvent_H

#include "DKDragEvent/DKDragEvent.h"


class TEST_DragEvent //: public DKObjectT<TEST_DragEvent>
{
public:
	TEST_DragEvent() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DragEvent.h //////");
	
		DKEventTarget eventTarget;
		eventTarget.addEventListener("dragEvent", &TEST_DragEvent::onDragEvent);
		DKDragEvent dragEvent("dragEvent", "");
		eventTarget.dispatchEvent(&dragEvent);
	}
	
	static void printDragEventProperties(DKDragEvent* dragEvent) {
		DKDEBUGFUNC(dragEvent);
		
		console.log("dragEvent = "					+toString(dragEvent));
		
		// constructor(DOMString type, optional DragEventInit eventInitDict = {});
		// function
		
		// readonly attribute DataTransfer? dataTransfer;
		console.log("dragEvent->dataTransfer() = "	+toString(dragEvent->dataTransfer()));
		
		TEST_MouseEvent::printMouseEventProperties(dragEvent);
	}
	
	static bool onDragEvent(DKEvent* event) {
		DKDEBUGFUNC(event);
		console.log("\nTEST_DragEvent::onDragEvent()");
		printDragEventProperties(dynamic_cast<DKDragEvent*>(event));						//TODO: try to remove the need for dynamic_cast
		return true;
	}
};
//REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H