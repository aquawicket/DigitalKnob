console.log("////// TEST_DKConsoleWindow.js //////")

function printConsoleWindowProperties(consolewindow){
	////// Instance properties //////
	console.log("consolewindow.columns = "	+consolewindow.columns)
	console.log("consolewindow.rows = "		+consolewindow.rows)
}


////// ConsoleWindow //////
const myConsoleWindow = new DKConsoleWindow()
//myConsoleWindow.moveTo(100,100)
//myConsoleWindow.resizeTo(800,600)
//myConsoleWindow.moveBy(-90,-90)
//myConsoleWindow.resizeBy(200,100)
//myConsoleWindow.blur()
//myConsoleWindow.focus()
//myConsoleWindow.close()
printWindowProperties(myConsoleWindow)			//requires TEST_Window.js
printConsoleWindowProperties(myConsoleWindow)




// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("onblur("+event+")")
	printEventProperties(event)			//requires TEST_Event.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
myConsoleWindow.addEventListener('blur', onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("onfocus("+event+")")
	printEventProperties(event)			//requires TEST_Event.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
myConsoleWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("onfocusin("+event+")")
	printEventProperties(event)			//requires TEST_Event.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
myConsoleWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("onfocusout("+event+")")
	printEventProperties(event)			//requires TEST_Event.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
myConsoleWindow.addEventListener('focusout', onfocusout)




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