// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/MouseEvent.idl
// [SOURCE] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent


// Source: UI Events (https://www.w3.org/TR/uievents/)
// [Exposed=Window]
// interface MouseEvent : UIEvent {
// constructor(DOMString type, optional MouseEventInit eventInitDict = {});
var MouseEvent = function MouseEvent(type, eventInitDict, address) {
	//console.log("MouseEvent("+type+","+eventInitDict+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKMouseEventDUK(type, eventInitDict)
		
	// readonly attribute long screenX;
	Object.defineProperty(this, "screenX", {
        get: function screenX()		{ return CPP_DKMouseEventDUK_screenX(this.address) },
		set: function screenX(num)	{ return CPP_DKMouseEventDUK_screenX(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute long screenY;
	Object.defineProperty(this, "screenY", {
        get: function screenY() 	{ return CPP_DKMouseEventDUK_screenY(this.address) },
		set: function screenY(num)	{ return CPP_DKMouseEventDUK_screenY(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute long clientX;
	Object.defineProperty(this, "clientX", {
        get: function clientX()		{ return CPP_DKMouseEventDUK_clientX(this.address) },
		set: function clientX(num) 	{ return CPP_DKMouseEventDUK_clientX(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute long clientY;
	Object.defineProperty(this, "clientY", {
        get: function clientY() 	{ return CPP_DKMouseEventDUK_clientY(this.address) },
		set: function clientY(num) 	{ return CPP_DKMouseEventDUK_clientY(this.address, num) },
		configurable: true,
    })
	
	// readonly attribute boolean ctrlKey;
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey()		{ return CPP_DKMouseEventDUK_ctrlKey(this.address) },
		set: function ctrlKey(flag)	{ return CPP_DKMouseEventDUK_ctrlKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean shiftKey;
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() 		{ return CPP_DKMouseEventDUK_shiftKey(this.address) },
		set: function shiftKey(flag)	{ return CPP_DKMouseEventDUK_shiftKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean altKey;
	Object.defineProperty(this, "altKey", {
        get: function altKey() 		{ return CPP_DKMouseEventDUK_altKey(this.address) },
		set: function altKey(flag)	{ return CPP_DKMouseEventDUK_altKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute boolean metaKey;
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() 	{ return CPP_DKMouseEventDUK_metaKey(this.address) },
		set: function metaKey(flag) { return CPP_DKMouseEventDUK_metaKey(this.address, flag) },
		configurable: true,
    })
	
	// readonly attribute short button;
	Object.defineProperty(this, "button", {
        get: function button() { return CPP_DKMouseEventDUK_button(this.address) },
    })
	
	// readonly attribute unsigned short buttons;
	Object.defineProperty(this, "buttons", {
        get: function buttons() { return CPP_DKMouseEventDUK_buttons(this.address) },
    })
	
	// readonly attribute EventTarget? relatedTarget;
	Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() { return CPP_DKMouseEventDUK_relatedTarget(this.address) },
    })
	
	// boolean getModifierState(DOMString keyArg);
	MouseEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKMouseEventDUK_getModifierState(this.address)
    }
	
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface MouseEvent {
	//  	readonly attribute double pageX;
			Object.defineProperty(this, "pageX", {
				get: function pageX() { return CPP_DKMouseEventDUK_pageX(this.address) },
			})
	//  	readonly attribute double pageY;
			Object.defineProperty(this, "pageY", {
				get: function pageY() { return CPP_DKMouseEventDUK_pageY(this.address) },
			})
	//  	readonly attribute double x;
			Object.defineProperty(this, "x", {
				get: function x() { return CPP_DKMouseEventDUK_x(this.address) },
			})
	//  	readonly attribute double y;
			Object.defineProperty(this, "y", {
				get: function y() { return CPP_DKMouseEventDUK_y(this.address) },
			})
	//  	readonly attribute double offsetX; 
			Object.defineProperty(this, "offsetX", {
				get: function offsetX() { return CPP_DKMouseEventDUK_offsetX(this.address) },
			})
	//  	readonly attribute double offsetY;
			Object.defineProperty(this, "offsetY", {
				get: function offsetY() { return CPP_DKMouseEventDUK_offsetY(this.address) },
			})	
	// };
		
	// Source: Pointer Lock 2.0 (https://www.w3.org/TR/pointerlock-2/)
	// partial interface MouseEvent {
	//   	readonly attribute double movementX;
			Object.defineProperty(this, "movementX", {
				get: function movementX() { return CPP_DKMouseEventDUK_movementX(this.address) },
			})
	//   	readonly attribute double movementY;
			Object.defineProperty(this, "movementY", {
				get: function movementY() { return CPP_DKMouseEventDUK_movementY(this.address) },
			})
	// };
		
	// Source: UI Events (https://www.w3.org/TR/uievents/)
	// partial interface MouseEvent {
	//		Deprecated in this specification
	//	  	undefined initMouseEvent(DOMString typeArg,
	//		optional boolean bubblesArg = false,
	//		optional boolean cancelableArg = false,
	//		optional Window? viewArg = null,
	//		optional long detailArg = 0,
	//		optional long screenXArg = 0,
	//		optional long screenYArg = 0,
	//		optional long clientXArg = 0,
	//		optional long clientYArg = 0,
	//		optional boolean ctrlKeyArg = false,
	//		optional boolean altKeyArg = false,
	//		optional boolean shiftKeyArg = false,
	//		optional boolean metaKeyArg = false,
	//		optional short buttonArg = 0,
	//		optional EventTarget? relatedTargetArg = null);
			MouseEvent.prototype.initMouseEvent = function initMouseEvent() {
				CPP_DKMouseEventDUK_initMouseEvent(this.address)
			}
	// };
	

	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){ return "[object MouseEvent]" }
	

	var event = UIEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	Object.defineProperty(this, "altKey ", 		{ set: undefined })
	Object.defineProperty(this, "clientX",  	{ set: undefined })
	Object.defineProperty(this, "clientY",  	{ set: undefined })
	Object.defineProperty(this, "ctrlKey ", 	{ set: undefined })
	Object.defineProperty(this, "metaKey ", 	{ set: undefined })
	Object.defineProperty(this, "screenX",  	{ set: undefined })
	Object.defineProperty(this, "screenY",  	{ set: undefined })
	Object.defineProperty(this, "shiftKey ", 	{ set: undefined })
	
	return event
}
MouseEvent.prototype = UIEvent.prototype
