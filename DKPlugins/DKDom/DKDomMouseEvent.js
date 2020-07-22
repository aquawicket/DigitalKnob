// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

//////////////////////////////////
var MouseEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "altKey", {
		get: function(){ 
			return DKDomMouseEvent_altKey(pointer);
		}
	});
	Object.defineProperty(this, "button", {
		get: function(){ 
			return DKDomMouseEvent_button(pointer);
		}
	});


	// Methods
	Event.prototype.getModifierState = function(){
		DKDomMouseEvent_getModifierState(pointer);
	};
	
	return UIEvent.call(this, pointer);
};
MouseEvent.prototype = UIEvent.prototype;