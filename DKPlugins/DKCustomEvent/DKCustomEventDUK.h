// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/CustomEvent.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKCustomEventDUK_H
#define DKCustomEventDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface CustomEvent : Event {
class DKCustomEventDUK : public DKObjectT<DKCustomEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKCustomEvent", 					DKCustomEventDUK::constructor);

		// readonly attribute any detail;
		DKDuktape::AttachFunction("CPP_DKCustomEvent_detail", 			DKCustomEventDUK::detail);

		// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
		DKDuktape::AttachFunction("CPP_DKCustomEvent_initCustomEvent", 	DKCustomEventDUK::initCustomEvent);
		
	
		////// Load .js files //////
		DKClass::DKCreate("DKCustomEvent/DKCustomEventDUK.js");
		
		return true;
	}
	
	static DKCustomEvent* customEvent(duk_context* ctx){
		DKString customEventAddress = duk_require_string(ctx, 0);
		return (DKCustomEvent*)addressToPointer(customEventAddress);
	}
	
	// constructor(DOMString type, optional CustomEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCustomEvent("+type+","+eventInitDict+")\n");
		DKCustomEvent* customEvent = new DKCustomEvent(type, eventInitDict);
		DKString customEventAddress = pointerToAddress(customEvent);
		duk_push_string(ctx, customEventAddress.c_str());	
		return true;
	}
	
	// readonly attribute any detail;
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_object(ctx, 1))
			DKWARN("detail is an object")
		if (duk_is_string(ctx, 1))
			customEvent(ctx)->detail = duk_to_string(ctx, 1);
		duk_push_string(ctx, customEvent(ctx)->detail.c_str());	
		return true;
	}

	// undefined initCustomEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false, optional any detail = null); // legacy
	static int initCustomEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}

};
REGISTER_OBJECT(DKCustomEventDUK, true)


#endif //DKCustomEventDUK_H
#endif //HAVE_DKDuktape