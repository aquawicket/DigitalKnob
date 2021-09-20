// https://developer.mozilla.org/en-US/docs/Web/API/MouseEvent

var MouseEvent = function(pointer) {
    // Properties
    Object.defineProperty(this, "altKey", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_altKey(pointer)
        }
    })
    Object.defineProperty(this, "button", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_button(pointer)
        }
    })
    Object.defineProperty(this, "buttons", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_buttons(pointer)
        }
    })
    Object.defineProperty(this, "clientX", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_clientX(pointer)
        }
    })
    Object.defineProperty(this, "clientY", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_clientY(pointer)
        }
    })
    Object.defineProperty(this, "ctrlKey", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_ctrlKey(pointer)
        }
    })
    Object.defineProperty(this, "metaKey", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_metaKey(pointer)
        }
    })
    Object.defineProperty(this, "movementX", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_movementX(pointer)
        }
    })
    Object.defineProperty(this, "movementY", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_movementY(pointer)
        }
    })
    Object.defineProperty(this, "offsetX", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_offsetX(pointer)
        }
    })
    Object.defineProperty(this, "offsetY", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_offsetY(pointer)
        }
    })
    Object.defineProperty(this, "pageX", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_pageX(pointer)
        }
    })
    Object.defineProperty(this, "pageY", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_pageY(pointer)
        }
    })
    Object.defineProperty(this, "region", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_pageX(pointer)
        }
    })
    Object.defineProperty(this, "relatedTarget", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_relatedTarget(pointer)
        }
    })
    Object.defineProperty(this, "screenX", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_screenX(pointer)
        }
    })
    Object.defineProperty(this, "screenY", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_screenY(pointer)
        }
    })
    Object.defineProperty(this, "shiftKey", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_shiftKey(pointer)
        }
    })
    Object.defineProperty(this, "which", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_which(pointer)
        }
    })
    Object.defineProperty(this, "moxPressure", {
        //Read only,
        get: function() {
            return CPP_DKDomMouseEvent_pageX(pointer)
        }
    })
    Object.defineProperty(this, "mozInputSource", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_mozInputSource(pointer)
        }
    })
    Object.defineProperty(this, "webkitForce", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_webkitForce(pointer)
        }
    })
    Object.defineProperty(this, "x", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_x(pointer)
        }
    })
    Object.defineProperty(this, "y", {
        //Read only
        get: function() {
            return CPP_DKDomMouseEvent_y(pointer)
        }
    })

    // Methods
    MouseEvent.prototype.getModifierState = function() {
        CPP_DKDomMouseEvent_getModifierState(pointer)
    }
    
    MouseEvent.prototype.initMouseEvent = function() {
        CPP_DKDomMouseEvent_initMouseEvent(pointer)
    }
    
    return UIEvent.call(this, pointer)
}
MouseEvent.prototype = UIEvent.prototype
