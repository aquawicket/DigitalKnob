// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

///////////////////////////////
var UIEvent = function(pointer)
{
	// Properties
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		set: function(flag){ 
			return DKUIEvent_cancelBubble(this.pointer, flag);
		}
	});


	// Methods
	Event.prototype.initUIEvent = function(){ //Deprecated
		DKUIEvent_initUIEvent(this.pointer);
	};
	
	return Event.call(this, pointer);
};
UIEvent.prototype = Event.prototype;