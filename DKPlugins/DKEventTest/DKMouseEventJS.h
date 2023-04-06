#pragma once
#ifndef DKMouseEventJS_H
#define DKMouseEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
// [INTERFACE] https://w3c.github.io/uievents/#interface-keyboardevent
class DKMouseEventJS : public DKObjectT<DKMouseEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKMouseEvent", DKMouseEventJS::constructor);
		
		
		////// Static properties //////
		// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) 
		// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only)
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKMouseEvent_altKey", 		DKMouseEventJS::altKey); 			// [MouseEvent.altKey](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_button", 		DKMouseEventJS::button); 			// [MouseEvent.button](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_buttons",		DKMouseEventJS::buttons); 			// [MouseEvent.buttons](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_clientX", 		DKMouseEventJS::clientX); 			// [MouseEvent.clientX](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_clientY", 		DKMouseEventJS::clientY); 			// [MouseEvent.clientY](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_ctrlKey", 		DKMouseEventJS::ctrlKey); 			// [MouseEvent.ctrlKey](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_layerX", 		DKMouseEventJS::layerX); 			// [MouseEvent.layerX](Non-standard)(Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_layerY", 		DKMouseEventJS::layerY); 			// [MouseEvent.layerY](Non-standard)(Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_metaKey", 		DKMouseEventJS::metaKey); 			// [MouseEvent.metaKey](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_movementX",		DKMouseEventJS::movementX);			// [MouseEvent.movementX](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_movementY",		DKMouseEventJS::movementY); 		// [MouseEvent.movementY](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_offsetX", 		DKMouseEventJS::offsetX); 			// [MouseEvent.offsetX](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_offsetY", 		DKMouseEventJS::offsetY); 			// [MouseEvent.offsetY](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_pageX", 		DKMouseEventJS::pageX); 			// [MouseEvent.pageX](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_pageY",			DKMouseEventJS::pageY); 			// [MouseEvent.pageY](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_relatedTarget", DKMouseEventJS::relatedTarget);		// [MouseEvent.relatedTarget](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_screenX",		DKMouseEventJS::screenX); 			// [MouseEvent.screenX](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_screenY", 		DKMouseEventJS::screenY); 			// [MouseEvent.screenY](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_shiftKey", 		DKMouseEventJS::shiftKey); 			// [MouseEvent.shiftKey](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_mozPressure", 	DKMouseEventJS::mozPressure); 		// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_mozInputSource",DKMouseEventJS::mozInputSource);	// [MouseEvent.mozInputSource](Non-standard)(Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_webkitForce", 	DKMouseEventJS::webkitForce); 		// [MouseEvent.webkitForce](Non-standard)(Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_x", 			DKMouseEventJS::x); 				// [MouseEvent.x](Read only)
		DKDuktape::AttachFunction("CPP_DKMouseEvent_y", 			DKMouseEventJS::y); 				// [MouseEvent.y](Read only)
	

		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKMouseEvent_getModifierState",	DKMouseEventJS::getModifierState);	// [MouseEvent.getModifierState()] 
		DKDuktape::AttachFunction("CPP_DKMouseEvent_initMouseEvent",	DKMouseEventJS::initMouseEvent);	// [MouseEvent.initMouseEvent()](Deprecated)
	
	
		////// Events //////
		// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
		DKEventTarget::LinkAddEventListenerFunc		("auxclick", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("auxclick", 					&DKMouseEventJS::removeEventListener, 	this);
		// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
		DKEventTarget::LinkAddEventListenerFunc		("click", 						&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("click", 						&DKMouseEventJS::removeEventListener, 	this);
		// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
		DKEventTarget::LinkAddEventListenerFunc		("contextmenu", 				&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("contextmenu", 				&DKMouseEventJS::removeEventListener, 	this);
		// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
		DKEventTarget::LinkAddEventListenerFunc		("dblclick", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("dblclick", 					&DKMouseEventJS::removeEventListener, 	this);
		// [DOMActivate](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/DOMActivate_event
		DKEventTarget::LinkAddEventListenerFunc		("DOMActivate", 				&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("DOMActivate", 				&DKMouseEventJS::removeEventListener, 	this);
		// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
		DKEventTarget::LinkAddEventListenerFunc		("mousedown", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mousedown", 					&DKMouseEventJS::removeEventListener, 	this);
		// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
		DKEventTarget::LinkAddEventListenerFunc		("mouseenter", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mouseenter", 					&DKMouseEventJS::removeEventListener, 	this);
		// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
		DKEventTarget::LinkAddEventListenerFunc		("mouseleave", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mouseleave",			 		&DKMouseEventJS::removeEventListener, 	this);
		// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
		DKEventTarget::LinkAddEventListenerFunc		("mousemove", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mousemove", 					&DKMouseEventJS::removeEventListener, 	this);
		// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
		DKEventTarget::LinkAddEventListenerFunc		("mouseout", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mouseout", 					&DKMouseEventJS::removeEventListener, 	this);
		// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
		DKEventTarget::LinkAddEventListenerFunc		("mouseover", 					&DKMouseEventJS::addEventListener,		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mouseover", 					&DKMouseEventJS::removeEventListener, 	this);
		// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
		DKEventTarget::LinkAddEventListenerFunc		("mouseup", 					&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("mouseup", 					&DKMouseEventJS::removeEventListener, 	this);
		// [webkitmouseforcechanged](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcechanged_event
		DKEventTarget::LinkAddEventListenerFunc		("webkitmouseforcechanged", 	&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("webkitmouseforcechanged", 	&DKMouseEventJS::removeEventListener, 	this);
		// [webkitmouseforcedown](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcedown_event
		DKEventTarget::LinkAddEventListenerFunc		("webkitmouseforcedown", 		&DKMouseEventJS::addEventListener, 		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("webkitmouseforcedown", 		&DKMouseEventJS::removeEventListener, 	this);
		// [webkitmouseforceup](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforceup_event
		DKEventTarget::LinkAddEventListenerFunc		("webkitmouseforceup", 			&DKMouseEventJS::addEventListener,		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("webkitmouseforceup", 			&DKMouseEventJS::removeEventListener, 	this);
		// [webkitmouseforcewillbegin](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcewillbegin_event
		DKEventTarget::LinkAddEventListenerFunc		("webkitmouseforcewillbegin",	&DKMouseEventJS::addEventListener,		this);
		DKEventTarget::LinkRemoveEventListenerFunc	("webkitmouseforcewillbegin",	&DKMouseEventJS::removeEventListener,	this);
	

		////// Load .js files //////
		DKClass::DKCreate("DKEventTest/DKMouseEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKMouseEvent("+type+","+options+")\n");
		DKMouseEvent* event = new DKMouseEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
	static int altKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->altKey);	
		return true;
	}
	// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	static int button(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->button);	
		return true;
	}
	// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	static int buttons(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->buttons);	
		return true;
	}
	// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
	static int clientX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->clientX);	
		return true;
	}
	// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
	static int clientY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->clientY);	
		return true;
	}
	// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
	static int ctrlKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->ctrlKey);	
		return true;
	}
	// [MouseEvent.layerX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
	static int layerX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->layerX);	
		return true;
	}
	// [MouseEvent.layerY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
	static int layerY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->layerY);	
		return true;
	}
	// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
	static int metaKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->metaKey);	
		return true;
	}
	// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	static int movementX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->movementX);	
		return true;
	}
	// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
	static int movementY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->movementY);	
		return true;
	}
	// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	static int offsetX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->offsetX);	
		return true;
	}
	// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	static int offsetY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->offsetY);	
		return true;
	}
	// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	static int pageX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->pageX);	
		return true;
	}
	// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	static int pageY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_int(ctx, event->pageY);	
		return true;
	}
	// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
	static int relatedTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->relatedTarget.c_str());	
		return true;
	}
	// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
	static int screenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->screenX);	
		return true;
	}
	// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
	static int screenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->screenY);	
		return true;
	}
	// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
	static int shiftKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_boolean(ctx, event->shiftKey);	
		return true;
	}
	// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozPressure
	static int mozPressure(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_number(ctx, event->mozPressure);	
		return DKDEPRECATED();
	}
	// [MouseEvent.mozInputSource](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
	static int mozInputSource(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->mozInputSource.c_str());	
		return true;
	}
	// [MouseEvent.webkitForce](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
	static int webkitForce(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->webkitForce);	
		return true;
	}
	// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	static int x(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->x);	
		return true;
	}
	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	static int y(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKMouseEvent* event = (DKMouseEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->y);	
		return true;
	}
	
	
	////// Instance methods //////
	// [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
	static int getModifierState(duk_context* ctx){
		return DKTODO();
	}
	// [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
	static int initMouseEvent(duk_context* ctx){
		return DKDEPRECATED();
	}



	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKMouseEvent>(_type, &DKMouseEventJS::onMouseEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKMouseEvent>(_type, &DKMouseEventJS::onMouseEvent, eventTargetAddress);
		return true;
	}
	
	static bool onMouseEvent(DKMouseEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onMouseEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new MouseEvent('', '', '"+eventAddress+"'); eventObj;";  // returns eventObj
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);	 //push event object
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0){ //1 = num or args
			DKDuktape::DumpError(eventAddress);
		}
	
		return true;
	}	
	
};
REGISTER_OBJECT(DKMouseEventJS, true)


#endif //DKMouseEventJS_H