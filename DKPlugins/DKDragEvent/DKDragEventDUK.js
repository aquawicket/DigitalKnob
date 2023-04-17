// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent


// [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
var DragEvent = function DragEvent(type, options, address) {
	//console.log("DragEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKDragEventDUK(type, options)
	
	
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
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object DragEvent]" }
		
	
	var event = MouseEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	
	return event
};
DragEvent.prototype = MouseEvent.prototype;
