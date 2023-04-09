#pragma once
#ifndef DKMouseEvent_H
#define DKMouseEvent_H

#include "DKEventTestB/DKUIEvent.h"


// [W3C] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
class DKMouseEvent : public DKUIEvent
{
public:
	////// Constructor //////
	// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
	DKMouseEvent(DKString _type, DKString _options) : DKUIEvent(_type, _options) {
		DKINFO("DKMouseEvent("+_type+", "+_options+") \n");
		
		eventClass = "MouseEvent";
		
		////// Instance properties //////
		altKey = false;		
		button = 0;
		buttons = 0;
		clientX = 0;
		clientY = 0;
		ctrlKey = false;
		layerX = 0;
		layerY = 0;
		metaKey = false;
		movementX = 0;
		movementY = 0;
		offsetX = 0;
		offsetY = 0;
		pageX = 0;
		pageY = 0;
		relatedTarget = "";
		screenX = 0;
		screenY = 0;
		shiftKey = false;
		mozPressure = 0.0;
		mozInputSource = "";
		webkitForce = 0;
		x = 0;
		y = 0;
	}
	
	////// Static properties //////
	// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_MOUSE_DOWN
	// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN
	
	
	////// Instance properties //////
	// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
	bool altKey;
	// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	unsigned int button;
	// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
	unsigned int buttons;
	// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
	unsigned int clientX;
	// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
	unsigned int clientY;
	// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
	bool ctrlKey;
	// [MouseEvent.layerX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
	int layerX;
	// [MouseEvent.layerY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
	int layerY;
	// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
	bool metaKey;
	// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	int movementX;
	// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
	int movementY;
	// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	int offsetX;
	// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	int offsetY;
	// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	int pageX;
	// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	int pageY;
	// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
	DKString relatedTarget;
	// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
	unsigned int screenX;
	// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
	unsigned int screenY;
	// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
	bool shiftKey;
	// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozPressure
	float mozPressure;
	// [MouseEvent.mozInputSource](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
	DKString mozInputSource;
	// [MouseEvent.webkitForce](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
	unsigned int webkitForce;
	// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	unsigned int x;
	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	unsigned int y;		
	
	
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