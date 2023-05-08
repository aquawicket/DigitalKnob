#pragma once
#ifndef DKDragEventDUK_H
#define DKDragEventDUK_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE

// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
class DKDragEventDUK : public DKObjectT<DKDragEventDUK>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKDragEventDUK", DKDragEventDUK::constructor);
	
	
		////// Instance properties //////
		// [DragEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer

		
		////// Event types //////
		// [drag] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
		// [dragend] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
		// [dragenter] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
		// [dragleave] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
		// [dragover] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
		// [dragstart] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
		// [drop] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
	
	
		////// Load .js files //////
		DKClass::DKCreate("DKDragEvent/DKDragEventDUK.js");
		
		return true;
	}
	
	
	static DKDragEvent* dragEvent(duk_context* ctx){
		DKString dragEventAddress = duk_require_string(ctx, 0);
		return (DKDragEvent*)addressToPointer(dragEventAddress);
	}
	
	////// Constructor //////
	// [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
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
	
	
	////// Instance properties //////
	// [DragEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer
	
	
	////// Event types //////
	// [drag] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
	// [dragend] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
	// [dragenter] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
	// [dragleave] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
	// [dragover] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
	// [dragstart] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
	// [drop] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
	
};
REGISTER_OBJECT(DKDragEventDUK, true)


#endif //DKDragEventDUK_H