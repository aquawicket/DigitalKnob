#pragma once
#ifndef DKUIEventJS_H
#define DKUIEventJS_H

#include "DKDuktape/DKDuktape.h"

// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
// [INTERFACE] https://w3c.github.io/uievents/#idl-uievent
class DKUIEventJS : public DKObjectT<DKUIEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKUIEvent", DKUIEventJS::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKUIEvent_detail", DKUIEventJS::detail);
		DKDuktape::AttachFunction("CPP_DKUIEvent_sourceCapabilities", DKUIEventJS::sourceCapabilities);
		DKDuktape::AttachFunction("CPP_DKUIEvent_view", DKUIEventJS::view);
		DKDuktape::AttachFunction("CPP_DKUIEvent_which", DKUIEventJS::which);

		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKUIEvent_initUIEvent", DKUIEventJS::initUIEvent);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKUIEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = duk_require_string(ctx, 1);
		DKINFO("CPP_DKUIEvent("+type+","+options+")\n");
		DKUIEvent* event = new DKUIEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->detail);	
		return true;
	}
	static int sourceCapabilities(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_???(ctx, event->sourceCapabilities.c_str());	
		*/
		return DKTODO();
	}
	static int view(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_???(ctx, event->view);
		*/
		return DKTODO();
	}
	static int which(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_uint(ctx, event->which);	
		return true;
	}
	
	
	////// Instance methods //////
	static int initUIEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		/*
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)DKDuktape::addressToPointer(eventAddress);
		*/
		return DKTODO();
	}	
	
};
REGISTER_OBJECT(DKUIEventJS, true)


#endif //DKUIEventJS_H