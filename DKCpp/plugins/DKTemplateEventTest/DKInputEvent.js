// [W3C] https://w3c.github.io/uievents/#events-inputevents
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent


// [InputEvent()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/InputEvent
var InputEvent = function InputEvent(type, options, address){
	//console.log("InputEvent("+type+","+options+","+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKInputEvent(type, options);
	

	////// Instance properties //////
	// [InputEvent.data](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/data
	Object.defineProperty(this, "data", {
        get: function data(){
            return CPP_DKInputEvent_data(this.address);
        }
    });
	// [InputEvent.dataTransfer](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/dataTransfer
	Object.defineProperty(this, "dataTransfer", {
        get: function dataTransfer(){
            return CPP_DKInputEvent_dataTransfer(this.address);
        }
    });
	// [InputEvent.inputType](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/inputType
	Object.defineProperty(this, "inputType", {
        get: function inputType(){
            return CPP_DKInputEvent_inputType(this.address);
        }
    });
	// [InputEvent.isComposing](Read only) https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/isComposing
	Object.defineProperty(this, "isComposing", {
        get: function isComposing(){
            return CPP_DKInputEvent_isComposing(this.address);
        }
    });
	

    ////// Instance methods //////
	// [InputEvent.getTargetRanges()] https://developer.mozilla.org/en-US/docs/Web/API/InputEvent/getTargetRanges
	InputEvent.prototype.getTargetRanges = function getTargetRanges(){
		CPP_DKInputEvent_getTargetRanges(this.address);
    }
	
	
	////// Events //////
	// [beforeinput] https://w3c.github.io/uievents/#event-type-beforeinput
	// [input] https://w3c.github.io/uievents/#event-type-input
	
	
	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object InputEvent]"
		}
	}
	
	return UIEvent.call(this, type, options)
};
InputEvent.prototype = UIEvent.prototype;
