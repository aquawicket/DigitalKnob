// [IDL] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent


// [Exposed=Window]
// interface KeyboardEvent : UIEvent {
// constructor(DOMString type, optional KeyboardEventInit eventInitDict = {});
var KeyboardEvent = function KeyboardEvent(type, options, address) {
	//console.log("KeyboardEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKKeyboardEventDUK_constructor(type, options);
	
	// KeyLocationCode
	// const unsigned long DOM_KEY_LOCATION_STANDARD = 0x00;
	Object.defineProperty(this, "DOM_KEY_LOCATION_STANDARD", {
        get: function DOM_KEY_LOCATION_STANDARD() 		{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_STANDARD(this.address) },
		//set: function DOM_KEY_LOCATION_STANDARD(data)	{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_STANDARD(this.address, data) },
		//configurable: true,
    })
		
	// const unsigned long DOM_KEY_LOCATION_LEFT = 0x01;
	Object.defineProperty(this, "DOM_KEY_LOCATION_LEFT", {
        get: function DOM_KEY_LOCATION_LEFT() 			{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_LEFT(this.address) },
		//set: function DOM_KEY_LOCATION_LEFT(data)		{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_LEFT(this.address, data) },
		//configurable: true,
    })
		
	// const unsigned long DOM_KEY_LOCATION_RIGHT = 0x02;
	Object.defineProperty(this, "DOM_KEY_LOCATION_RIGHT", {
        get: function DOM_KEY_LOCATION_RIGHT() 			{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_RIGHT(this.address) },
		//set: function DOM_KEY_LOCATION_RIGHT(data)	{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_RIGHT(this.address, data) },
		//configurable: true,
    })
		
	// const unsigned long DOM_KEY_LOCATION_NUMPAD = 0x03;
	Object.defineProperty(this, "DOM_KEY_LOCATION_NUMPAD", {
        get: function DOM_KEY_LOCATION_NUMPAD() 		{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_NUMPAD(this.address) },
		//set: function DOM_KEY_LOCATION_NUMPAD(data)	{ return CPP_DKKeyboardEventDUK_DOM_KEY_LOCATION_NUMPAD(this.address, data) },
		//configurable: true,
    })
		
	// readonly attribute DOMString key;	
	Object.defineProperty(this, "key", {
        get: function key() 							{ return CPP_DKKeyboardEventDUK_key(this.address) },
		set: function key(data) 						{ return CPP_DKKeyboardEventDUK_key(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute DOMString code;
	Object.defineProperty(this, "code", {
        get: function code() 							{ return CPP_DKKeyboardEventDUK_code(this.address) },
		set: function code(data) 						{ return CPP_DKKeyboardEventDUK_code(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute unsigned long location;
	Object.defineProperty(this, "location", {
        get: function location() 						{ return CPP_DKKeyboardEventDUK_location(this.address) },
		set: function location(data) 					{ return CPP_DKKeyboardEventDUK_location(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean ctrlKey;
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey()							{ return CPP_DKKeyboardEventDUK_ctrlKey(this.address) },
		set: function ctrlKey(data)						{ return CPP_DKKeyboardEventDUK_ctrlKey(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean shiftKey;
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey()						{ return CPP_DKKeyboardEventDUK_shiftKey(this.address) },
		set: function shiftKey(data)					{ return CPP_DKKeyboardEventDUK_shiftKey(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean altKey;
	Object.defineProperty(this, "altKey", {
        get: function altKey() 							{ return CPP_DKKeyboardEventDUK_altKey(this.address) },
		set: function altKey(data) 						{ return CPP_DKKeyboardEventDUK_altKey(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean metaKey;
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() 						{ return CPP_DKKeyboardEventDUK_metaKey(this.address) },
		set: function metaKey(data)						{ return CPP_DKKeyboardEventDUK_metaKey(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean repeat;
	Object.defineProperty(this, "repeat", {
        get: function repeat() 							{ return CPP_DKKeyboardEventDUK_repeat(this.address) },
		set: function repeat(data) 						{ return CPP_DKKeyboardEventDUK_repeat(this.address, data) },
		configurable: true,
    })
	
	// readonly attribute boolean isComposing;
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() 					{ return CPP_DKKeyboardEventDUK_isComposing(this.address) },
		set: function isComposing(data) 				{ return CPP_DKKeyboardEventDUK_isComposing(this.address, data) },
		configurable: true,
    })
	
	// boolean getModifierState(DOMString keyArg);
	KeyboardEvent.prototype.getModifierState = function getModifierState(keyArg) {
		return CPP_DKKeyboardEventDUK_getModifierState(this.address, keyArg)
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
				CPP_DKKeyboardEventDUK_initKeyboardEvent(this.address);
			}
	// };
	
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface KeyboardEvent {
	//		// The following support legacy user agents
	//		readonly attribute unsigned long charCode;
			Object.defineProperty(this, "charCode", {
				get: function charCode() 				{ return CPP_DKKeyboardEventDUK_charCode(this.address) },
				set: function charCode(data)			{ return CPP_DKKeyboardEventDUK_charCoden(this.address, data) },
				configurable: true,
			})
	//		readonly attribute unsigned long keyCode;
			Object.defineProperty(this, "keyCode", {
				get: function keyCode() 				{ return CPP_DKKeyboardEventDUK_keyCode(this.address) },
				set: function keyCode(data) 			{ return CPP_DKKeyboardEventDUK_keyCode(this.address, data) },
				configurable: true,
			})
	// };
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object KeyboardEvent]" }
	
	var event = UIEvent.call(this, type, options);
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "altKey", 		{ set: undefined });
	Object.defineProperty(this, "code", 		{ set: undefined });
	Object.defineProperty(this, "ctrlKey", 		{ set: undefined });
	Object.defineProperty(this, "isComposing", 	{ set: undefined });
	Object.defineProperty(this, "key", 			{ set: undefined });
	Object.defineProperty(this, "location", 	{ set: undefined });
	Object.defineProperty(this, "metaKey", 		{ set: undefined });
	Object.defineProperty(this, "repeat", 		{ set: undefined });
	Object.defineProperty(this, "shiftKey", 	{ set: undefined });

	return event;
};
KeyboardEvent.prototype = UIEvent.prototype;
