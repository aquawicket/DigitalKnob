// [IDL] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKUIEvent/DKUIEvent.h"


class DKMouseEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
	DKMouseEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKMouseEvent("+_type+", "+_options+") \n");
		
		eventClass = "MouseEvent";
		eventAddress = pointerToAddress(this);
	}
	
	////// Static properties //////
	// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_MOUSE_DOWN
	// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN
	
	
	////// Instance properties //////
	// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
	bool altKey = false;
	// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	unsigned int button = 0;
	// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
	unsigned int buttons = 0;
	// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
	unsigned int clientX = 0;
	// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
	unsigned int clientY = 0;
	// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
	bool ctrlKey = false;
	// [MouseEvent.layerX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
	int layerX = 0;
	// [MouseEvent.layerY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
	int layerY = 0;
	// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
	bool metaKey = false;
	// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	int movementX = 0;
	// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
	int movementY = 0;
	// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	int offsetX = 0;
	// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	int offsetY = 0;
	// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	int pageX = 0;
	// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	int pageY = 0;
	// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
	DKString relatedTarget = "";
	// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
	unsigned int screenX = 0;
	// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
	unsigned int screenY = 0;
	// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
	bool shiftKey = false;
	// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozPressure
	float mozPressure = 0.0;
	// [MouseEvent.mozInputSource](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
	DKString mozInputSource = "";
	// [MouseEvent.webkitForce](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
	unsigned int webkitForce = 0;
	// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	unsigned int x = 0;
	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	unsigned int y = 0;		
	
	
	////// Instance methods //////
	// [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
	void getModifierState() {
		DKTODO();
	}
	// [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
	void initMouseEvent() {
		DKDEPRECATED();
	}
	
	
	////// Events //////
	// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
	// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
	// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
	// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
	// [DOMActivate](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/DOMActivate_event
	// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
	// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
	// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
	// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
	// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
	// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
	// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
	// [webkitmouseforcechanged](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcechanged_event
	// [webkitmouseforcedown](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcedown_event
	// [webkitmouseforceup](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforceup_event
	// [webkitmouseforcewillbegin](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcewillbegin_event
};


#endif //DKMouseEvent_H