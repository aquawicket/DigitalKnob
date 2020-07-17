// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

/////////////////////////////////////
var KeyboardEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "key", {
		configurable: true,
		get: function(){ 
			console.log("KeyboardEvent.key("+pointer+")");
			return DKDomKeyboardEvent_key(pointer);
		}
	});

	// Methods
	Event.prototype.getModifierState = function(){
		DKDomKeyboardEvent_getModifierState(pointer);
	};
	
	return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;