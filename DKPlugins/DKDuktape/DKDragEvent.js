// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
// [INTERFACE] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface


// [DragEvent()] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/DragEvent
var DragEvent = function(_type, _dragEventInit, _pointer) {

    ////// Instance properties //////
	// [DragEvent.dataTransfer] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent/dataTransfer
    Object.defineProperty(this, "dataTransfer", { //Read only
        get: function dataTransfer() {
            return CPP_DKDragEvent_dataTransfer(_pointer)
        }
    })

	////// Event types //////
	// [drag]		https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drag_event
	// [dragend]	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragend_event
	// [dragenter]	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragenter_event
	// [dragleave]	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragleave_event
	// [dragover]	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragover_event
	// [dragstart]	https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dragstart_event
	// [drop]		https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/drop_event
    
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object DragEvent]"
		}
	}
	
    return MouseEvent.call(this, _type, _dragEventInit, _pointer)
}
DragEvent.prototype = MouseEvent.prototype


///////////////////////////////////////////////////////
function doDragEvent(_type, _dragEventInit, _pointer) {
	const event = new DragEvent(_type, _dragEventInit, _pointer)
	event.target = new EventTarget(_pointer)
	event.target.dispatchEvent(event)
}
