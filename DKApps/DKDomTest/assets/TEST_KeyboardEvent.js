// [IDL] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
console.log("////// TEST_KeyboardEvent.js //////")


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

////// Constructor //////
// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
		
		
////// Constants //////
////// Keyboard locations //////
// [DOM_KEY_LOCATION_STANDARD]	0x00 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
// [DOM_KEY_LOCATION_LEFT]		0x01 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
// [DOM_KEY_LOCATION_RIGHT]		0x02 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
// [DOM_KEY_LOCATION_NUMPAD]	0x03 https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent#keyboard_locations
	
		
////// Instance properties //////
// [KeyboardEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/altKey
// [KeyboardEvent.code](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/code
// [KeyboardEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/ctrlKey
// [KeyboardEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/isComposing
// [KeyboardEvent.key](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/key
// [KeyboardEvent.locale](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/locale
// [KeyboardEvent.location](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/location
// [KeyboardEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/metaKey
// [KeyboardEvent.repeat](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/repeat
// [KeyboardEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/shiftKey
	
	
////// Instance methods //////
// [KeyboardEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/getModifierState
	
	
////// Obsolete methods //////
// [KeyboardEvent.initKeyEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyEvent
// [KeyboardEvent.initKeyboardEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/initKeyboardEvent
	
	
////// Obsolete properties //////
// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/char
// [KeyboardEvent.charCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/charCode
// [KeyboardEvent.keyCode](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyCode
// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyIdentifier
// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/keyLocation
// [KeyboardEvent.which](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/which
	
		
////// Events //////
// [keydown] https://developer.mozilla.org/en-US/docs/Web/API/Element/keydown_event
// [keyup] https://developer.mozilla.org/en-US/docs/Web/API/Element/keyup_event
		
		
////// Obsolete events //////
// [keypress](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/keypress_event