console.log("\n////// TEST_DKConsoleWindow.js //////")

function printConsoleWindowProperties(consolewindow){
	//console.log("consolewindow.columns = "	+consolewindow.columns);	// TODO
	//console.log("consolewindow.rows = "		+consolewindow.rows);		// TODO
	
	printWindowProperties(consolewindow);		//requires TEST_Window.js
}


////// DKConsoleWindow //////
const dkConsoleWindow = new DKConsoleWindow()
printConsoleWindowProperties(dkConsoleWindow);
//dkConsoleWindow.moveTo(100,100)
//dkConsoleWindow.resizeTo(800,600)
//dkConsoleWindow.moveBy(-90,-90)
//dkConsoleWindow.resizeBy(200,100)
//dkConsoleWindow.blur()
//dkConsoleWindow.focus()
//dkConsoleWindow.close()



////// FocusEvent //////
// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("\n onblur("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkConsoleWindow.addEventListener("blur", onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("\n onfocus("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkConsoleWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("\n onfocusin("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkConsoleWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("\n onfocusout("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkConsoleWindow.addEventListener('focusout', onfocusout)



////// MouseEvent //////
// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
function onauxclick(event){
	console.log("\n onauxclick("+event+")")	
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('auxclick', onauxclick)
// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
function onclick(event){
	console.log("\n onclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('click', onclick)
// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
function oncontextmenu(event){
	console.log("\n oncontextmenu("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('contextmenu', oncontextmenu)
// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
function ondblclick(event){
	console.log("\n ondblclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('dblclick', ondblclick)
// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
function onmousedown(event){
	console.log("\n onmousedown("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mousedown', onmousedown)
// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
function onmouseenter(event){
	console.log("\n onmouseenter("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mouseenter', onmouseenter)
// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
function onmouseleave(event){
	console.log("\n onmouseleave("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mouseleave', onmouseleave)
// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
function onmousemove(event){
	console.log("\n onmousemove("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mousemove', onmousemove)
// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
function onmouseout(event){
	console.log("\n onmouseout("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mouseout', onmouseout)
// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
function onmouseover(event){
	console.log("\n onmouseover("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mouseover', onmouseover)
// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
function onmouseup(event){
	console.log("\n onmouseup("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkConsoleWindow.addEventListener('mouseup', onmouseup)


////// WheelEvent //////
// [mousewheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
function onmousewheel(event){
	console.log("\n onmousewheel("+event+")")
	printWheelEventProperties(event)		//requires TEST_WheelEvent.js
}
dkConsoleWindow.addEventListener('mousewheel', onmousewheel)
// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
function onwheel(event){
	console.log("\n onwheel("+event+")")		//requires TEST_WheelEvent.js
	printWheelEventProperties(event)
}
dkConsoleWindow.addEventListener('wheel', onwheel)


////// InputEvent //////
// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
function onbeforeinput(event){
	console.log("\n onbeforeinput("+event+")")
	printInputEventProperties(event)
}
dkConsoleWindow.addEventListener('beforeinput', onbeforeinput)
// [input] https://w3c.github.io/uievents/#event-type-input
function oninput(event){
	console.log("\n oninput("+event+")")
	printInputEventProperties(event)
}
dkConsoleWindow.addEventListener('input', oninput)



////// KeyboardEvent //////
// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
function onkeydown(event){
	console.log("\n onkeydown("+event+")")
	printKeyboardEventProperties(event)
}
dkConsoleWindow.addEventListener('keydown', onkeydown)
// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
function onkeyup(event){
	console.log("\n onkeyup("+event+")")
	printKeyboardEventProperties(event)
}
dkConsoleWindow.addEventListener('keyup', onkeyup)
// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
function onkeypress(event){
	console.log("\n onkeypress("+event+")")
	printKeyboardEventProperties(event)
}
dkConsoleWindow.addEventListener('keypress', onkeypress)



////// CompositionEvent //////
// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
function oncompositionstart(event){
	console.log("\n oncompositionstart("+event+")")
	printCompositionEventProperties(event)
}
dkConsoleWindow.addEventListener('compositionstart', oncompositionstart)
// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
function oncompositionupdate(event){
	console.log("\n oncompositionupdate("+event+")")
	printCompositionEventProperties(event)
}
dkConsoleWindow.addEventListener('compositionupdate', oncompositionupdate)
// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
function oncompositionend(event){
	console.log("\n oncompositionend("+event+")")
	printCompositionEventProperties(event)
}
dkConsoleWindow.addEventListener('compositionend', oncompositionend)