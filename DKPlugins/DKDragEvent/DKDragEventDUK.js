// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent


// [Exposed=Window]
// interface DragEvent : MouseEvent {
// constructor(DOMString type, optional DragEventInit eventInitDict = {});
var DragEvent = function DragEvent(type, eventInitDict, address) {
	//console.log("DragEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKDragEventDUK_constructor(type, eventInitDict)
	
	
	// readonly attribute DataTransfer? dataTransfer;
	Object.defineProperty(this, "dataTransfer", {
        get: function dataTransfer()			{ return CPP_DKDragEventDUK_dataTransfer(this.address) },
		set: function dataTransfer(data) 		{ return CPP_DKDragEventDUK_dataTransfer(this.address, data) },
		configurable: true,
    })
//};
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object DragEvent]" }
		
	
	var event = MouseEvent.call(this, type, eventInitDict)
	// Make properties (Read Only) after assignment
	return event
};
DragEvent.prototype = MouseEvent.prototype;
