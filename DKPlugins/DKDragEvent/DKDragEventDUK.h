// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#if HAVE_DKDuktape

#pragma once
#ifndef DKDragEventDUK_H
#define DKDragEventDUK_H

#include "DKDuktape/DKDuktape.h"


// [Exposed=Window]
// interface DragEvent : MouseEvent {
class DKDragEventDUK : public DKObjectT<DKDragEventDUK>
{
public:
	bool Init(){
		
		//constructor(DOMString type, optional DragEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKDragEventDUK_constructor", 	DKDragEventDUK::constructor);
	
		// readonly attribute DataTransfer? dataTransfer;
		DKDuktape::AttachFunction("CPP_DKDragEventDUK_dataTransfer", 	DKDragEventDUK::dataTransfer);
//};
		
	
		////// Load .js files //////
		DKClass::DKCreate("DKDragEvent/DKDragEventDUK.js");
		
		return true;
	}
	
	
	static DKDragEvent* dragEvent(duk_context* ctx){
		DKString dragEventAddress = duk_require_string(ctx, 0);
		return (DKDragEvent*)addressToPointer(dragEventAddress);
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
	
	//constructor(DOMString type, optional DragEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "{}";	//duk_require_string(ctx, 1);
		
		DKINFO("CPP_DKDragEventDUK_constructor("+type+","+eventInitDict+")\n");
		DKDragEvent* dragEvent = new DKDragEvent(type, eventInitDict);
		dukglue_push(ctx, dragEvent->interfaceAddress);	
		return true;
	}
	
	// readonly attribute DataTransfer? dataTransfer;
	static int dataTransfer(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			dragEvent(ctx)->dataTransfer(GetString(ctx));
		dukglue_push(ctx, dragEvent(ctx)->dataTransfer());
		return true;
	}
};
REGISTER_OBJECT(DKDragEventDUK, true)


#endif //DKDragEventDUK_H
#endif //HAVE_DKDuktape