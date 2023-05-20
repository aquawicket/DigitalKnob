// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
#pragma once
#ifndef DKDragEventDUK_H
#define DKDragEventDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Exposed=Window]
// interface DragEvent : MouseEvent {
class DKDragEventDUK : public DKObjectT<DKDragEventDUK>
{
public:
	bool Init(){
		
		//constructor(DOMString type, optional DragEventInit eventInitDict = {});
		DKDuktape::AttachFunction("CPP_DKDragEventDUK", DKDragEventDUK::constructor);
	
		// readonly attribute DataTransfer? dataTransfer;
		DKDuktape::AttachFunction("CPP_DKDragEventDUK_dataTransfer", DKDragEventDUK::dataTransfer);
		
	
		////// Load .js files //////
		DKClass::DKCreate("DKDragEvent/DKDragEventDUK.js");
		
		return true;
	}
	
	
	static DKDragEvent* dragEvent(duk_context* ctx){
		DKString dragEventAddress = duk_require_string(ctx, 0);
		return (DKDragEvent*)addressToPointer(dragEventAddress);
	}
	
	//constructor(DOMString type, optional DragEventInit eventInitDict = {});
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString eventInitDict = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKDragEventDUK("+type+","+eventInitDict+")\n");
		DKDragEvent* dragEvent = new DKDragEvent(type, eventInitDict);
		DKString dragEventAddress = pointerToAddress(dragEvent);
		dukglue_push(ctx, dragEventAddress);	
		return true;
	}
	
	// readonly attribute DataTransfer? dataTransfer;
	static int dataTransfer(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		dukglue_push(ctx, dragEvent(ctx)->dataTransfer());
		return true;
	}
};
REGISTER_OBJECT(DKDragEventDUK, true)


#endif //DKDragEventDUK_H