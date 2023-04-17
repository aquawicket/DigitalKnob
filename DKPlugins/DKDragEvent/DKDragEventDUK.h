#pragma once
#ifndef DKDragEventDUK_H
#define DKDragEventDUK_H

#include "DKDuktape/DKDuktape.h"


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
	
	
	////// Constructor //////
	// [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString type = duk_require_string(ctx, 0);
		DKString options = "";//duk_require_string(ctx, 1);
		DKINFO("CPP_DKDragEventDUK("+type+","+options+")\n");
		DKDragEvent* event = new DKDragEvent(type, options);
		DKString eventAddress = pointerToAddress(event);
		duk_push_string(ctx, eventAddress.c_str());	
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