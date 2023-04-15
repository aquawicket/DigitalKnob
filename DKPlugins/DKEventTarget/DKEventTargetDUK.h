#if HAVE_DKDuktape

#pragma once
#ifndef DKEventTargetDUK_H
#define DKEventTargetDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKEventTarget/DKEventTarget.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE

// [EventTarget] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEventTargetDUK : public DKObjectT<DKEventTargetDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK", DKEventTargetDUK::constructor);
		
		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_addEventListener", 		DKEventTargetDUK::addEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_removeEventListener", 	DKEventTargetDUK::removeEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_dispatchEvent", 		DKEventTargetDUK::dispatchEvent);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTarget/DKEventTargetDUK.js");
		//DKClass::DKCreate("DKEventTarget/DKGlobalEventHandlersDUK.js");
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKEventTargetDUK()\n");
		DKEventTarget* eventTarget = new DKEventTarget();
		DKString eventTargetAddress = pointerToAddress(eventTarget);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
	
	////// Instance methods //////
	// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
	static int addEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		//DKINFO("DKEventTargetDUK::addEventListener("+targetAddress+", "+type+", callback)\n");
		
		// store the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		//DKINFO("DKEventTargetDUK::addEventListener() -> "+cb+" \n")
		duk_dup(ctx, 2);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget* eventTarget = (DKEventTarget*)addressToPointer(targetAddress);
		eventTarget->addEventListener(type, &DKEventTargetDUK::onevent);
		
		return true;
	}
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	static int removeEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		//DKINFO("DKEventTargetDUK::removeEventListener("+targetAddress+", "+type+", callback)\n");
		
		// remove the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		duk_push_null(ctx);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget* eventTarget = (DKEventTarget*)addressToPointer(targetAddress);
		eventTarget->removeEventListener(type, &DKEventTargetDUK::onevent);

		return true;
	}
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString eventAddress = duk_require_string(ctx, 1);
		//DKINFO("DKEventTargetDUK::dispatchEvent("+targetAddress+", "+eventAddress+")\n");
		
		DKEventTarget* eventTarget = (DKEventTarget*)addressToPointer(targetAddress);
		DKEvent* event = (DKEvent*)addressToPointer(eventAddress);
		eventTarget->dispatchEvent(*event);
		
		return true;
	}
	
	static void onevent(DKEvent& event) {
		DKDEBUGFUNC(event);
		//DKINFO("DKEventTargetDUK::onevent() \n");
		
		// get the globally stored js callback function
		DKString eventAddress = pointerToAddress(&event);
		DKString cb = event.target+"_"+event.type+"_callback";
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		//DKString eventObjStr = "var eventObj = new Event('', '', '"+eventAddress+"'); eventObj;";
		if (event.eventClass.empty()) {
			DKERROR("event->eventClass invalid! \n");
			return;
		}
		DKString eventObjStr = "var eventObj = new "+event.eventClass+"('', '', '"+eventAddress+"'); eventObj;";
		DukValue eventObj = dukglue_peval<DukValue>(DKDuktape::ctx, eventObjStr.c_str());
		dukglue_push(DKDuktape::ctx, eventObj);
		
		// call callback function
		if(duk_pcall(DKDuktape::ctx, 1) != 0) //1 = num or args
			DKDuktape::DumpError(eventAddress);
	}
};
REGISTER_OBJECT(DKEventTargetDUK, true)


#endif //DKEventTargetDUK_H
#endif //HAVE_DKDuktape