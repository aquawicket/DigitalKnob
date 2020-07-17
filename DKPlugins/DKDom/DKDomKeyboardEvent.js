// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent

/////////////////////////////////////
var KeyboardEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "key", {
		configurable: true,
		get: function(){ 
			return DKDomKeyboardEvent_key(this.pointer);
		}
	});

	// Methods
	Event.prototype.getModifierState = function(){
		DKDomKeyboardEvent_getModifierState(this.pointer);
	};
	
	return UIEvent.call(this, pointer);
};
KeyboardEvent.prototype = UIEvent.prototype;