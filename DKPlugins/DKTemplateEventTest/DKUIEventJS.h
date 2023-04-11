#pragma once
#ifndef DKUIEventJS_H
#define DKUIEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
//#include "dukglue/dukglue.h"
#include "dukglue/public_util.h"
#include "dukglue/dukvalue.h"
WARNING_ENABLE


// [W3C] https://w3c.github.io/uievents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent
class DKUIEventJS : public DKObjectT<DKUIEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKUIEvent", 						DKUIEventJS::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKUIEvent_detail", 				DKUIEventJS::detail);
		DKDuktape::AttachFunction("CPP_DKUIEvent_sourceCapabilities", 	DKUIEventJS::sourceCapabilities);
		DKDuktape::AttachFunction("CPP_DKUIEvent_view", 				DKUIEventJS::view);
		DKDuktape::AttachFunction("CPP_DKUIEvent_which", 				DKUIEventJS::which);

		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKUIEvent_initUIEvent", 			DKUIEventJS::initUIEvent);
		
		
		////// Events //////
		// [abort] https://w3c.github.io/uievents/#event-type-abort
		registerEventType("abort");
		// [error] https://w3c.github.io/uievents/#event-type-error
		registerEventType("error");
		// [load] https://w3c.github.io/uievents/#event-type-load
		registerEventType("load");
		// [select] https://w3c.github.io/uievents/#event-type-select
		registerEventType("select");
		// [unload] https://w3c.github.io/uievents/#event-type-unload
		registerEventType("unload");
	
	
		////// Load .js files
		DKClass::DKCreate("DKTemplateEventTest/DKUIEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [UIEvent()] https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/UIEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKUIEvent("+type+","+options+")\n");
		DKUIEventJS::Get()->registerEventType(type);
		DKUIEvent* event = new DKUIEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		DKEventTarget::LinkDispatchEventFunc(eventAddress, &DKUIEventJS::dispatchEvent, DKUIEventJS::Get());
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [UIEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKUIEvent* event = (DKUIEvent*)addressToPointer(eventAddress);
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
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////
	bool registerEventType(const DKString& _type){
		DKEventTarget::LinkAddEventListenerFunc		(_type, &DKUIEventJS::addEventListener, 	this);
		DKEventTarget::LinkRemoveEventListenerFunc	(_type,	&DKUIEventJS::removeEventListener, 	this);
		return true;
	}
	
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::addEventListener<DKUIEvent>(_type, &DKUIEventJS::onUIEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKEventTarget::removeEventListener<DKUIEvent>(_type, &DKUIEventJS::onUIEvent, eventTargetAddress);
		return true;
	}
	
	bool dispatchEvent(const DKString& eventAddress, const DKString& eventTargetAddress){
		DKINFO("DKUIEventJS::dispatchEvent("+eventAddress+", "+eventTargetAddress+") \n");
		DKUIEvent* event = (DKUIEvent*)addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, eventTargetAddress);
		return true;
	}
	
	static bool onUIEvent(DKUIEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("onUIEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new UIEvent('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}
};
REGISTER_OBJECT(DKUIEventJS, true)


#endif //DKUIEventJS_H