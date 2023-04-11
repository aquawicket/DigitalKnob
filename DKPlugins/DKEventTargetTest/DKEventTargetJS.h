#pragma once
#ifndef DKEventTargetJS_H
#define DKEventTargetJS_H

#include "DKDuktape/DKDuktape.h"
#include "DKEventTargetTest/DKEventTarget.h"


// [EventTarget] https://developer.mozilla.org/en-US/docs/Web/API/Event
class DKEventTargetJS : public DKObjectT<DKEventTargetJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKEventTarget", DKEventTargetJS::constructor);
		
		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKEventTarget_addEventListener", 	DKEventTargetJS::addEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTarget_removeEventListener", 	DKEventTargetJS::removeEventListener);
		DKDuktape::AttachFunction("CPP_DKEventTarget_dispatchEvent", 		DKEventTargetJS::dispatchEvent);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKEventTarget.js");
		DKClass::DKCreate("DKEventTargetTest/DKGlobalEventHandlers.js");
		return true;
	}
	
	
	////// Constructor //////
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKEventTarget()\n");
		DKEventTarget* eventTarget = new DKEventTarget();
		DKString eventTargetAddress = DKDuktape::pointerToAddress(eventTarget);
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
		//DKINFO("DKEventTargetJS::addEventListener("+targetAddress+", "+type+", callback)\n");
		
		// store the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		//DKINFO("DKEventTargetJS::addEventListener() -> "+cb+" \n")
		duk_dup(ctx, 2);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget* eventTarget = (DKEventTarget*)DKDuktape::addressToPointer(targetAddress);
		eventTarget->addEventListener(type, &DKEventTargetJS::onevent);
		
		return true;
	}
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
	static int removeEventListener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString type = duk_require_string(ctx, 1);
		duk_require_function(ctx, 2);
		//DKINFO("DKEventTargetJS::removeEventListener("+targetAddress+", "+type+", callback)\n");
		
		// remove the js callback function
		// How to persist Duktape/C arguments across calls
		// https://wiki.duktape.org/howtonativepersistentreferences#:~:text=When%20a%20Duktape%2FC%20function,safely%20work%20with%20the%20arguments.
		DKString cb = targetAddress+"_"+type+"_callback";
		duk_push_null(ctx);
		duk_put_global_string(ctx, cb.c_str());
		
		DKEventTarget* eventTarget = (DKEventTarget*)DKDuktape::addressToPointer(targetAddress);
		eventTarget->removeEventListener(type, &DKEventTargetJS::onevent);

		return true;
	}
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKString eventAddress = duk_require_string(ctx, 1);
		//DKINFO("DKEventTargetJS::dispatchEvent("+targetAddress+", "+eventAddress+")\n");
		
		DKEventTarget* eventTarget = (DKEventTarget*)DKDuktape::addressToPointer(targetAddress);
		DKEvent* event = (DKEvent*)DKDuktape::addressToPointer(eventAddress);
		eventTarget->dispatchEvent(*event);
		
		return true;
	}
	
	static void onevent(DKEvent& event) {
		DKDEBUGFUNC(event);
		//DKINFO("DKEventTargetJS::onevent() \n");
		
		// get the globally stored js callback function
		DKString eventAddress = DKDuktape::pointerToAddress(&event);
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
REGISTER_OBJECT(DKEventTargetJS, true)


#endif //DKEventTargetJS_H