// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

///////////////////////////////
var UIEvent = function(pointer)
{
	// Properties
	/*
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		get: function(){ 
			return DKDomUIEvent_cancelBubble(pointer);
		}
		set: function(flag){ 
			return DKDomUIEvent_cancelBubble(pointer, flag);
		}
	});
	*/
	Object.defineProperty(this, "detail", { //Read only
		get: function(){ 
			return DKDomUIEvent_detail(pointer);
		}
	});
	Object.defineProperty(this, "isChar", { //Read only
		get: function(){ 
			return DKDomUIEvent_isChar(pointer);
		}
	});
	Object.defineProperty(this, "layerX", { //Read only
		get: function(){ 
			return DKDomUIEvent_layerX(pointer);
		}
	});
	Object.defineProperty(this, "layerY", { //Read only
		get: function(){ 
			return DKDomUIEvent_layerY(pointer);
		}
	});
	/*
	Object.defineProperty(this, "pageX", { //Read only
		get: function(){ 
			return DKDomUIEvent_pageX(pointer);
		}
	});
	Object.defineProperty(this, "pageY", { //Read only
		get: function(){ 
			return DKDomUIEvent_pageY(pointer);
		}
	});
	*/
	Object.defineProperty(this, "sourceCapabilities", { //Read only
		get: function(){ 
			return DKDomUIEvent_sourceCapabilities(pointer);
		}
	});
	Object.defineProperty(this, "view", { //Read only
		get: function(){ 
			return DKDomUIEvent_view(pointer);
		}
	});
	/*
	Object.defineProperty(this, "which", { //Read only
		get: function(){ 
			return DKDomUIEvent_which(pointer);
		}
	});
	*/
	

	// Methods
	UIEvent.prototype.initUIEvent = function(){ //Deprecated
		DKDomUIEvent_initUIEvent(this.pointer);
	};
	
	return Event.call(this, pointer);
};
UIEvent.prototype = Event.prototype;