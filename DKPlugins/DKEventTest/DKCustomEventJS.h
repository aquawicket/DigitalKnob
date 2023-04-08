#pragma once
#ifndef DKCustomEventJS_H
#define DKCustomEventJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
//#include "dukglue/dukglue.h"
#include "dukglue/public_util.h"
#include "dukglue/dukvalue.h"
WARNING_ENABLE


// [INTERFACE] https://dom.spec.whatwg.org/#interface-customevent
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent
class DKCustomEventJS : public DKObjectT<DKCustomEventJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent", 					DKCustomEventJS::constructor);
	
	
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent_detail", 			DKCustomEventJS::detail);

		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKCustomEvent_initCustomEvent", 	DKCustomEventJS::initCustomEvent);
		
	
		////// Load .js files
		DKClass::DKCreate("DKEventTest/DKCustomEvent.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [CustomEvent()] https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKCustomEvent("+type+","+options+")\n");
		DKCustomEventJS::Get()->registerEventType(type);
		DKCustomEvent* event = new DKCustomEvent(type, options);
		//DKEvent* event = (DKEvent*)new DKCustomEvent(type, options);
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [CustomEvent.detail](Read only) https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/detail
	static int detail(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventAddress = duk_require_string(ctx, 0);
		DKCustomEvent* event = (DKCustomEvent*)DKDuktape::addressToPointer(eventAddress);
		duk_push_string(ctx, event->detail.c_str());	
		return true;
	}


	////// Instance methods //////
	// [CustomEvent.initCustomEvent()](Deprecated)
	static int initCustomEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKDEPRECATED();
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	bool registerEventType(const DKString& _type){
		DKINFO("DKCustomEventJS::registerEventType("+_type+") \n");
		DKEventTarget::LinkAddEventListenerFunc		(_type, &DKCustomEventJS::addEventListener, 	this);
		DKEventTarget::LinkRemoveEventListenerFunc	(_type,	&DKCustomEventJS::removeEventListener, 	this);
		return true;
	}
	
	bool addEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKINFO("DKCustomEventJS::addEventListener("+_type+", "+eventTargetAddress+") \n");
		DKEventTarget::addEventListener<DKCustomEvent>(_type, &DKCustomEventJS::onCustomEvent, eventTargetAddress);
		return true;
	}
	
	bool removeEventListener(const DKString& _type, const DKString& eventTargetAddress){
		DKINFO("DKCustomEventJS::removeEventListener("+_type+", "+eventTargetAddress+") \n");
		DKEventTarget::removeEventListener<DKCustomEvent>(_type, &DKCustomEventJS::onCustomEvent, eventTargetAddress);
		return true;
	}
	
	bool dispatchEvent(const DKString& eventAddress, const DKString& eventTargetAddress){
		DKINFO("DKCustomEventJS::dispatchEvent("+eventAddress+", "+eventTargetAddress+") \n");
		DKCustomEvent* event = (DKCustomEvent*)DKDuktape::addressToPointer(eventAddress);
		DKEventTarget::dispatchEvent(event, eventTargetAddress);
		return true;
	}
	
	static bool onCustomEvent(DKCustomEvent* event) {
		DKDEBUGFUNC(event);
		DKINFO("DKCustomEventJS::onCustomEvent("+event->type+") \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(event);
		DKString cb = event->target+"_"+event->type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		DKString eventObjStr = "var eventObj = new CustomEvent('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	
		return true;
	}
};
REGISTER_OBJECT(DKCustomEventJS, true)


#endif //DKCustomEventJS_H