const obj = new EventTarget();

////// Event ///////
function printEventProperties(event){
	////// Instance properties //////
	console.log("event.bubbles = "					+event.bubbles)
	console.log("event.cancelable = "				+event.cancelable)
	console.log("event.composed = "					+event.composed)
	console.log("event.currentTarget = "			+event.currentTarget)
	console.log("event.defaultPrevented = "			+event.defaultPrevented)
	console.log("event.eventPhase = "				+event.eventPhase)			
	console.log("event.isTrusted = "				+event.isTrusted)		
	console.log("event.target = "					+event.target)			
	console.log("event.timeStamp = "				+event.timeStamp)
	console.log("event.type = "						+event.type)
	////// Legacy and non-standard properties //////
	console.log("event.cancelBubble = "				+event.cancelBubble)
	console.log("event.explicitOriginalTarget = "	+event.explicitOriginalTarget)
	console.log("event.originalTarget = "			+event.originalTarget)
	console.log("event.returnValue = "				+event.returnValue)
	console.log("event.scoped = "					+event.scoped)
}
console.log('\n');
function onevent(event){
	console.log('onevent')
	printEventProperties(event)
}
const myEvent = new Event('event', {
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('event', onevent)
obj.dispatchEvent(myEvent);


////// CustomEvent //////
function printCustomEventProperties(customevent){
	////// Instance properties //////
	console.log("customevent.detail = "	+customevent.detail)
}
console.log('\n');
function oncustomevent(event){
	console.log('oncustomevent')
	printEventProperties(event)
	printCustomEventProperties(event)
}
const myCustomEvent = new CustomEvent('customevent', {
	detail: {
		username: "aquawicket"
	},
	
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('customevent', oncustomevent)
obj.dispatchEvent(myCustomEvent);



////// UIEvent //////
function printUIEventProperties(uievent){
	////// Instance properties //////
	console.log("uievent.detail = "				+uievent.detail)
	console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities)
	console.log("uievent.view = "				+uievent.view)
	console.log("uievent.which = "				+uievent.which)
}
console.log('\n');
function onuievent(event){
	console.log('onuievent')
	printEventProperties(event)
	printUIEventProperties(event)
}
const myUIEvent = new UIEvent('uievent', {
	detail: 99,
	//view: [object Window],
	//sourceCapabilities: [object InputDeviceCapabilities],
	
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('uievent', onuievent)
obj.dispatchEvent(myUIEvent);



////// FocusEvent //////
function printFocusEventProperties(focusevent){
	////// Instance properties //////
	console.log("focusevent.relatedTarget = "	+focusevent.relatedTarget)
}
console.log('\n');
function onfocusevent(event){
	console.log('onfocusevent')
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
const myFocusEvent = new FocusEvent('focusevent', {
	relatedTarget: "CHANGED",
	
	detail: 99,
	//view: [object Window],
	//sourceCapabilities: [object InputDeviceCapabilities],
	
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('focusevent', onfocusevent)
obj.dispatchEvent(myFocusEvent);



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
console.log('\n');
function onmouseevent(event){
	console.log('onmouseevent')
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
const myMouseEvent = new MouseEvent('mouseevent', {
	altKey: true,
	clientX: 99,
	clientY: 99,
	ctrlKey: true,
	metaKey: true,
	screenX: 99,
	screenY: 99,
	shiftKey: true,
	
	detail: 99,
	//view: [object Window],
	//sourceCapabilities: [object InputDeviceCapabilities],
	
	bubbles: true,
	cancelable: true,
	composed: true
})


obj.addEventListener('mouseevent', onmouseevent)
obj.dispatchEvent(myMouseEvent);



////// WheelEvent //////
function printWheelEventProperties(wheelevent){
	////// Instance properties //////
	console.log("wheelevent.deltaX = "		+wheelevent.deltaX)
	console.log("wheelevent.deltaY = "		+wheelevent.deltaY)
	console.log("wheelevent.deltaZ = "		+wheelevent.deltaZ)
	console.log("wheelevent.deltaMode = "	+wheelevent.deltaMode)
	console.log("wheelevent.wheelDelta = "	+wheelevent.wheelDelta)
	console.log("wheelevent.wheelDeltaX = "	+wheelevent.wheelDeltaX)
	console.log("wheelevent.wheelDeltaY = "	+wheelevent.wheelDeltaY)
}

console.log('\n');
function onwheelevent(event){
	console.log('onwheelevent')
	printEventProperties(event)
	printUIEventProperties(event)
	printWheelEventProperties(event)
}
const myWheelEvent = new WheelEvent('wheelevent', {
	deltaX: 9.9,
	deltaY: 9.9,
	deltaZ: 9.9,
	deltaMode: 9,
	
	altKey: true,
	clientX: 99,
	clientY: 99,
	ctrlKey: true,
	metaKey: true,
	screenX: 99,
	screenY: 99,
	shiftKey: true,
	
	detail: 99,
	//view: [object Window],
	//sourceCapabilities: [object InputDeviceCapabilities],
	
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('wheelevent', onwheelevent)
obj.dispatchEvent(myWheelEvent);



////// InputEvent //////
function printInputEventProperties(inputevent){
	////// Instance properties //////
	console.log("inputevent.data = "		+inputevent.data)
	console.log("inputevent.dataTransfer = "+inputevent.dataTransfer)
	console.log("inputevent.inputType = "	+inputevent.inputType)
	console.log("inputevent.isComposing = "	+inputevent.isComposing)
}
console.log('\n');
function oninputevent(event){
	console.log('oninputevent')
	printEventProperties(event)
	printUIEventProperties(event)
	printInputEventProperties(event)
}
const myInputEvent = new InputEvent('inputevent', {
	inputType: "CHANGED",
	data: "CHANGED",
	isComposing: true,
	
	detail: 99,
	//view: [object Window],
	//sourceCapabilities: [object InputDeviceCapabilities],
	
	bubbles: true,
	cancelable: true,
	composed: true
})
obj.addEventListener('inputevent', oninputevent)
obj.dispatchEvent(myInputEvent);