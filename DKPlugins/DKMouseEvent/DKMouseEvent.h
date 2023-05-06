// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/MouseEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-mouseevents
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
	DKMouseEvent(DKString _type, DKString _eventInitDict) : DKUIEvent(_type, _eventInitDict) { // [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
		DKINFO("DKMouseEvent("+_type+", "+_eventInitDict+") \n");
		
		interfaceName = "MouseEvent";
		interfaceAddress = pointerToAddress(this);
	}
	
	// readonly attribute long screenX;
	unsigned int screenX = 0; // [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
	
	// readonly attribute long screenY;
	unsigned int screenY = 0; // [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
	
	// readonly attribute long clientX;
	unsigned int clientX = 0; // [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
	
	// readonly attribute long clientY;
	unsigned int clientY = 0; // [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
	 
	// readonly attribute boolean ctrlKey;
	bool ctrlKey = false; // [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
	
	// readonly attribute boolean shiftKey;
	bool shiftKey = false; // [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
	
	// readonly attribute boolean altKey;
	bool altKey = false; // [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
	
	// readonly attribute boolean metaKey;
	bool metaKey = false; // [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
	
	// readonly attribute short button;
	unsigned int button = 0; // [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	
	// readonly attribute unsigned short buttons;
	unsigned int buttons = 0; // [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
	
	// readonly attribute EventTarget? relatedTarget;
	DKString relatedTarget = ""; // [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
	
	// boolean getModifierState(DOMString keyArg);
	void getModifierState() { // [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
		DKTODO();
	}
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			int pageX = 0; // [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	//  	readonly attribute double pageY;
			int pageY = 0;  // [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	//  	readonly attribute double x;
			unsigned int x = 0; // [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	//  	readonly attribute double y;
			unsigned int y = 0;	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	//  	readonly attribute double offsetX; 
			int offsetX = 0; // [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	//  	readonly attribute double offsetY;
			int offsetY = 0; // [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			int movementX = 0; // [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	//   	readonly attribute double movementY;
			int movementY = 0; // [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
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
			void initMouseEvent() { // [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
				DKDEPRECATED();
			}
	// };
};


#endif //DKMouseEvent_H