// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef DKDragEvent_H
#define DKDragEvent_H

#include "DKMouseEvent/DKMouseEvent.h"


class DKDragEvent : public DKMouseEvent
{
public:
	////// Constructor //////
	// [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
	DKDragEvent(DKString _type, DKString _options) : DKMouseEvent(_type, _options) {
		DKINFO("DKDragEvent("+_type+", "+_options+") \n");
		
		eventClass = "DragEvent";
		eventAddress = pointerToAddress(this);
		
		////// Instance properties //////
		// [DragEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer
	}
	
	
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
};


#endif //DKDragEvent_H