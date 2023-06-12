// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef DKDragEvent_H
#define DKDragEvent_H

#include "DKMouseEvent/DKMouseEvent.h"


////// EventInit //////
typedef std::string DragEventInit;


// [Exposed=Window]
// interface DragEvent : MouseEvent {
class DKDragEvent : public DKMouseEvent
{
public:
	// constructor(DOMString type, optional DragEventInit eventInitDict = {});
	DKDragEvent(const DOMString& type, const DragEventInit& eventInitDict = "{}") : DKMouseEvent(type, eventInitDict) {
		DKINFO("DKDragEvent("+type+", "+eventInitDict+") \n");
		interfaceName = "DragEvent";
		interfaceAddress = pointerToAddress(this);
	}
	virtual ~DKDragEvent(){}
	
	// readonly attribute DataTransfer? dataTransfer;
	DKString _dataTransfer = "";
	virtual const DKString& 	dataTransfer()								{ return _dataTransfer; }			// getter
	virtual void 				dataTransfer(const DKString& dataTransfer) 	{ _dataTransfer = dataTransfer; } 	// setter
};


#endif //DKDragEvent_H