// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

//////////////////////////////////
var MouseEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		get: function(){ 
			return DKMouseEvent_altKey(this.pointer);
		}
	});
	Object.defineProperty(this, "button", {
		get: function(){ 
			return DKMouseEvent_button(pointer);
		}
	});


	// Methods
	Event.prototype.getModifierState = function(){
		DKMouseEvent_getModifierState(this.pointer);
	};
	
	return UIEvent.call(this, pointer);
};
MouseEvent.prototype = UIEvent.prototype;