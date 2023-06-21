// [IDL] https://dom.spec.whatwg.org/#callbackdef-eventlistener
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventListener
#if HAVE_DKDuktape

#pragma once
#ifndef DKEventListenerDUK_H
#define DKEventListenerDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// callback interface EventListener {
class DKEventListenerDUK : public DKObjectT<DKEventListenerDUK>
{
public:
	bool Init(){
		DKDuktape::AttachFunction("CPP_DKEventListenerDUK_constructor", 	DKEventListenerDUK::constructor); 
		
		// TODO
	}
	
	static DKEventListener* eventListener(duk_context* ctx){
		DKString eventAddress = duk_require_string(ctx, 0);
		return (DKEventListener*)addressToPointer(eventAddress);
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
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString type = duk_require_string(ctx, 0);
		DKINFO("CPP_DKEventListenerDUK_constructor()\n");
		DKEventListener* eventListener = new DKEventListener();
		dukglue_push(ctx, pointerToAddress(eventListener));
		return true;
	}
	
	// TODO
	
};
REGISTER_OBJECT(DKEventListenerDUK, true)	
		

#endif //DKEventListenerDUK_H
#endif //HAVE_DKDuktape