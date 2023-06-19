// [IDL] https://dom.spec.whatwg.org/#interface-event
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Event
#if HAVE_DKDuktape

#pragma once
#ifndef DKEventDUK_H
#define DKEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface Event {
class DKEventDUK : public DKObjectT<DKEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional EventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKEventDUK_constructor", 				DKEventDUK::constructor); 
		
		// readonly attribute DOMString type;
		DKDuktape::AttachFunction("CPP_DKEventDUK_type", 						DKEventDUK::type);
		
		// readonly attribute EventTarget? target;
		DKDuktape::AttachFunction("CPP_DKEventDUK_target", 						DKEventDUK::target);
		
		// readonly attribute EventTarget? srcElement; // legacy
		DKDuktape::AttachFunction("CPP_DKEventDUK_srcElement", 					DKEventDUK::srcElement);
		
		// readonly attribute EventTarget? currentTarget;
		DKDuktape::AttachFunction("CPP_DKEventDUK_currentTarget", 				DKEventDUK::currentTarget);
		
		// sequence<EventTarget> composedPath();
		DKDuktape::AttachFunction("CPP_DKEventDUK_composedPath", 				DKEventDUK::composedPath);
		
		// const unsigned short NONE = 0;
		DKDuktape::AttachFunction("CPP_DKEventDUK_NONE", 						DKEventDUK::NONE);
		
		// const unsigned short CAPTURING_PHASE = 1;
		DKDuktape::AttachFunction("CPP_DKEventDUK_CAPTURING_PHASE", 			DKEventDUK::CAPTURING_PHASE);
	
		// const unsigned short AT_TARGET = 2;
		DKDuktape::AttachFunction("CPP_DKEventDUK_AT_TARGET", 					DKEventDUK::AT_TARGET);
	
		// const unsigned short BUBBLING_PHASE = 3;
		DKDuktape::AttachFunction("CPP_DKEventDUK_BUBBLING_PHASE", 				DKEventDUK::BUBBLING_PHASE);
		
		// readonly attribute unsigned short eventPhase;
		DKDuktape::AttachFunction("CPP_DKEventDUK_eventPhase", 					DKEventDUK::eventPhase);
		
		// undefined stopPropagation();
		DKDuktape::AttachFunction("CPP_DKEventDUK_stopPropagation", 			DKEventDUK::stopPropagation);
		
		// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
		DKDuktape::AttachFunction("CPP_DKEventDUK_cancelBubble", 				DKEventDUK::cancelBubble);
		
		// undefined stopImmediatePropagation();
		DKDuktape::AttachFunction("CPP_DKEventDUK_stopImmediatePropagation",	DKEventDUK::stopImmediatePropagation);
		
		// readonly attribute boolean bubbles;
		DKDuktape::AttachFunction("CPP_DKEventDUK_bubbles", 					DKEventDUK::bubbles);
		
		// readonly attribute boolean cancelable;
		DKDuktape::AttachFunction("CPP_DKEventDUK_cancelable", 					DKEventDUK::cancelable);
		
		// attribute boolean returnValue;  // legacy
		DKDuktape::AttachFunction("CPP_DKEventDUK_returnValue", 				DKEventDUK::returnValue);
		
		// undefined preventDefault();
		DKDuktape::AttachFunction("CPP_DKEventDUK_preventDefault", 				DKEventDUK::preventDefault);
		
		// readonly attribute boolean defaultPrevented;
		DKDuktape::AttachFunction("CPP_DKEventDUK_defaultPrevented", 			DKEventDUK::defaultPrevented);
		
		// readonly attribute boolean composed;
		DKDuktape::AttachFunction("CPP_DKEventDUK_composed", 					DKEventDUK::composed);
		
		// [LegacyUnforgeable] readonly attribute boolean isTrusted;
		DKDuktape::AttachFunction("CPP_DKEventDUK_isTrusted", 					DKEventDUK::isTrusted);
		
		// readonly attribute DOMHighResTimeStamp timeStamp;
		DKDuktape::AttachFunction("CPP_DKEventDUK_timeStamp", 					DKEventDUK::timeStamp);
		
		// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
		DKDuktape::AttachFunction("CPP_DKEventDUK_initEvent", 					DKEventDUK::initEvent);
		
		
		////// Load .js files
		DKClass::DKCreate("DKEvent/DKEventDUK.js");
		
		return true;
	}
	
	static DKEvent* event(duk_context* ctx){
		DKString eventAddress = duk_require_string(ctx, 0);
		return (DKEvent*)addressToPointer(eventAddress);
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
	
	// constructor(DOMString type, optional EventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DOMString type = duk_require_string(ctx, 0);
		EventInit eventInitDict = "{}";		//duk_require_string(ctx, 1);
		DKINFO("CPP_DKEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKEvent* event = new DKEvent(type, eventInitDict);
		dukglue_push(ctx, pointerToAddress(event));
		return true;
	}
	
	// readonly attribute DOMString type;
	static int type(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->type(GetString(ctx));
		dukglue_push(ctx, event(ctx)->type());
		return true;
	}
	
	// readonly attribute EventTarget? target;
	static int target(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->target(*(DKEventTarget*)addressToPointer(GetString(ctx)));
		dukglue_push(ctx, pointerToAddress(&event(ctx)->target()));
		return true;
	}
	
	// readonly attribute EventTarget? srcElement; // legacy
	static int srcElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->srcElement(*(DKEventTarget*)addressToPointer(GetString(ctx)));
		dukglue_push(ctx, pointerToAddress(&event(ctx)->srcElement()));
		return true;
	}
	
	// readonly attribute EventTarget? currentTarget;
	static int currentTarget(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->currentTarget(*(DKEventTarget*)addressToPointer(GetString(ctx)));
		dukglue_push(ctx, pointerToAddress(&event(ctx)->currentTarget()));
		return true;
	}
	
	// sequence<EventTarget> composedPath();
	static int composedPath(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// const unsigned short NONE = 0;
	static int NONE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//if(duk_is_valid_index(ctx, 1))
		//	event(ctx)->NONE((unsigned short)GetUint(ctx));
		dukglue_push(ctx, event(ctx)->NONE());
		return true;
	}
	
	// const unsigned short CAPTURING_PHASE = 1;
	static int CAPTURING_PHASE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//if(duk_is_valid_index(ctx, 1))
		//	event(ctx)->CAPTURING_PHASE((unsigned short)GetUint(ctx));
		dukglue_push(ctx, event(ctx)->CAPTURING_PHASE());
		return true;
	}
	
	// const unsigned short AT_TARGET = 2;
	static int AT_TARGET(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//if(duk_is_valid_index(ctx, 1))
		//	event(ctx)->AT_TARGET((unsigned short)GetUint(ctx));
		dukglue_push(ctx, event(ctx)->AT_TARGET());
		return true;
	}
	
	// const unsigned short BUBBLING_PHASE = 3;
	static int BUBBLING_PHASE(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//if(duk_is_valid_index(ctx, 1))
		//	event(ctx)->BUBBLING_PHASE((unsigned short)GetUint(ctx));
		dukglue_push(ctx, event(ctx)->BUBBLING_PHASE());
		return true;
	}
	
	// readonly attribute unsigned short eventPhase;
	static int eventPhase(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->eventPhase((unsigned short)GetUint(ctx));
		dukglue_push(ctx, event(ctx)->eventPhase());
		return true;
	}
	
	// undefined stopPropagation();
	static int stopPropagation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// attribute boolean cancelBubble; // legacy alias of .stopPropagation()
	static int cancelBubble(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->cancelBubble(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->cancelBubble());
		return true;
	}
	
	// undefined stopImmediatePropagation();
	static int stopImmediatePropagation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// readonly attribute boolean bubbles;
	static int bubbles(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->bubbles(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->bubbles());
		return true;
	}
	
	// readonly attribute boolean cancelable;
	static int cancelable(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->cancelable(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->cancelable());
		return true;
	}
	
	// attribute boolean returnValue;  // legacy
	static int returnValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->returnValue(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->returnValue());
		return true;
	}
	
	// undefined preventDefault();
	static int preventDefault(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// readonly attribute boolean defaultPrevented;
	static int defaultPrevented(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->defaultPrevented(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->defaultPrevented());
		return true;
	}
	
	// readonly attribute boolean composed;
	static int composed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->composed(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->composed());
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute boolean isTrusted;
	static int isTrusted(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->isTrusted(GetBool(ctx));
		dukglue_push(ctx, event(ctx)->isTrusted());
		return true;
	}
	
	// readonly attribute DOMHighResTimeStamp timeStamp;
	static int timeStamp(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			event(ctx)->timeStamp(GetDouble(ctx));
		dukglue_push(ctx, event(ctx)->timeStamp());
		return true;
	}
	
	// undefined initEvent(DOMString type, optional boolean bubbles = false, optional boolean cancelable = false); // legacy
	static int initEvent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _type = GetString(ctx, 1);
		bool _bubbles = GetBool(ctx, 2);
		bool _cancelable = GetBool(ctx, 3);
		event(ctx)->initEvent(_type, _bubbles, _cancelable);
		return DKTODO();
	}
};
REGISTER_OBJECT(DKEventDUK, true)


#endif //DKEventDUK_H
#endif //HAVE_DKDuktape
