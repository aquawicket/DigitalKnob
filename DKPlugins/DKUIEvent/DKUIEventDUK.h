#if HAVE_DKDuktape

#pragma once
#ifndef DKUIEventDUK_H
#define DKUIEventDUK_H

#include "DKDuktape/DKDuktape.h"


// [W3C] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
class DKUIEventDUK : public DKObjectT<DKUIEventDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKUIEventDUK", 						DKUIEventDUK::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_detail", 				DKUIEventDUK::detail);
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_sourceCapabilities", 	DKUIEventDUK::sourceCapabilities);
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_view", 				DKUIEventDUK::view);
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_which", 				DKUIEventDUK::which);

		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKUIEventDUK_initUIEvent", 			DKUIEventDUK::initUIEvent);
		
		
		////// Events //////
		// [abort] https://w3c.github.io/uievents/#event-type-abort
		// [error] https://w3c.github.io/uievents/#event-type-error
		// [load] https://w3c.github.io/uievents/#event-type-load
		// [select] https://w3c.github.io/uievents/#event-type-select
		// [unload] https://w3c.github.io/uievents/#event-type-unload
	
	
		////// Load .js files
		DKClass::DKCreate("DKUIEvent/DKUIEventDUK.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKUIEventDUK("+type+","+options+")\n");
		DKUIEvent* event = new DKUIEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [UIEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)addressToPointer(eventAddress);
		if (duk_is_number(ctx, 1))
			event->detail = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, event->detail);	
		return true;
	}
	// [UIEvent.sourceCapabilities](Experimental)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/sourceCapabilities
	static int sourceCapabilities(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [UIEvent.view](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/view
	static int view(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	// [UIEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/which
	static int which(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)addressToPointer(eventAddress);
		duk_push_uint(ctx, event->which);	
		return DKDEPRECATED();
	}
	
	
	////// Instance methods //////
	// [UIEvent.initUIEvent()](Deprecated)
	static int initUIEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}

};
REGISTER_OBJECT(DKUIEventDUK, true)


#endif //DKUIEventDUK_H
#endif //HAVE_DKDuktape