// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef TEST_DragEvent_H
#define TEST_DragEvent_H

#include "DK/DK.h"
#include "DKDragEvent/DKDragEvent.h"


class TEST_DragEvent : public DKObjectT<TEST_DragEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_DragEvent.h ////// \n");
		
		////// Instance properties //////
		// [DragEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer
		
		
		////// Event types //////
		// [drag] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
		// [dragend] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
		// [dragenter] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
		// [dragleave] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
		// [dragover] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
		// [dragstart] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
		// [drop] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
	
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_DragEvent, true);


#endif //TEST_DragEvent_H