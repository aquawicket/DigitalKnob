// [W3C] https://w3c.github.io/uievents/#events-mouseevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent


// [MouseEvent()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/MouseEvent
var MouseEvent = function MouseEvent(type, options, address) {
	//console.log("MouseEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_DKMouseEvent(type, options)
		
	
	////// Static properties //////
	// [MouseEvent.WEBKIT_FORCE_AT_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_MOUSE_DOWN
	// [MouseEvent.WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/WEBKIT_FORCE_AT_FORCE_MOUSE_DOWN
	
	
	////// Instance properties //////
	// [MouseEvent.altKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/altKey
	Object.defineProperty(this, "altKey", {
        get: function altKey() 		{ return CPP_DKMouseEvent_altKey(this.address) },
		set: function altKey(flag)	{ return CPP_DKMouseEvent_altKey(this.address, flag) },
		configurable: true
    })
	// [MouseEvent.button](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/button
	Object.defineProperty(this, "button", {
        get: function button() { return CPP_DKMouseEvent_button(this.address) }
    })
	// [MouseEvent.buttons](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/buttons
	Object.defineProperty(this, "buttons", {
        get: function buttons() { return CPP_DKMouseEvent_buttons(this.address) }
    })
	// [MouseEvent.clientX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientX
	Object.defineProperty(this, "clientX", {
        get: function clientX()		{ return CPP_DKMouseEvent_clientX(this.address) },
		set: function clientX(num) 	{ return CPP_DKMouseEvent_clientX(this.address, num) },
		configurable: true
    })
	// [MouseEvent.clientY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/clientY
	Object.defineProperty(this, "clientY", {
        get: function clientY() 	{ return CPP_DKMouseEvent_clientY(this.address) },
		set: function clientY(num) 	{ return CPP_DKMouseEvent_clientY(this.address, num) },
		configurable: true
    })
	// [MouseEvent.ctrlKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/ctrlKey
	Object.defineProperty(this, "ctrlKey", {
        get: function ctrlKey()		{ return CPP_DKMouseEvent_ctrlKey(this.address) },
		set: function ctrlKey(flag)	{ return CPP_DKMouseEvent_ctrlKey(this.address, flag) },
		configurable: true
    })
	// [MouseEvent.layerX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerX
	Object.defineProperty(this, "layerX", {
        get: function layerX() { return CPP_DKMouseEvent_layerX(this.address) }
    })
	// [MouseEvent.layerY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/layerY
	Object.defineProperty(this, "layerY", {
        get: function layerY() { return CPP_DKMouseEvent_layerY(this.address) }
    })
	// [MouseEvent.metaKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/metaKey
	Object.defineProperty(this, "metaKey", {
        get: function metaKey() 	{ return CPP_DKMouseEvent_metaKey(this.address) },
		set: function metaKey(flag) { return CPP_DKMouseEvent_metaKey(this.address, flag) },
		configurable: true
    })
	// [MouseEvent.movementX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementX
	Object.defineProperty(this, "movementX", {
        get: function movementX() { return CPP_DKMouseEvent_movementX(this.address) }
    })
	// [MouseEvent.movementY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/movementY
	Object.defineProperty(this, "movementY", {
        get: function movementY() { return CPP_DKMouseEvent_movementY(this.address) }
    })
	// [MouseEvent.offsetX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetX
	Object.defineProperty(this, "offsetX", {
        get: function offsetX() { return CPP_DKMouseEvent_offsetX(this.address) }
    })
	// [MouseEvent.offsetY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/offsetY
	Object.defineProperty(this, "offsetY", {
        get: function offsetY() { return CPP_DKMouseEvent_offsetY(this.address) }
    })
	// [MouseEvent.pageX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageX
	Object.defineProperty(this, "pageX", {
        get: function pageX() { return CPP_DKMouseEvent_pageX(this.address) }
    })
	// [MouseEvent.pageY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/pageY
	Object.defineProperty(this, "pageY", {
        get: function pageY() { return CPP_DKMouseEvent_pageY(this.address) }
    })
	// [MouseEvent.relatedTarget](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/relatedTarget
	Object.defineProperty(this, "relatedTarget", {
        get: function relatedTarget() { return CPP_DKMouseEvent_relatedTarget(this.address) }
    })
	// [MouseEvent.screenX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenX
	Object.defineProperty(this, "screenX", {
        get: function screenX() { return CPP_DKMouseEvent_screenX(this.address) }
    })
	// [MouseEvent.screenY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/screenY
	Object.defineProperty(this, "screenY", {
        get: function screenY() { return CPP_DKMouseEvent_screenY(this.address) }
    })
	// [MouseEvent.shiftKey](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/shiftKey
	Object.defineProperty(this, "shiftKey", {
        get: function shiftKey() 		{ return CPP_DKMouseEvent_shiftKey(this.address) },
		set: function shiftKey(flag)	{ return CPP_DKMouseEvent_shiftKey(this.address, flag) },
		configurable: true
    })
	// [MouseEvent.mozPressure](Non-standard)(Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozPressure
	Object.defineProperty(this, "mozPressure", {
        get: function mozPressure() { return CPP_DKMouseEvent_mozPressure(this.address) }
    })
	// [MouseEvent.mozInputSource](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/mozInputSource
	Object.defineProperty(this, "mozInputSource", {
        get: function mozInputSource() { return CPP_DKMouseEvent_mozInputSource(this.address) }
    })
	// [MouseEvent.webkitForce](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/webkitForce
	Object.defineProperty(this, "webkitForce", {
        get: function webkitForce() { return CPP_DKMouseEvent_webkitForce(this.address) }
    })
	// [MouseEvent.x](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/x
	Object.defineProperty(this, "x", {
        get: function x() { return CPP_DKMouseEvent_x(this.address) }
    })
	// [MouseEvent.y](Read only) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/y
	Object.defineProperty(this, "y", {
        get: function y() { return CPP_DKMouseEvent_y(this.address) }
    })
	
		
    ////// Instance methods //////
	// [MouseEvent.getModifierState()] https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/getModifierState
	MouseEvent.prototype.getModifierState = function getModifierState() {
		CPP_DKMouseEvent_getModifierState(this.address)
    }
	// [MouseEvent.initMouseEvent()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent/initMouseEvent
	MouseEvent.prototype.initMouseEvent = function initMouseEvent() {
		CPP_DKMouseEvent_initMouseEvent(this.address)
    }


	////// Events //////
	// [auxclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/auxclick_event
	// [click] https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event
	// [contextmenu] https://developer.mozilla.org/en-US/docs/Web/API/Element/contextmenu_event
	// [dblclick] https://developer.mozilla.org/en-US/docs/Web/API/Element/dblclick_event
	// [DOMActivate](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Element/DOMActivate_event
	// [mousedown] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousedown_event
	// [mouseenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseenter_event
	// [mouseleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseleave_event
	// [mousemove] https://developer.mozilla.org/en-US/docs/Web/API/Element/mousemove_event
	// [mouseout] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseout_event
	// [mouseover] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseover_event
	// [mouseup] https://developer.mozilla.org/en-US/docs/Web/API/Element/mouseup_event
	// [webkitmouseforcechanged](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcechanged_event
	// [webkitmouseforcedown](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcedown_event
	// [webkitmouseforceup](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforceup_event
	// [webkitmouseforcewillbegin](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Element/webkitmouseforcewillbegin_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object MouseEvent]"
		}
	}
	

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
