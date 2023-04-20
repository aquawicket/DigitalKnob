#pragma once
#ifndef TEST_MouseEvent_H
#define TEST_MouseEvent_H

#include "DK/DK.h"
#include "DKMouseEvent/DKMouseEvent.h"


// [IDL] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
class TEST_MouseEvent : public DKObjectT<TEST_MouseEvent>
{
public:
	bool Init(){
		DKINFO("////// TEST_MouseEvent.h ////// \n");
		
		////// Static properties //////
		// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_MOUSE_DOWN
		// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN
	
	
		////// Instance properties //////
		// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
		// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
		// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
		// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
		// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
		// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
		// [MouseEvent.layerX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
		// [MouseEvent.layerY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
		// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
		// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
		// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
		// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
		// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
		// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
		// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
		// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
		// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
		// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
		// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
		// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozPressure
		// [MouseEvent.mozInputSource](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
		// [MouseEvent.webkitForce](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
		// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
		// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	
		
		////// Instance methods //////
		// [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
		// [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent

		
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
	
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_MouseEvent, true);


#endif //TEST_MouseEvent_H