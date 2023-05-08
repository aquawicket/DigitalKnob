// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/WheelEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
#pragma once
#ifndef DKWheelEventDUK_H
#define DKWheelEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface WheelEvent : MouseEvent {
class DKWheelEventDUK : public DKObjectT<DKWheelEventDUK>
{
public:
	bool Init(){
		
		// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKWheelEventDUK", DKWheelEventDUK::constructor);
	
		// DeltaModeCode
		// const unsigned long DOM_DELTA_PIXEL = 0x00;
		
		// const unsigned long DOM_DELTA_LINE  = 0x01;
		
		// const unsigned long DOM_DELTA_PAGE  = 0x02;
	
		// readonly attribute double deltaX;
		DKDuktape::AttachFunction("CPP_DKWheelEventDUK_deltaX", 		DKWheelEventDUK::deltaX); 
		
		// readonly attribute double deltaY;
		DKDuktape::AttachFunction("CPP_DKWheelEventDUK_deltaY", 		DKWheelEventDUK::deltaY); 
		
		// readonly attribute double deltaZ;
		DKDuktape::AttachFunction("CPP_DKWheelEventDUK_deltaZ",		DKWheelEventDUK::deltaZ); 
		
		// readonly attribute unsigned long deltaMode;
		DKDuktape::AttachFunction("CPP_DKWheelEventDUK_deltaMode", 	DKWheelEventDUK::deltaMode);
		

		////// Load .js files //////
		DKClass::DKCreate("DKWheelEvent/DKWheelEventDUK.js");
		
		return true;
	}
	
	
	static DKWheelEvent* wheelEvent(duk_context* ctx){
		DKString wheelEventAddress = duk_require_string(ctx, 0);
		return (DKWheelEvent*)addressToPointer(wheelEventAddress);
	}
	
	// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKWheelEventDUK("+type+","+eventInitDict+")\n");
		DKWheelEvent* wheelEvent = new DKWheelEvent(type, eventInitDict);
		DKString wheelEventAddress = pointerToAddress(wheelEvent);
		dukglue_push(ctx, wheelEventAddress);	
		return true;
	}
	
	// DeltaModeCode
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
		
	// const unsigned long DOM_DELTA_LINE  = 0x01;
		
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
		
	// readonly attribute double deltaX;
	static int deltaX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			wheelEvent(ctx)->deltaX = duk_to_number(ctx, 1);
		dukglue_push(ctx, wheelEvent(ctx)->deltaX);	
		return true;
	}
	
	// readonly attribute double deltaY;
	static int deltaY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			wheelEvent(ctx)->deltaY = duk_to_number(ctx, 1);
		dukglue_push(ctx, wheelEvent(ctx)->deltaY);	
		return true;
	}
		
	// readonly attribute double deltaZ;
	static int deltaZ(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			wheelEvent(ctx)->deltaZ = duk_to_number(ctx, 1);
		dukglue_push(ctx, wheelEvent(ctx)->deltaZ);	
		return true;
	}	
		
	// readonly attribute unsigned long deltaMode;
	static int deltaMode(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if (duk_is_number(ctx, 1))
			wheelEvent(ctx)->deltaMode = duk_to_uint(ctx, 1);
		dukglue_push(ctx, wheelEvent(ctx)->deltaMode);	
		return true;
	}	
};
REGISTER_OBJECT(DKWheelEventDUK, true)


#endif //DKWheelEventDUK_H