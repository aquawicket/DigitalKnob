// [W3C] https://w3c.github.io/uievents/#events-wheelevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Template


// [Template()] https://developer.mozilla.org/en-US/docs/Web/API/Template/Template
var Template = function Template(type, options, address) {
	//console.log("Template("+type+","+options+","+address+")")
	
	if(address)
		this.address = address
	if(!this.address)
		this.address = CPP_Template(type, options)
	
	
	////// Instance properties //////
	// [Template.pointerId](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/pointerId
	// [Template.width](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/width
	// [Template.height](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/height
	// [Template.pressure](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/pressure
	// [Template.tangentialPressure) https://developer.mozilla.org/en-US/docs/Web/API/Template/tangentialPressure
	// [Template.tiltX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/tiltX
	// [Template.tiltY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/tiltY
	// [Template.twist](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/twist
	// [Template.pointerType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/pointerType
	// [Template.isPrimary](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/isPrimary
	/*
	Object.defineProperty(this, "???", {
        get: function ???() 	{ return CPP_Template_???(this.address) },
		set: function ???(??) 	{ return CPP_Template_???(this.address, ??) },
		configurable: true
    })
	*/

	
	////// Instance methods //////
	// [Template.getCoalescedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/Template/getCoalescedEvents
	// [Template.getPredictedEvents()] https://developer.mozilla.org/en-US/docs/Web/API/Template
	
	
	////// Events //////
	// [pointerover] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerover_event
	// [pointerenter] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerenter_event
	// [pointerdown] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerdown_event
	// [pointermove] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointermove_event
	// [pointerrawupdate](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerrawupdate_event
	// [pointerup] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerup_event
	// [pointercancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointercancel_event
	// [pointerout] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerout_event
	// [pointerleave] https://developer.mozilla.org/en-US/docs/Web/API/Element/pointerleave_event
	// [gotpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/gotpointercapture_event
	// [lostpointercapture] https://developer.mozilla.org/en-US/docs/Web/API/Element/lostpointercapture_event

	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Template]"
		}
	}
	
	var event = MouseEvent.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	//Object.defineProperty(this, "???", 	 { set: undefined })
	
	return event
};
Template.prototype = MouseEvent.prototype;
