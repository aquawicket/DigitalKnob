// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef DKDragEvent_H
#define DKDragEvent_H

#include "DKMouseEvent/DKMouseEvent.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface DragEvent : MouseEvent {
class DKDragEvent : public DKMouseEvent
{
public:
	//constructor(DOMString type, optional DragEventInit eventInitDict = {});
	DKDragEvent(DKString _type, DKString _eventInitDict) : DKMouseEvent(_type, _eventInitDict) { // [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
		DKINFO("DKDragEvent("+_type+", "+_eventInitDict+") \n");
		interfaceName = "DragEvent";
		interfaceAddress = pointerToAddress(this);
	}
	virtual ~DKDragEvent(){}
	
	// readonly attribute DataTransfer? dataTransfer;
	DKString dataTransfer = ""; // [DragEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer
};


#endif //DKDragEvent_H