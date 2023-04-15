#if HAVE_DKDuktape

#pragma once
#ifndef DKCustomEventDUK_H
#define DKCustomEventDUK_H

#include "DKDuktape/DKDuktape.h"


// [INTERFACE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
class DKCustomEventDUK : public DKObjectT<DKCustomEventDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent", 					DKCustomEventDUK::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent_detail", 			DKCustomEventDUK::detail);

		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent_initCustomEvent", 	DKCustomEventDUK::initCustomEvent);
		
	
		////// Load .js files
		DKClass::DKCreate("DKCustomEvent/DKCustomEventDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCustomEvent("+type+","+options+")\n");
		DKCustomEvent* event = new DKCustomEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CustomEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/detail
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCustomEvent* event = (DKCustomEvent*)addressToPointer(eventAddress);

		//DKDuktape::DumpStack(ctx);
		if(duk_is_object(ctx, 1))
			DKWARN("detail is an object")
		if (duk_is_string(ctx, 1))
			event->detail = duk_to_string(ctx, 1);
		duk_push_string(ctx, event->detail.c_str());	
		return true;
	}


	////// Instance methods //////
	// [CustomEvent.initCustomEvent()](Deprecated)
	static int initCustomEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}

};
REGISTER_OBJECT(DKCustomEventDUK, true)


#endif //DKCustomEventDUK_H
#endif //HAVE_DKDuktape