console.log("\n////// TEST_DKConsoleWindow.js //////")

function printConsoleWindowProperties(consolewindow){
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



////// FocusEvent //////
// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("onblur("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printEventProperties(event)			//requires TEST_Event.js
}
myConsoleWindow.addEventListener('blur', onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("onfocus("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printEventProperties(event)			//requires TEST_Event.js
}
myConsoleWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("onfocusin("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printEventProperties(event)			//requires TEST_Event.js
}
myConsoleWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("onfocusout("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
	printUIEventProperties(event)		//requires TEST_UIEvent.js
	printEventProperties(event)			//requires TEST_Event.js
}
myConsoleWindow.addEventListener('focusout', onfocusout)



////// MouseEvent //////
// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
function onauxclick(event){
	console.log("onauxclick("+event+")")	
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('auxclick', onauxclick)
// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
function onclick(event){
	console.log("onclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('click', onclick)
// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
function oncontextmenu(event){
	console.log("oncontextmenu("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('contextmenu', oncontextmenu)
// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
function ondblclick(event){
	console.log("ondblclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('dblclick', ondblclick)
// [DOMActivate](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/DOMActivate_event
function onDOMActivate(event){
	console.log("onDOMActivate("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('DOMActivate', onDOMActivate)
// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
function onmousedown(event){
	console.log("onmousedown("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mousedown', onmousedown)
// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
function onmouseenter(event){
	console.log("onmouseenter("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mouseenter', onmouseenter)
// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
function onmouseleave(event){
	console.log("onmouseleave("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mouseleave', onmouseleave)
// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
function onmousemove(event){
	console.log("onmousemove("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mousemove', onmousemove)
// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
function onmouseout(event){
	console.log("onmouseout("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mouseout', onmouseout)
// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
function onmouseover(event){
	console.log("onmouseover("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mouseover', onmouseover)
// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
function onmouseup(event){
	console.log("onmouseup("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('mouseup', onmouseup)
// [webkitmouseforcechanged](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcechanged_event
function onwebkitmouseforcechanged(event){
	console.log("onwebkitmouseforcechanged("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcechanged', onwebkitmouseforcechanged)
// [webkitmouseforcedown](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcedown_event
function onwebkitmouseforcedown(event){
	console.log("onwebkitmouseforcedown("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcedown', onwebkitmouseforcedown)
// [webkitmouseforceup](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforceup_event
function onwebkitmouseforceup(event){
	console.log("onwebkitmouseforceup("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforceup', onwebkitmouseforceup)
// [webkitmouseforcewillbegin](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcewillbegin_event
function onwebkitmouseforcewillbegin(event){
	console.log("onwebkitmouseforcewillbegin("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('webkitmouseforcewillbegin', onwebkitmouseforcewillbegin)


////// WheelEvent //////
// [mousewheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
function onmousewheel(event){
	console.log("onmousewheel("+event+")")
	printWheelEventProperties(event)
	printMouseEventProperties(event)
	printEventProperties(event)
	printUIEventProperties(event)
}
myConsoleWindow.addEventListener('mousewheel', onmousewheel)
// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
function onwheel(event){
	console.log("onwheel("+event+")")
	printWheelEventProperties(event)
	printMouseEventProperties(event)
	printEventProperties(event)
	printUIEventProperties(event)
}
myConsoleWindow.addEventListener('wheel', onwheel)


////// InputEvent //////
// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
function onbeforeinput(event){
	console.log("onbeforeinput("+event+")")
	printInputEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('beforeinput', onbeforeinput)
// [input] https://w3c.github.io/uievents/#event-type-input
function oninput(event){
	console.log("oninput("+event+")")
	printInputEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('input', oninput)



////// KeyboardEvent //////
// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
function onkeydown(event){
	console.log("onkeydown("+event+")")
	printKeyboardEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('keydown', onkeydown)
// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
function onkeyup(event){
	console.log("onkeyup("+event+")")
	printKeyboardEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('keyup', onkeyup)
// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
function onkeypress(event){
	console.log("onkeypress("+event+")")
	printKeyboardEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('keypress', onkeypress)



////// CompositionEvent //////
// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
function oncompositionstart(event){
	console.log("oncompositionstart("+event+")")
	printCompositionEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('compositionstart', oncompositionstart)
// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
function oncompositionupdate(event){
	console.log("oncompositionupdate("+event+")")
	printCompositionEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('compositionupdate', oncompositionupdate)
// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
function oncompositionend(event){
	console.log("oncompositionend("+event+")")
	printCompositionEventProperties(event)
	printUIEventProperties(event)
	printEventProperties(event)
}
myConsoleWindow.addEventListener('compositionend', oncompositionend)