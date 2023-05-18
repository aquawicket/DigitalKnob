// [IDL] https://html.spec.whatwg.org/multipage/dnd.html#the-dragevent-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/DragEvent
console.log("\n////// TEST_DragEvent.js //////")

function printDragEventProperties(dragevent){
	
	// constructor(DOMString type, optional DragEventInit eventInitDict = {});
	// function
	
	// readonly attribute DataTransfer? dataTransfer;
	console.log("dragevent.dataTransfer = "	+dragevent.dataTransfer)
}
