// create EventTarget
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
const myEventA = new Event('myeventA');
obj.addEventListener('myeventA', function(event){
	console.log('onmyeventA')
	printEventProperties(event)
})
obj.dispatchEvent(myEventA);

console.log('\n');
obj.addEventListener('myeventB', function(event){
	console.log('onmyeventB')
	printEventProperties(event)
})
obj.dispatchEvent(new Event('myeventB'));



////// CustomEvent //////
function printCustomEventProperties(customevent){
	////// Instance properties //////
	console.log("customevent.detail = "	+customevent.detail)
}

console.log('\n');
const myCustomEvent = new CustomEvent('customevent');
obj.addEventListener('customevent', function(event){
	console.log('oncustomevent')
	printEventProperties(event)
	printCustomEventProperties(event)
})
obj.dispatchEvent(myCustomEvent);



/////////////////// ConsoleWindow //////////////////////////
console.log("/////////// ConsoleWindow /////////////////////")
CPP_DK_Create("DKEventTest/DKConsoleWindow.js");
const myConsoleWindow = new DKConsoleWindow('myConsoleWindow')



////// UIEvent //////
function printUIEventProperties(uievent){
	////// Instance properties //////
	console.log("uievent.detail = "				+uievent.detail)
	console.log("uievent.sourceCapabilities = "	+uievent.sourceCapabilities)			
	console.log("uievent.view = "				+uievent.view)
	console.log("uievent.which = "				+uievent.which)
}
console.log('\n');
const myUIEvent = new UIEvent('uievent');
obj.addEventListener('uievent', function(event){
	console.log('onuievent')
	printEventProperties(event)
	printUIEventProperties(event)
})
obj.dispatchEvent(myUIEvent);



////// FocusEvent ///////
function printFocusEventProperties(focusevent){
	////// Instance properties //////
	console.log("focusevent.relatedTarget = "	+focusevent.relatedTarget)
}
// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("onblur("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('blur', onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("onfocus("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("onfocusin("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("onfocusout("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printFocusEventProperties(event)
}
myConsoleWindow.addEventListener('focusout', onfocusout)



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
// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
function onauxclick(event){
	console.log("onauxclick("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('auxclick', onauxclick)
// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
function onclick(event){
	console.log("onclick("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('click', onclick)
// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
function oncontextmenu(event){
	console.log("oncontextmenu("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('contextmenu', oncontextmenu)
// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
function ondblclick(event){
	console.log("ondblclick("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('dblclick', ondblclick)
// [DOMActivate](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/DOMActivate_event
function onDOMActivate(event){
	console.log("onDOMActivate("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('DOMActivate', onDOMActivate)
// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
function onmousedown(event){
	console.log("onmousedown("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mousedown', onmousedown)
// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
function onmouseenter(event){
	console.log("onmouseenter("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseenter', onmouseenter)
// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
function onmouseleave(event){
	console.log("onmouseleave("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseleave', onmouseleave)
// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
function onmousemove(event){
	console.log("onmousemove("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mousemove', onmousemove)
// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
function onmouseout(event){
	console.log("onmouseout("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseout', onmouseout)
// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
function onmouseover(event){
	console.log("onmouseover("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseover', onmouseover)
// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
function onmouseup(event){
	console.log("onmouseup("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('mouseup', onmouseup)
// [webkitmouseforcechanged](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcechanged_event
function onwebkitmouseforcechanged(event){
	console.log("onwebkitmouseforcechanged("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcechanged', onwebkitmouseforcechanged)
// [webkitmouseforcedown](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcedown_event
function onwebkitmouseforcedown(event){
	console.log("onwebkitmouseforcedown("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcedown', onwebkitmouseforcedown)
// [webkitmouseforceup](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforceup_event
function onwebkitmouseforceup(event){
	console.log("onwebkitmouseforceup("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforceup', onwebkitmouseforceup)
// [webkitmouseforcewillbegin](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcewillbegin_event
function onwebkitmouseforcewillbegin(event){
	console.log("onwebkitmouseforcewillbegin("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcewillbegin', onwebkitmouseforcewillbegin)



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
// [mousewheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
function onmousewheel(event){
	console.log("onmousewheel("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
	printWheelEventProperties(event)
}
myConsoleWindow.addEventListener('mousewheel', onmousewheel)
// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
function onwheel(event){
	console.log("onwheel("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printMouseEventProperties(event)
	printWheelEventProperties(event)
}
myConsoleWindow.addEventListener('wheel', onwheel)



////// InputEvent //////
function printInputEventProperties(inputevent){
	////// Instance properties //////
	console.log("inputevent.data = "		+inputevent.data)
	console.log("inputevent.dataTransfer = "+inputevent.dataTransfer)
	console.log("inputevent.inputType = "	+inputevent.inputType)
	console.log("inputevent.isComposing = "	+inputevent.isComposing)
}
// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
function onbeforeinput(event){
	console.log("onbeforeinput("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printInputEventProperties(event)
}
myConsoleWindow.addEventListener('beforeinput', onbeforeinput)
// [input] https://w3c.github.io/uievents/#event-type-input
function oninput(event){
	console.log("oninput("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printInputEventProperties(event)
}
myConsoleWindow.addEventListener('input', oninput)



////// KeyboardEvent ///////
function printKeyboardEventProperties(keyboardevent){
	////// Instance properties //////
	console.log("keyboardevent.altKey = "		+keyboardevent.altKey)
	console.log("keyboardevent.code = "			+keyboardevent.code)			
	console.log("keyboardevent.ctrlKey = "		+keyboardevent.ctrlKey)
	console.log("keyboardevent.isComposing = "	+keyboardevent.isComposing)
	console.log("keyboardevent.key = "			+keyboardevent.key)
	console.log("keyboardevent.locale = "		+keyboardevent.locale)
	console.log("keyboardevent.location = "		+keyboardevent.location)
	console.log("keyboardevent.metaKey = "		+keyboardevent.metaKey)
	console.log("keyboardevent.repeat = "		+keyboardevent.repeat)
	console.log("keyboardevent.shiftKey = "		+keyboardevent.shiftKey)
	////// Obsolete properties //////
	console.log("keyboardevent.char = "			+keyboardevent.char)
	console.log("keyboardevent.charCode = "		+keyboardevent.charCode)
	console.log("keyboardevent.keyCode = "		+keyboardevent.keyCode)
	console.log("keyboardevent.keyIdentifier = "+keyboardevent.keyIdentifier)
	console.log("keyboardevent.keyLocation = "	+keyboardevent.keyLocation)
	console.log("keyboardevent.which = "		+keyboardevent.which)
}
// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
function onkeydown(event){
	console.log("onkeydown("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keydown', onkeydown)
// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
function onkeyup(event){
	console.log("onkeyup("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keyup', onkeyup)
// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
function onkeypress(event){
	console.log("onkeypress("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printKeyboardEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onkeypress)



///// CompositionEvent //////
function printCompositionEventProperties(compositionevent){
	////// Instance properties //////
	console.log("compositionevent.data = "		+compositionevent.data)
	console.log("compositionevent.locale = "	+compositionevent.locale)
}
// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
function oncompositionstart(event){
	console.log("oncompositionstart("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printCompositionEventProperties(event)
}
myConsoleWindow.addEventListener('compositionstart', oncompositionstart)
// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
function oncompositionupdate(event){
	console.log("oncompositionupdate("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printCompositionEventProperties(event)
}
myConsoleWindow.addEventListener('compositionupdate', oncompositionupdate)
// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
function oncompositionend(event){
	console.log("oncompositionend("+event+")")
	printEventProperties(event)
	printUIEventProperties(event)
	printCompositionEventProperties(event)
}
myConsoleWindow.addEventListener('compositionend', oncompositionend)