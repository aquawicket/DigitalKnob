console.log("\n////// TEST_DKSdlWindow.js //////")

function printSdlWindowProperties(dkSdlWindow){
	// TODO
	
	printWindowProperties(dkSdlWindow);	//requires TEST_Window.js
}


////// DKSdlWindow //////
const dkSdlWindow = new DKSdlWindow()
printWindowProperties(dkSdlWindow)		//requires TEST_Window.js
printSdlWindowProperties(dkSdlWindow)
dkSdlWindow.outerHeight = 300;	
printSdlWindowProperties(dkSdlWindow)



////// FocusEvent //////
// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Element/blur_event
function onblur(event){
	console.log("\n onblur("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkSdlWindow.addEventListener("blur", onblur)
// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Element/focus_event
function onfocus(event){
	console.log("\n onfocus("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkSdlWindow.addEventListener('focus', onfocus)
// [focusin] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusin_event
function onfocusin(event){
	console.log("\n onfocusin("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkSdlWindow.addEventListener('focusin', onfocusin)
// [focusout] https://developer.mozilla.org/en-US/docs/Web/API/Element/focusout_event
function onfocusout(event){
	console.log("\n onfocusout("+event+")")
	printFocusEventProperties(event)	//requires TEST_FocusEvent.js
}
dkSdlWindow.addEventListener('focusout', onfocusout)



////// MouseEvent //////
// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
function onauxclick(event){
	console.log("\n onauxclick("+event+")")	
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('auxclick', onauxclick)
// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
function onclick(event){
	console.log("\n onclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('click', onclick)
// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
function oncontextmenu(event){
	console.log("\n oncontextmenu("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('contextmenu', oncontextmenu)
// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
function ondblclick(event){
	console.log("\n ondblclick("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('dblclick', ondblclick)
// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
function onmousedown(event){
	console.log("\n onmousedown("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mousedown', onmousedown)
// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
function onmouseenter(event){
	console.log("\n onmouseenter("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mouseenter', onmouseenter)
// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
function onmouseleave(event){
	console.log("\n onmouseleave("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mouseleave', onmouseleave)
// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
function onmousemove(event){
	console.log("\n onmousemove("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mousemove', onmousemove)
// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
function onmouseout(event){
	console.log("\n onmouseout("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mouseout', onmouseout)
// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
function onmouseover(event){
	console.log("\n onmouseover("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mouseover', onmouseover)
// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
function onmouseup(event){
	console.log("\n onmouseup("+event+")")
	printMouseEventProperties(event)		//requires TEST_MouseEvent.js
}
dkSdlWindow.addEventListener('mouseup', onmouseup)


////// WheelEvent //////
// [mousewheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousewheel_event
function onmousewheel(event){
	console.log("\n onmousewheel("+event+")")
	printWheelEventProperties(event)		//requires TEST_WheelEvent.js
}
dkSdlWindow.addEventListener('mousewheel', onmousewheel)
// [wheel] https://developer.mozilla.org/en-US/docs/Web/API/Element/wheel_event
function onwheel(event){
	console.log("\n onwheel("+event+")")		//requires TEST_WheelEvent.js
	printWheelEventProperties(event)
}
dkSdlWindow.addEventListener('wheel', onwheel)


////// InputEvent //////
// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
function onbeforeinput(event){
	console.log("\n onbeforeinput("+event+")")
	printInputEventProperties(event)
}
dkSdlWindow.addEventListener('beforeinput', onbeforeinput)
// [input] https://w3c.github.io/uievents/#event-type-input
function oninput(event){
	console.log("\n oninput("+event+")")
	printInputEventProperties(event)
}
dkSdlWindow.addEventListener('input', oninput)



////// KeyboardEvent //////
// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
function onkeydown(event){
	console.log("\n onkeydown("+event+")")
	printKeyboardEventProperties(event)
}
dkSdlWindow.addEventListener('keydown', onkeydown)
// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
function onkeyup(event){
	console.log("\n onkeyup("+event+")")
	printKeyboardEventProperties(event)
}
dkSdlWindow.addEventListener('keyup', onkeyup)
// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event
function onkeypress(event){
	console.log("\n onkeypress("+event+")")
	printKeyboardEventProperties(event)
}
dkSdlWindow.addEventListener('keypress', onkeypress)



////// CompositionEvent //////
// [compositionstart] https://w3c.github.io/uievents/#event-type-compositionstart
function oncompositionstart(event){
	console.log("\n oncompositionstart("+event+")")
	printCompositionEventProperties(event)
}
dkSdlWindow.addEventListener('compositionstart', oncompositionstart)
// [compositionupdate] https://w3c.github.io/uievents/#event-type-compositionupdate
function oncompositionupdate(event){
	console.log("\n oncompositionupdate("+event+")")
	printCompositionEventProperties(event)
}
dkSdlWindow.addEventListener('compositionupdate', oncompositionupdate)
// [compositionend] https://w3c.github.io/uievents/#event-type-compositionend
function oncompositionend(event){
	console.log("\n oncompositionend("+event+")")
	printCompositionEventProperties(event)
}
dkSdlWindow.addEventListener('compositionend', oncompositionend)