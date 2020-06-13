// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

//////////////////////////////////
var MouseEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		configurable: true,
		get: function(){ 
			return DKDomMouseEvent_altKey(this.pointer);
		}
	});
	Object.defineProperty(this, "button", {
		configurable: true,
		get: function(){ 
			return DKDomMouseEvent_button(pointer);
		}
	});


	// Methods
	Event.prototype.getModifierState = function(){
		DKDomMouseEvent_getModifierState(this.pointer);
	};
	
	return UIEvent.call(this, pointer);
};
MouseEvent.prototype = UIEvent.prototype;