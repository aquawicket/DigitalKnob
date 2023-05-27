// [IDL] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
console.log("\n////// TEST_WheelEvent.js //////")


function printWheelEventProperties(wheelevent){
	
	// constructor(DOMString type, optional WheelEventInit eventInitDict = {});
	// function
	
	// DeltaModeCode
	// const unsigned long DOM_DELTA_PIXEL = 0x00;
	console.log("wheelevent.DOM_DELTA_PIXEL = "		+wheelevent.DOM_DELTA_PIXEL)
	
	// const unsigned long DOM_DELTA_LINE  = 0x01;
	console.log("wheelevent.DOM_DELTA_LINE = "		+wheelevent.DOM_DELTA_LINE)
	
	// const unsigned long DOM_DELTA_PAGE  = 0x02;
	console.log("wheelevent.DOM_DELTA_PAGE = "		+wheelevent.DOM_DELTA_PAGE)
	
	// readonly attribute double deltaX;
	console.log("wheelevent.deltaX = "		+wheelevent.deltaX)
	
	// readonly attribute double deltaY;
	console.log("wheelevent.deltaY = "		+wheelevent.deltaY)
	
	// readonly attribute double deltaZ;
	console.log("wheelevent.deltaZ = "		+wheelevent.deltaZ)
	
	// readonly attribute unsigned long deltaMode;
	console.log("wheelevent.deltaMode = "	+wheelevent.deltaMode)
	
	
	printMouseEventProperties(wheelEvent);
}

function onWheelEvent(event){
	console.log("onWheelEvent() \n");
	printWheelEventProperties(event);
}


var wheelEventTarget = new EventTarget();
wheelEventTarget.addEventListener("wheelEvent", onWheelEvent);
var wheelEvent = new WheelEvent("wheelEvent", "");
wheelEventTarget.dispatchEvent(wheelEvent);