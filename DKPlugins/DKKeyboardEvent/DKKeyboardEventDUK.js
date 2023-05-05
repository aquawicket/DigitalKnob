// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/KeyboardEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface KeyboardEvent : UIEvent {
// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
var KeyboardEvent = function KeyboardEvent(type, options, address) {
	//console.log("KeyboardEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKKeyboardEventDUK(type, options)
	
	// KeyLocationCode
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
		
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
		
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
		
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
		
	// readonly attribute DOMString key;	
	Object.defineProperty(this, "key", {
        get: function key() 	{ return CPP_DKKeyboardEventDUK_key(this.address) },
		set: function key(str) 	{ return CPP_DKKeyboardEventDUK_key(this.address, str) },
		configurable: true,
    })
	
	// readonly attribute DOMString code;
	Object.defineProperty(this, "code", {
        get: function code() 	{ return CPP_DKKeyboardEventDUK_code(this.address) },
		set: function code(str) { return CPP_DKKeyboardEventDUK_code(this.address, str) },
		configurable: true,
    })
	
	// readonly attribute unsigned long location;
	Object.defineProperty(this, "location", {
        get: function location() 	{ return CPP_DKKeyboardEventDUK_location(this.address) },
		set: function location(num) { return CPP_DKKeyboardEventDUK_location(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute boolean ctrlKey;
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey()		{ return CPP_DKKeyboardEventDUK_ctrlKey(this.address) },
		set: function ctrlKey(flag) { return CPP_DKKeyboardEventDUK_ctrlKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean shiftKey;
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey()	 { return CPP_DKKeyboardEventDUK_shiftKey(this.address) },
		set: function shiftKey(flag) { return CPP_DKKeyboardEventDUK_shiftKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean altKey;
	Object.defineProperty(this, "altKey", {
        get: function altKey() 		{ return CPP_DKKeyboardEventDUK_altKey(this.address) },
		set: function altKey(flag) 	{ return CPP_DKKeyboardEventDUK_altKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean metaKey;
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() 	{ return CPP_DKKeyboardEventDUK_metaKey(this.address) },
		set: function metaKey(flag) { return CPP_DKKeyboardEventDUK_metaKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean repeat;
	Object.defineProperty(this, "repeat", {
        get: function repeat() 		{ return CPP_DKKeyboardEventDUK_repeat(this.address) },
		set: function repeat(flag) 	{ return CPP_DKKeyboardEventDUK_repeat(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean isComposing;
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() 	{ return CPP_DKKeyboardEventDUK_isComposing(this.address) },
		set: function isComposing(flag) { return CPP_DKKeyboardEventDUK_isComposing(this.address, flag) },
		configurable: true,
    })
	
	// boolean getModifierState(DOMString keyArg);
	KeyboardEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKKeyboardEventDUK_getModifierState(this.address)
    }
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// Originally introduced (and deprecated) in this specification
	//		undefined initKeyboardEvent(DOMString typeArg,
	// 		optional boolean bubblesArg = false,
	// 		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional DOMString keyArg = "",
	//		optional unsigned long locationArg = 0,
	//		optional boolean ctrlKey = false,
	//		optional boolean altKey = false,
	//		optional boolean shiftKey = false,
	//		optional boolean metaKey = false);
			KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
				CPP_DKKeyboardEventDUK_initKeyboardEvent(this.address)
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			Object.defineProperty(this, "charCode", {
				get: function charCode() 	{ return CPP_DKKeyboardEventDUK_charCode(this.address) },
				set: function charCode(num) { return CPP_DKKeyboardEventDUK_charCoden(this.address, num) },
				configurable: true,
			})
	//		readonly attribute unsigned long keyCode;
			Object.defineProperty(this, "keyCode", {
				get: function keyCode() 	{ return CPP_DKKeyboardEventDUK_keyCode(this.address) },
				set: function keyCode(num) 	{ return CPP_DKKeyboardEventDUK_keyCode(this.address, num) },
				configurable: true,
			})
	// };
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object KeyboardEvent]" }
	
	var event = UIEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "altKey", 		{ set: undefined })
	Object.defineProperty(this, "code", 		{ set: undefined })
	Object.defineProperty(this, "ctrlKey", 		{ set: undefined })
	Object.defineProperty(this, "isComposing", 	{ set: undefined })
	Object.defineProperty(this, "key", 			{ set: undefined })
	Object.defineProperty(this, "location", 	{ set: undefined })
	Object.defineProperty(this, "metaKey", 		{ set: undefined })
	Object.defineProperty(this, "repeat", 		{ set: undefined })
	Object.defineProperty(this, "shiftKey", 	{ set: undefined })

	return event
};
KeyboardEvent.prototype = UIEvent.prototype;
