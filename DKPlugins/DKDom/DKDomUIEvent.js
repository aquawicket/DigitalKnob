// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

///////////////////////////////
var UIEvent = function(pointer)
{
	// Properties
	/*
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		get: function(){ 
			return DKCPP_DKDomUIEvent_cancelBubble(pointer);
		}
		set: function(flag){ 
			return DKCPP_DKDomUIEvent_cancelBubble(pointer, flag);
		}
	});
	*/
	Object.defineProperty(this, "detail", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_detail(pointer);
		}
	});
	Object.defineProperty(this, "isChar", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_isChar(pointer);
		}
	});
	Object.defineProperty(this, "layerX", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_layerX(pointer);
		}
	});
	Object.defineProperty(this, "layerY", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_layerY(pointer);
		}
	});
	/*
	Object.defineProperty(this, "pageX", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_pageX(pointer);
		}
	});
	Object.defineProperty(this, "pageY", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_pageY(pointer);
		}
	});
	*/
	Object.defineProperty(this, "sourceCapabilities", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_sourceCapabilities(pointer);
		}
	});
	Object.defineProperty(this, "view", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_view(pointer);
		}
	});
	/*
	Object.defineProperty(this, "which", { //Read only
		get: function(){ 
			return DKCPP_DKDomUIEvent_which(pointer);
		}
	});
	*/
	

	// Methods
	UIEvent.prototype.initUIEvent = function(){ //Deprecated
		DKCPP_DKDomUIEvent_initUIEvent(this.pointer);
	};
	
	return Event.call(this, pointer);
};
UIEvent.prototype = Event.prototype;