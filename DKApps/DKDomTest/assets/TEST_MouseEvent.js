console.log("////// TEST_MouseEvent.js //////")

////// MouseEvent //////
function printMouseEventProperties(mouseevent){
	////// Static properties //////
	//console.log("mouseevent.WEBKIT_FORCE_AT_MOUSE_DOWN = "+mouseevent.WEBKIT_FORCE_AT_MOUSE_DOWN)
	//console.log("mouseevent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN = "+mouseevent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN)
	////// Instance properties //////
	console.log("mouseevent.altKey = "			+mouseevent.altKey)
	console.log("mouseevent.button = "			+mouseevent.button)
	console.log("mouseevent.buttons = "			+mouseevent.buttons)
	console.log("mouseevent.clientX = "			+mouseevent.clientX)
	console.log("mouseevent.clientY = "			+mouseevent.clientY)
	console.log("mouseevent.ctrlKey = "			+mouseevent.ctrlKey)
	console.log("mouseevent.layerX = "			+mouseevent.layerX)
	console.log("mouseevent.layerY = "			+mouseevent.layerY)
	console.log("mouseevent.metaKey = "			+mouseevent.metaKey)
	console.log("mouseevent.movementX = "		+mouseevent.movementX)
	console.log("mouseevent.movementY = "		+mouseevent.movementY)
	console.log("mouseevent.offsetX = "			+mouseevent.offsetX)
	console.log("mouseevent.offsetY = "			+mouseevent.offsetY)
	console.log("mouseevent.pageX = "			+mouseevent.pageX)
	console.log("mouseevent.pageY = "			+mouseevent.pageY)
	console.log("mouseevent.relatedTarget = "	+mouseevent.relatedTarget)
	console.log("mouseevent.screenX = "			+mouseevent.screenX)
	console.log("mouseevent.screenY = "			+mouseevent.screenY)
	console.log("mouseevent.shiftKey = "		+mouseevent.shiftKey)
	console.log("mouseevent.mozPressure = "		+mouseevent.mozPressure)
	console.log("mouseevent.mozInputSource = "	+mouseevent.mozInputSource)
	console.log("mouseevent.webkitForce = "		+mouseevent.webkitForce)
	console.log("mouseevent.x = "				+mouseevent.x)
	console.log("mouseevent.y = "				+mouseevent.y)
}