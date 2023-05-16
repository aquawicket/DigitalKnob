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
		DKINFO("\n////// TEST_DragEvent.h //////\n");
	
		DKEventTarget eventTarget;
		eventTarget.addEventListener("dragEvent", &TEST_DragEvent::onDragEvent);
		DKDragEvent dragEvent("dragEvent", "");
		eventTarget.dispatchEvent(dragEvent);
		return true;
	}
	
	static void printDragEventProperties(DKDragEvent& dragEvent){
		DKDEBUGFUNC(dragEvent);
		DKTODO();
	}
	
	static bool onDragEvent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DragEvent::onDragEvent() \n");
		printDragEventProperties(dynamic_cast<DKDragEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H