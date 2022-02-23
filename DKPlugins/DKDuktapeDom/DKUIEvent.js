// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

var UIEvent = function(pointer) {
    // Properties
    /*
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		get: function(){ 
			return CPP_DKUIEvent_cancelBubble(pointer);
		}
		set: function(flag){ 
			return CPP_DKUIEvent_cancelBubble(pointer, flag);
		}
	});
	*/
    Object.defineProperty(this, "detail", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_detail(pointer);
        }
    });
    Object.defineProperty(this, "isChar", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_isChar(pointer);
        }
    });
    Object.defineProperty(this, "layerX", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_layerX(pointer);
        }
    });
    Object.defineProperty(this, "layerY", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_layerY(pointer);
        }
    });
    /*
	Object.defineProperty(this, "pageX", { //Read only
		get: function(){ 
			return CPP_DKUIEvent_pageX(pointer);
		}
	});
	Object.defineProperty(this, "pageY", { //Read only
		get: function(){ 
			return CPP_DKUIEvent_pageY(pointer);
		}
	});
	*/
    Object.defineProperty(this, "sourceCapabilities", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_sourceCapabilities(pointer);
        }
    });
    Object.defineProperty(this, "view", {
        //Read only
        get: function() {
            return CPP_DKUIEvent_view(pointer);
        }
    });
    /*
	Object.defineProperty(this, "which", { //Read only
		get: function(){ 
			return CPP_DKUIEvent_which(pointer);
		}
	});
	*/

    // Methods
    UIEvent.prototype.initUIEvent = function() {
        //Deprecated
        CPP_DKUIEvent_initUIEvent(this.pointer);
    }
    ;

    return Event.call(this, pointer);
};
UIEvent.prototype = Event.prototype;
