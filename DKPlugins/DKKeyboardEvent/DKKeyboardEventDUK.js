// [W3C] https://w3c.github.io/uievents/#events-keyboardevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent


// [KeyboardEvent()] https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent/KeyboardEvent
var KeyboardEvent = function KeyboardEvent(type, options, address) {
	//console.log("KeyboardEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKKeyboardEventDUK(type, options)
	
	////// Constants //////
	// [DOM_KEY_LOCATION_STANDARD]	0x00
	// [DOM_KEY_LOCATION_LEFT]		0x01
	// [DOM_KEY_LOCATION_RIGHT]		0x02
	// [DOM_KEY_LOCATION_NUMPAD]	0x03
	
	
	////// Instance properties //////
	// [KeyboardEvent.altKey](Read only)
	Object.defineProperty(this, "altKey", {
        get: function altKey() 		{ return CPP_DKKeyboardEventDUK_altKey(this.address) },
		set: function altKey(flag) 	{ return CPP_DKKeyboardEventDUK_altKey(this.address, flag) },
		configurable: true,
    })
	// [KeyboardEvent.code](Read only)
	Object.defineProperty(this, "code", {
        get: function code() 	{ return CPP_DKKeyboardEventDUK_code(this.address) },
		set: function code(str) { return CPP_DKKeyboardEventDUK_code(this.address, str) },
		configurable: true,
    })
	// [KeyboardEvent.ctrlKey](Read only)
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey()		{ return CPP_DKKeyboardEventDUK_ctrlKey(this.address) },
		set: function ctrlKey(flag) { return CPP_DKKeyboardEventDUK_ctrlKey(this.address, flag) },
		configurable: true,
    })
	// [KeyboardEvent.isComposing](Read only)
	Object.defineProperty(this, "isComposing", {
        get: function isComposing() 	{ return CPP_DKKeyboardEventDUK_isComposing(this.address) },
		set: function isComposing(flag) { return CPP_DKKeyboardEventDUK_isComposing(this.address, flag) },
		configurable: true,
    })
	// [KeyboardEvent.key](Read only)
	Object.defineProperty(this, "key", {
        get: function key() 	{ return CPP_DKKeyboardEventDUK_key(this.address) },
		set: function key(str) 	{ return CPP_DKKeyboardEventDUK_key(this.address, str) },
		configurable: true,
    })
	// [KeyboardEvent.locale](Read only)
	Object.defineProperty(this, "locale", {
        get: function locale() { return CPP_DKKeyboardEventDUK_locale(this.address) },
    })
	// [KeyboardEvent.location](Read only)
	Object.defineProperty(this, "location", {
        get: function location() 	{ return CPP_DKKeyboardEventDUK_location(this.address) },
		set: function location(num) { return CPP_DKKeyboardEventDUK_location(this.address, num) },
		configurable: true,
    })
	// [KeyboardEvent.metaKey](Read only)
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() 	{ return CPP_DKKeyboardEventDUK_metaKey(this.address) },
		set: function metaKey(flag) { return CPP_DKKeyboardEventDUK_metaKey(this.address, flag) },
		configurable: true,
    })
	// [KeyboardEvent.repeat](Read only)
	Object.defineProperty(this, "repeat", {
        get: function repeat() 		{ return CPP_DKKeyboardEventDUK_repeat(this.address) },
		set: function repeat(flag) 	{ return CPP_DKKeyboardEventDUK_repeat(this.address, flag) },
		configurable: true,
    })
	// [KeyboardEvent.shiftKey](Read only)
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey()	 { return CPP_DKKeyboardEventDUK_shiftKey(this.address) },
		set: function shiftKey(flag) { return CPP_DKKeyboardEventDUK_shiftKey(this.address, flag) },
		configurable: true,
    })
	

    ////// Instance methods //////
	// [KeyboardEvent.getModifierState()] 
	KeyboardEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKKeyboardEventDUK_getModifierState(this.address)
    }


	/*
	////// Obsolete methods //////
	// [KeyboardEvent.initKeyEvent()](Deprecated)
	KeyboardEvent.prototype.initKeyEvent = function initKeyEvent() {
		CPP_DKKeyboardEventDUK_initKeyEvent(this.address)
    }
	// [KeyboardEvent.initKeyboardEvent()](Deprecated)
	KeyboardEvent.prototype.initKeyboardEvent = function initKeyboardEvent() {
		CPP_DKKeyboardEventDUK_initKeyboardEvent(this.address)
    }
	*/
	
	
	////// Obsolete properties //////
	// [KeyboardEvent.char](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.charCode](Deprecated)(Read only)
	// [KeyboardEvent.keyCode](Deprecated)(Read only)
	// [KeyboardEvent.keyIdentifier](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.keyLocation](Non-standard)(Deprecated)(Read only)
	// [KeyboardEvent.which](Deprecated)(Read only)

	
	////// Events //////
	// [keydown]
	// [keyup]
	
	
	////// Obsolete events //////
	// [keypress](Deprecated)
	
	
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
