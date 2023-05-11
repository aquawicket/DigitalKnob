// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/MouseEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent
#pragma once
#ifndef DKMouseEventDUK_H
#define DKMouseEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface MouseEvent : UIEvent {
class DKMouseEventDUK : public DKObjectT<DKMouseEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK", 					DKMouseEventDUK::constructor);
		
		// readonly attribute long screenX;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_screenX",			DKMouseEventDUK::screenX);
		
		// readonly attribute long screenY;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_screenY", 			DKMouseEventDUK::screenY); 	
		
		// readonly attribute long clientX;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_clientX", 			DKMouseEventDUK::clientX); 
		
		// readonly attribute long clientY;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_clientY", 			DKMouseEventDUK::clientY);
		
		// readonly attribute boolean ctrlKey;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_ctrlKey", 			DKMouseEventDUK::ctrlKey);
		
		// readonly attribute boolean shiftKey;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_shiftKey", 			DKMouseEventDUK::shiftKey); 
		
		// readonly attribute boolean altKey;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_altKey", 			DKMouseEventDUK::altKey); 	
		
		// readonly attribute boolean metaKey;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_metaKey", 			DKMouseEventDUK::metaKey); 
		
		// readonly attribute short button;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_button", 			DKMouseEventDUK::button); 	
		
		// readonly attribute unsigned short buttons;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_buttons",			DKMouseEventDUK::buttons); 
		
		// readonly attribute EventTarget? relatedTarget;
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_relatedTarget", 		DKMouseEventDUK::relatedTarget);
		
		// boolean getModifierState(DOMString keyArg);
		DKDuktape::AttachFunction("CPP_DKMouseEventDUK_getModifierState",	DKMouseEventDUK::getModifierState);
		
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface MouseEvent {
		//  	readonly attribute double pageX;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_pageX", 		DKMouseEventDUK::pageX); 
		//  	readonly attribute double pageY;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_pageY",		DKMouseEventDUK::pageY); 
		//  	readonly attribute double x;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_x", 			DKMouseEventDUK::x); 
		//  	readonly attribute double y;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_y", 			DKMouseEventDUK::y); 
		//  	readonly attribute double offsetX; 
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_offsetX", 	DKMouseEventDUK::offsetX); 
		//  	readonly attribute double offsetY;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_offsetY", 	DKMouseEventDUK::offsetY); 	
		// };
		
		// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
		// partial interface MouseEvent {
		//   	readonly attribute double movementX;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_movementX",	DKMouseEventDUK::movementX);
		//   	readonly attribute double movementY;
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_movementY",	DKMouseEventDUK::movementY); 
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
				DKDuktape::AttachFunction("CPP_DKMouseEventDUK_initMouseEvent",	DKMouseEventDUK::initMouseEvent);
		// };
	

		////// Load .js files //////
		DKClass::DKCreate("DKMouseEvent/DKMouseEventDUK.js");
		
		return true;
	}
	
	
	static DKMouseEvent* mouseEvent(duk_context* ctx){
		DKString mouseEventAddress = duk_require_string(ctx, 0);
		return (DKMouseEvent*)addressToPointer(mouseEventAddress);
	}
	
	// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKMouseEventDUK("+type+","+eventInitDict+")\n");
		DKMouseEvent* mouseEvent = new DKMouseEvent(type, eventInitDict);
		DKString mouseEventAddress = pointerToAddress(mouseEvent);
		dukglue_push(ctx, mouseEventAddress);
		return true;
	}
	
	// readonly attribute long screenX;
	static int screenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			mouseEvent(ctx)->screenX = duk_to_int(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->screenX);
		return true;
	}
	
	// readonly attribute long screenY;
	static int screenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			mouseEvent(ctx)->screenY = duk_to_int(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->screenY);	
		return true;
	}
	
	// readonly attribute long clientX;
	static int clientX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			mouseEvent(ctx)->clientX = duk_to_int(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->clientX);	
		return true;
	}
	
	// readonly attribute long clientY;
	static int clientY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			mouseEvent(ctx)->clientY = duk_to_int(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->clientY);	
		return true;
	}
	
	// readonly attribute boolean ctrlKey;
	static int ctrlKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_boolean(ctx, 1))
			mouseEvent(ctx)->ctrlKey = duk_to_boolean(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->ctrlKey);	
		return true;
	}
	
	// readonly attribute boolean shiftKey;
	static int shiftKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_boolean(ctx, 1))
			mouseEvent(ctx)->shiftKey = duk_to_boolean(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->shiftKey);	
		return true;
	}
	
	// readonly attribute boolean altKey;
	static int altKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_boolean(ctx, 1))
			mouseEvent(ctx)->altKey = duk_to_boolean(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->altKey);	
		return true;
	}
	
	// readonly attribute boolean metaKey;
	static int metaKey(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_boolean(ctx, 1))
			mouseEvent(ctx)->metaKey = duk_to_boolean(ctx, 1);
		dukglue_push(ctx, mouseEvent(ctx)->metaKey);	
		return true;
	}
	
	// readonly attribute short button;
	static int button(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, mouseEvent(ctx)->button);	
		return true;
	}
	
	// readonly attribute unsigned short buttons;
	static int buttons(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, mouseEvent(ctx)->buttons);	
		return true;
	}
	
	// readonly attribute EventTarget? relatedTarget;
	static int relatedTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, mouseEvent(ctx)->relatedTarget);	
		return true;
	}
	
	// boolean getModifierState(DOMString keyArg);
	static int getModifierState(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			static int pageX(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->pageX);	
				return true;
			}
	//  	readonly attribute double pageY;
			static int pageY(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->pageY);	
				return true;
			}
	//  	readonly attribute double x;
			static int x(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->x);	
				return true;
			}
	//  	readonly attribute double y;
			static int y(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->y);	
				return true;
			}
	//  	readonly attribute double offsetX; 
			static int offsetX(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->offsetX);	
				return true;
			}
	//  	readonly attribute double offsetY;
			static int offsetY(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->offsetY);	
				return true;
			}
	// };
	
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			static int movementX(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->movementX);	
				return true;
			}
	//   	readonly attribute double movementY;
			static int movementY(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, mouseEvent(ctx)->movementY);	
				return true;
			}
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
			static int initMouseEvent(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKDEPRECATED();
			}
	// };	

};
REGISTER_OBJECT(DKMouseEventDUK, true)


#endif //DKMouseEventDUK_H