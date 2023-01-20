// https://developer.mozilla.org/en-US/docs/Web/API/UIEvent

var UIEvent = function UIEvent(pointer) {
    // Properties
    /*
	Object.defineProperty(this, "cancelBubble", { //Not standardized, Deprecated
		get: function cancelBubble(){ 
			return CPP_DKDomUIEvent_cancelBubble(pointer)
		}
		set: function cancelBubble(flag){ 
			return CPP_DKDomUIEvent_cancelBubble(pointer, flag)
		}
	})
	*/
    Object.defineProperty(this, "detail", {
        //Read only
        get: function detail() {
            return CPP_DKDomUIEvent_detail(pointer)
        }
    })
    Object.defineProperty(this, "isChar", {
        //Read only
        get: function isChar() {
            return CPP_DKDomUIEvent_isChar(pointer)
        }
    })
    Object.defineProperty(this, "layerX", {
        //Read only
        get: function layerX() {
            return CPP_DKDomUIEvent_layerX(pointer)
        }
    })
    Object.defineProperty(this, "layerY", {
        //Read only
        get: function layerY() {
            return CPP_DKDomUIEvent_layerY(pointer)
        }
    })
    /*
	Object.defineProperty(this, "pageX", { //Read only
		get: function pageX(){ 
			return CPP_DKDomUIEvent_pageX(pointer)
		}
	})
	Object.defineProperty(this, "pageY", { //Read only
		get: function pageY(){ 
			return CPP_DKDomUIEvent_pageY(pointer)
		}
	})
	*/
    Object.defineProperty(this, "sourceCapabilities", {
        //Read only
        get: function sourceCapabilities() {
            return CPP_DKDomUIEvent_sourceCapabilities(pointer)
        }
    })
    Object.defineProperty(this, "view", {
        //Read only
        get: function view() {
            return CPP_DKDomUIEvent_view(pointer)
        }
    })
    /*
	Object.defineProperty(this, "which", { //Read only
		get: function which(){ 
			return CPP_DKDomUIEvent_which(pointer)
		}
	})
	*/

    // Methods
    UIEvent.prototype.initUIEvent = function initUIEvent() {
        //Deprecated
        CPP_DKDomUIEvent_initUIEvent(this.pointer)
    }

    return Event.call(this, pointer)
}
UIEvent.prototype = Event.prototype
