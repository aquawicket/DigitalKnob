// [IDL] https://w3c.github.io/uievents/#idl-uievent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKUIEventDUK_H
#define DKUIEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface UIEvent : Event {
class DKUIEventDUK : public DKObjectT<DKUIEventDUK>
{
public:
	bool Init(){
		
		//constructor(DOMString type, optional UIEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKUIEventDUK", 			DKUIEventDUK::constructor);
	
		// readonly attribute Window? view;
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_view", 		DKUIEventDUK::view);
		
		// readonly attribute long detail;
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_detail", 	DKUIEventDUK::detail);
		
		// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
		// partial interface UIEvent {
		// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
				DKDuktape::AttachFunction("CPP_DKUIEventDUK_sourceCapabilities", 	DKUIEventDUK::sourceCapabilities);
		// };
		
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface UIEvent {
		// 		Deprecated in this specification
		//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
				DKDuktape::AttachFunction("CPP_DKUIEventDUK_initUIEvent", 			DKUIEventDUK::initUIEvent);
		//	};
	
		// Source: UI Events (https://www.w3.org/TR/uievents/)
		// partial interface UIEvent {
		//		The following support legacy user agents
		//		readonly attribute unsigned long which;
				DKDuktape::AttachFunction("CPP_DKUIEventDUK_which", 				DKUIEventDUK::which);
		// };
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKUIEvent/DKUIEventDUK.js");
		
		return true;
	}
	
	static DKUIEvent* uiEvent(duk_context* ctx){
		DKString uiEventAddress = duk_require_string(ctx, 0);
		return (DKUIEvent*)addressToPointer(uiEventAddress);
	}
	static bool GetBool(duk_context* ctx, int index = 1){
		if (duk_is_boolean(ctx, index))
			return duk_to_boolean(ctx, index);
		return false;
	}
	static double GetDouble(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_number(ctx, index);
		return 0.0;
	}
	static int GetInt(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_int(ctx, index);
		return 0;
	}
	static DKString GetString(duk_context* ctx, int index = 1){
		if (duk_is_string(ctx, index))
			return duk_to_string(ctx, index);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx, int index = 1){
		if (duk_is_number(ctx, index))
			return duk_to_uint(ctx, index);
		return 0;
	}
	
	//constructor(DOMString type, optional UIEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKUIEventDUK("+type+","+eventInitDict+")\n");
		DKUIEvent* uiEvent = new DKUIEvent(type, eventInitDict);
		DKString uiEventAddress = pointerToAddress(uiEvent);	
		dukglue_push(ctx, uiEventAddress);
		return true;
	}
	
	// readonly attribute Window? view;
	static int view(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_string(ctx, 1))
			uiEvent(ctx)->view(*(DKWindow*)addressToPointer(duk_to_string(ctx, 1)));
		dukglue_push(ctx, pointerToAddress(&uiEvent(ctx)->view()));
		return true;
	}
	
	// readonly attribute long detail;
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			uiEvent(ctx)->detail(duk_to_int(ctx, 1));
		dukglue_push(ctx, uiEvent(ctx)->detail());
		return true;
	}
	
	// Source: Input Device Capabilities (https://wicg.github.io/input-device-capabilities/)
	// partial interface UIEvent {
	// 		readonly attribute InputDeviceCapabilities? sourceCapabilities;
			static int sourceCapabilities(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, uiEvent(ctx)->sourceCapabilities());
				return true;
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	// 		Deprecated in this specification
	//		undefined initUIEvent(DOMString typeArg, optional boolean bubblesArg = false, optional boolean cancelableArg = false, optional Window? viewArg = null, optional long detailArg = 0);
			static int initUIEvent(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString typeArg = GetString(ctx, 1);
				bool bubblesArg = GetBool(ctx, 2);
				bool cancelableArg = GetBool(ctx, 3);
				DKString viewArgAddress = GetString(ctx, 4);
				DKWindow* viewArg = (DKWindow*)addressToPointer(viewArgAddress);
				int detailArg = GetInt(ctx, 5);
				uiEvent(ctx)->initUIEvent(typeArg, bubblesArg, cancelableArg, viewArg, detailArg);
				return true;
			}
	//	};
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface UIEvent {
	//		The following support legacy user agents
	//		readonly attribute unsigned long which;
			static int which(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				dukglue_push(ctx, uiEvent(ctx)->which());				
				return true;
			}
	// };	
};
REGISTER_OBJECT(DKUIEventDUK, true)


#endif //DKUIEventDUK_H
#endif //HAVE_DKDuktape