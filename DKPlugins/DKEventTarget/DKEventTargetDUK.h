// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/EventTarget.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
#if HAVE_DKDuktape

#pragma once
#ifndef DKEventTargetDUK_H
#define DKEventTargetDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKEventTarget/DKEventTarget.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
class DKEventTargetDUK : public DKObjectT<DKEventTargetDUK>
{
public:
	bool Init(){
		
		// constructor();
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_constructor", 			DKEventTargetDUK::constructor);
		
		// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_addEventListener", 		DKEventTargetDUK::addEventListener);
		
		// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_removeEventListener", 	DKEventTargetDUK::removeEventListener);
		
		// boolean dispatchEvent(Event event);
		DKDuktape::AttachFunction("CPP_DKEventTargetDUK_dispatchEvent", 		DKEventTargetDUK::dispatchEvent);
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKEventTarget/DKEventTargetDUK.js");
		//DKClass::DKCreate("DKEventTarget/DKGlobalEventHandlersDUK.js");
		return true;
	}
	
	
	// constructor();
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKEventTargetDUK_constructor()\n");
		DKEventTarget* eventTarget = new DKEventTarget();
		dukglue_push(ctx, pointerToAddress(eventTarget));
		return true;
	}
	
	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
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
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
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
	
	// boolean dispatchEvent(Event event);
	static int dispatchEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString targetAddress = duk_require_string(ctx, 0);
		DKEventTarget* eventTarget = (DKEventTarget*)addressToPointer(targetAddress);
		
		DKString eventAddress = duk_require_string(ctx, 1);
		DKEvent* event = (DKEvent*)addressToPointer(eventAddress);
		
		//DKINFO("DKEventTargetDUK::dispatchEvent("+targetAddress+", "+eventAddress+")\n");
		bool _dispatchEvent = eventTarget->dispatchEvent(event);
		dukglue_push(DKDuktape::ctx, _dispatchEvent);
		return true;
	}
	
	static void onevent(DKEvent* event) {
		DKDEBUGFUNC(event);
		if(!event){
			DKERROR("event is invalid! \n");
			return;
		}
		
		DKString eventAddress = pointerToAddress(event);
		DKString eventTargetAddress = pointerToAddress(event->target());
		DKString cb = eventTargetAddress+"_"+event->type()+"_callback";
		
		duk_get_global_string(DKDuktape::ctx, cb.c_str());
		
		// create and push the Event(eventAddress) object		
		if (event->interfaceName.empty()) {
			DKERROR("event->interfaceName invalid! \n");
			return;
		}
		DKString eventObjStr = "var eventObj = new "+event->interfaceName+"('', '', '"+eventAddress+"'); eventObj;";
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