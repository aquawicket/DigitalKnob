// [IDL] https://w3c.github.io/uievents/#idl-mouseevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKUIEvent/DKUIEvent.h"

// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface MouseEvent : UIEvent {
class DKMouseEvent : public DKUIEvent
{
public:
	// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
	DKMouseEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // https://w3c.github.io/uievents/#dom-mouseevent-mouseevent
		DKDEBUGFUNC(_type, _eventInitDict);
		interfaceName = "MouseEvent";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKMouseEvent("+interfaceAddress+") \n");
	}
	virtual ~DKMouseEvent(){}
	
	// readonly attribute long screenX;
	int screenX = 0; // https://w3c.github.io/uievents/#dom-mouseevent-screenx
	
	// readonly attribute long screenY;
	int screenY = 0; // https://w3c.github.io/uievents/#dom-mouseevent-screeny
	
	// readonly attribute long clientX;
	int clientX = 0; // https://w3c.github.io/uievents/#dom-mouseevent-clientx
	
	// readonly attribute long clientY;
	int clientY = 0; // https://w3c.github.io/uievents/#dom-mouseevent-clienty
	 
	// readonly attribute boolean ctrlKey;
	bool ctrlKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-ctrlkey
	
	// readonly attribute boolean shiftKey;
	bool shiftKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-shiftkey
	
	// readonly attribute boolean altKey;
	bool altKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-altkey
	
	// readonly attribute boolean metaKey;
	bool metaKey = false; // https://w3c.github.io/uievents/#dom-mouseevent-metakey
	
	// readonly attribute short button;
	short button = 0; // https://w3c.github.io/uievents/#dom-mouseevent-button
	
	// readonly attribute unsigned short buttons;
	unsigned short buttons = 0; // https://w3c.github.io/uievents/#dom-mouseevent-buttons
	
	// readonly attribute EventTarget? relatedTarget;
	DKString relatedTarget = ""; // https://w3c.github.io/uievents/#dom-mouseevent-relatedtarget
	
	// boolean getModifierState(DOMString keyArg);
	void getModifierState(DKString& keyArg) { // https://w3c.github.io/uievents/#dom-mouseevent-getmodifierstate
		DKDEBUGFUNC(keyArg);
		DKTODO();
	}
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			double pageX = 0; // [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	//  	readonly attribute double pageY;
			double pageY = 0;  // [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	//  	readonly attribute double x;
			double x = 0; // [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	//  	readonly attribute double y;
			double y = 0;	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	//  	readonly attribute double offsetX; 
			double offsetX = 0; // [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	//  	readonly attribute double offsetY;
			double offsetY = 0; // [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			double movementX = 0; // [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	//   	readonly attribute double movementY;
			double movementY = 0; // [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface MouseEvent {
	//		Deprecated in this specification
	//	  	undefined initMouseEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional long detailArg = 0,
	//		optional long screenXArg = 0,
	//		optional long screenYArg = 0,
	//		optional long clientXArg = 0,
	//		optional long clientYArg = 0,
	//		optional boolean ctrlKeyArg = false,
	//		optional boolean altKeyArg = false,
	//		optional boolean shiftKeyArg = false,
	//		optional boolean metaKeyArg = false,
	//		optional short buttonArg = 0,
	//		optional EventTarget? relatedTargetArg = null);
			void initMouseEvent(
				DKString& typeArg, 
				bool& bubblesArg,
				bool& cancelableArg,
				DKString& viewArg,
				int& detailArg,
				int& screenXArg,
				int& screenYArg,
				int& clientXArg,
				int& clientYArg,
				bool& ctrlKeyArg,
				bool& altKeyArg,
				bool& shiftKeyArg,
				bool& metaKeyArg,
				short& buttonArg,
				DKString& relatedTargetArg) { // [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
					DKDEBUGFUNC(typeArg, bubblesArg, cancelableArg, viewArg, detailArg, screenXArg, screenYArg, clientXArg, clientYArg, ctrlKeyArg, altKeyArg, shiftKeyArg, metaKeyArg, buttonArg, relatedTargetArg);
					DKTODO();
			}
	// };
};


#endif //DKMouseEvent_H