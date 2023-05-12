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
	
		return DKTODO();
	}
	
	static void printDragEventProperties(DKDragEvent& dragevent){
		DKDEBUGFUNC(dragevent);
		DKTODO();
	}
	
	static bool ondragevent(DKEvent& event){
		DKDEBUGFUNC(event);
		DKINFO("TEST_DragEvent::ondragevent() \n");
		printDragEventProperties(dynamic_cast<DKDragEvent&>(event));			//TODO: try to remove the need for dynamic_cast
		TEST_UIEvent::printUIEventProperties(dynamic_cast<DKUIEvent&>(event));	//TODO: try to remove the need for dynamic_cast
		TEST_Event::printEventProperties(event);
		return true;
	}
};
REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H