// [IDL] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKCustomEventDUK_H
#define DKCustomEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface CustomEvent : Event {
class DKCustomEventDUK : public DKObjectT<DKCustomEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKCustomEventDUK_constructor", 		DKCustomEventDUK::constructor);

		// readonly attribute any detail;
		DKDuktape::AttachFunction("CPP_DKCustomEventDUK_detail", 			DKCustomEventDUK::detail);

		// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
		DKDuktape::AttachFunction("CPP_DKCustomEventDUL_initCustomEvent", 	DKCustomEventDUK::initCustomEvent);
		
	
		////// Load .js files //////
		DKClass::DKCreate("DKCustomEvent/DKCustomEventDUK.js");
		
		return true;
	}
	
	static DKCustomEvent* customEvent(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKString customEventAddress = interface->address["CustomEvent"];
		DKCustomEvent* _customEvent = (DKCustomEvent*)addressToPointer(customEventAddress);
		return _customEvent;
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
	
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "{}";	//duk_require_string(ctx, 1);
		
		DKINFO("CPP_DKCustomEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKCustomEvent* customEvent = new DKCustomEvent(type, eventInitDict);
		dukglue_push(ctx, customEvent->interfaceAddress);
		return true;
	}
	
	// readonly attribute any detail;
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_object(ctx, 1))
			DKWARN("detail is an object")
		if (duk_is_string(ctx, 1))
			customEvent(ctx)->detail(duk_to_string(ctx, 1));
		dukglue_push(ctx, customEvent(ctx)->detail());
		return true;
	}

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	static int initCustomEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _type = GetString(ctx, 1);
		bool _bubbles = GetBool(ctx, 2);
		bool _cancelable = GetBool(ctx, 3);
		DKString _detail = GetString(ctx, 4);
		customEvent(ctx)->initCustomEvent(_type, _bubbles, _cancelable, _detail);
		return DKTODO();
	}

};
REGISTER_OBJECT(DKCustomEventDUK, true)


#endif //DKCustomEventDUK_H
#endif //HAVE_DKDuktape