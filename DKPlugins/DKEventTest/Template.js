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
	// [Template.???](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	/*
	Object.defineProperty(this, "???", {
        get: function ???() 	{ return CPP_Template_???(this.address) },
		set: function ???(??) 	{ return CPP_Template_???(this.address, ??) },
		configurable: true
    })
	*/

	
	////// Instance methods //////
	// [Template.???()] https://developer.mozilla.org/en-US/docs/Web/API/Template/???
	/*
	Template.prototype.??? = function ???() {
        CPP_Template_???(this.address);
    }
	*/
	
	////// Events //////
	// [???] https://developer.mozilla.org/en-US/docs/Web/API/Element/???_event


	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object Template]"
		}
	}
	
	var event = Event.call(this, type, options)
	
	// Make properties (Read Only) after assignment
	//Object.defineProperty(this, "???", 	 { set: undefined })
	
	return event
};
Template.prototype = MouseEvent.prototype;
