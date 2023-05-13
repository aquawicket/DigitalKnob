// [IDL] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/WheelEvent
console.log("\n////// TEST_WheelEvent.js //////")


function printWheelEventProperties(wheelevent){
	console.log("wheelevent.deltaX = "		+wheelevent.deltaX)
	console.log("wheelevent.deltaY = "		+wheelevent.deltaY)
	console.log("wheelevent.deltaZ = "		+wheelevent.deltaZ)
	console.log("wheelevent.deltaMode = "	+wheelevent.deltaMode)
	console.log("wheelevent.wheelDelta = "	+wheelevent.wheelDelta)
	console.log("wheelevent.wheelDeltaX = "	+wheelevent.wheelDeltaX)
	console.log("wheelevent.wheelDeltaY = "	+wheelevent.wheelDeltaY)
}