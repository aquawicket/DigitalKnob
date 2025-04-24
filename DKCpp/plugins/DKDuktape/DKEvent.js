//https://developer.mozilla.org/en-US/docs/Web/API/Event

//event_instances = [];
var Event = function Event(pointer) //https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
{
    this.pointer = pointer;

    //Properties
    Object.defineProperty(this, "bubbles", {
        //Read Only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function bubbles() {
=======
        get: function bubbles(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_bubbles(pointer);
        }
    });
    Object.defineProperty(this, "cancelBubble", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        set: function cancelBubble(flag) {
=======
        set: function cancelBubble(flag){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_cancelBubble(pointer, flag);
        }
    });
    Object.defineProperty(this, "cancelable", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function cancelable() {
=======
        get: function cancelable(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_cancelable(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "composed", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function composed() {
=======
        get: function composed(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_composed(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "currentTarget", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function currentTarget() {
=======
        get: function currentTarget(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
			return window;
			/*
            var elementPointer = CPP_DKEvent_currentTarget(pointer);
            if (!elementPointer){
                return;
            }
            return new HTMLElement(elementPointer);
			*/
        }
    });
    //Read Only
    Object.defineProperty(this, "deepPath", {
        get: function deepPath(){
            return CPP_DKEvent_deepPath(pointer);
        }
    });
    //Not standardized
    Object.defineProperty(this, "defaultPrevented", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function defaultPrevented() {
=======
        get: function defaultPrevented(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_defaultPrevented(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "eventPhase", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function eventPhase() {
=======
        get: function eventPhase(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_eventPhase(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "explicitOriginalTarget", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function explicitOriginalTarget() {
=======
        get: function explicitOriginalTarget(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_explicitOriginalTarget(pointer);
        }
    });
    //Not standardized, Read Only
    Object.defineProperty(this, "originalTarget", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function originalTarget() {
=======
        get: function originalTarget(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_originalTarget(pointer);
        }
    });
    //Not standardized, Read only
    Object.defineProperty(this, "returnValue", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function returnValue() {
=======
        get: function returnValue(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_returnValue(pointer);
        }
    });
    Object.defineProperty(this, "srcElement", {
        //Not standardized
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function srcElement() {
=======
        get: function srcElement(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            var elementPointer = CPP_DKEvent_srcElement(pointer);
            if (!elementPointer){
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "target", {
        //Read Only
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function target() {
=======
        get: function target(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            var elementPointer = CPP_DKEvent_target(pointer);
            if (!elementPointer){
                return;
            }
            return new HTMLElement(elementPointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "timeStamp", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function timeStamp() {
=======
        get: function timeStamp(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_timeStamp(pointer);
        }
    });
    //Read Only
    Object.defineProperty(this, "type", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function type() {
=======
        get: function type(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_type(pointer);
        },
    });
    //Read Only
    Object.defineProperty(this, "isTrusted", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function isTrusted() {
=======
        get: function isTrusted(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_isTrusted(pointer);
        }
    });
    //Read Only

    //Obsolete properties
    Object.defineProperty(this, "scoped", {
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
        get: function scoped() {
=======
        get: function scoped(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
            return CPP_DKEvent_scoped(pointer);
        }
    });
    //Read Only, Obsolete

    //Methods
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.createEvent = function createEvent() {
=======
    Event.prototype.createEvent = function createEvent(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        //Deprecated
        CPP_DKEvent_createEvent(pointer);
    }
    ;
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.composedPath = function composedPath() {
        CPP_DKEvent_composedPath(pointer);
    }
    ;
    Event.prototype.initEvent = function initEvent() {
=======
    Event.prototype.composedPath = function composedPath(){
        CPP_DKEvent_composedPath(pointer);
    }
    ;
    Event.prototype.initEvent = function initEvent(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        //Deprecated
        CPP_DKEvent_initEvent(pointer);
    }
    ;
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.preventDefault = function preventDefault() {
        CPP_DKEvent_preventDefault(pointer);
    }
    ;
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKEvent_stopImmediatePropagation(pointer);
    }
    ;
    Event.prototype.stopPropagation = function stopPropagation() {
=======
    Event.prototype.preventDefault = function preventDefault(){
        CPP_DKEvent_preventDefault(pointer);
    }
    ;
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation(){
        CPP_DKEvent_stopImmediatePropagation(pointer);
    }
    ;
    Event.prototype.stopPropagation = function stopPropagation(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        CPP_DKEvent_stopPropagation(pointer);
    }
    ;

    //Obsolete methods
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.getPreventDefault = function getPreventDefault() {
=======
    Event.prototype.getPreventDefault = function getPreventDefault(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        //Not standardized
        CPP_DKEvent_getPreventDefault(pointer);
    }
    ;
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.preventBubble = function preventBubble() {
=======
    Event.prototype.preventBubble = function preventBubble(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        //Not standardized, Obsolete
        CPP_DKEvent_preventBubble(pointer);
    }
    ;
<<<<<<< HEAD:DKPlugins/DKDuktape/DKEvent.js
    Event.prototype.preventCapture = function preventCapture() {
=======
    Event.prototype.preventCapture = function preventCapture(){
>>>>>>> Development:DKCpp/plugins/DKDuktape/DKEvent.js
        //Not standardized, Obsolete
        CPP_DKEvent_preventCapture(pointer);
    }
    ;

    //console.log("dispatching event");
    //this.currentTarget.dispatchEvent(this);
    //return this;
};

// Called from C++ to send events
///////////////////////////////
function DispatchEvent(pointer){
    var event = new Event(pointer);
    //console.log("DispatchEvent("+pointer+"): event.type = "+event.type);

    if (event.type === "mousemove" || event.type === "mouseover" || event.type === "mousedown" || event.type === "mouseup" || event.type === "click" || event.type === "dblclick" || event.type === "contextmenu"){
        var mouseEvent = new MouseEvent(pointer);
        mouseEvent.currentTarget.dispatchEvent(mouseEvent);
    } else if (event.type === "keydown" || event.type === "keyup" || event.type === "keypress"){
        var keyboardEvent = new KeyboardEvent(pointer);
        keyboardEvent.currentTarget.dispatchEvent(keyboardEvent);
    } else {
        event.currentTarget.dispatchEvent(event);
    }
}
