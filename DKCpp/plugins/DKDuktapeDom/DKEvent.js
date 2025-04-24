//https://developer.mozilla.org/en-US/docs/Web/API/Event

//event_instances = [];
var Event = function Event(pointer) //https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
{
    this.pointer = pointer;

    //Properties
    Object.defineProperty(this, "bubbles", {
        //Read Only
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function bubbles() {
            return CPP_DKDomEvent_bubbles(pointer)
=======
        get: function bubbles(){
            return CPP_DKEvent_bubbles(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    Object.defineProperty(this, "cancelBubble", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        set: function cancelBubble(flag) {
            return CPP_DKDomEvent_cancelBubble(pointer, flag)
=======
        set: function cancelBubble(flag){
            return CPP_DKEvent_cancelBubble(pointer, flag);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    Object.defineProperty(this, "cancelable", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function cancelable() {
            return CPP_DKDomEvent_cancelable(pointer)
=======
        get: function cancelable(){
            return CPP_DKEvent_cancelable(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "composed", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function composed() {
            return CPP_DKDomEvent_composed(pointer)
=======
        get: function composed(){
            return CPP_DKEvent_composed(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "currentTarget", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function currentTarget() {
            var elementPointer = CPP_DKDomEvent_currentTarget(pointer)
            if (!elementPointer) {
                return;
            }
            return new HTMLElement(elementPointer)
=======
        get: function currentTarget(){
			return window;
			/*
            var elementPointer = CPP_DKEvent_currentTarget(pointer);
            if (!elementPointer){
                return;
            }
            return new HTMLElement(elementPointer);
			*/
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "deepPath", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function deepPath() {
            return CPP_DKDomEvent_deepPath(pointer)
=======
        get: function deepPath(){
            return CPP_DKEvent_deepPath(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Not standardized
    Object.defineProperty(this, "defaultPrevented", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function defaultPrevented() {
            return CPP_DKDomEvent_defaultPrevented(pointer)
=======
        get: function defaultPrevented(){
            return CPP_DKEvent_defaultPrevented(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "eventPhase", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function eventPhase() {
            return CPP_DKDomEvent_eventPhase(pointer)
=======
        get: function eventPhase(){
            return CPP_DKEvent_eventPhase(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "explicitOriginalTarget", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function explicitOriginalTarget() {
            return CPP_DKDomEvent_explicitOriginalTarget(pointer)
=======
        get: function explicitOriginalTarget(){
            return CPP_DKEvent_explicitOriginalTarget(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Not standardized, Read Only
    Object.defineProperty(this, "originalTarget", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function originalTarget() {
            return CPP_DKDomEvent_originalTarget(pointer)
=======
        get: function originalTarget(){
            return CPP_DKEvent_originalTarget(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Not standardized, Read only
    Object.defineProperty(this, "returnValue", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function returnValue() {
            return CPP_DKDomEvent_returnValue(pointer)
=======
        get: function returnValue(){
            return CPP_DKEvent_returnValue(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    Object.defineProperty(this, "srcElement", {
        //Not standardized
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function srcElement() {
            var elementPointer = CPP_DKDomEvent_srcElement(pointer)
            if (!elementPointer)
=======
        get: function srcElement(){
            var elementPointer = CPP_DKEvent_srcElement(pointer);
            if (!elementPointer){
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
                return;
            return new HTMLElement(elementPointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "target", {
        //Read Only
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function target() {
            var elementPointer = CPP_DKDomEvent_target(pointer)
            if (!elementPointer) {
=======
        get: function target(){
            var elementPointer = CPP_DKEvent_target(pointer);
            if (!elementPointer){
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
                return;
            }
            return new HTMLElement(elementPointer)
        }
    })
    //Read Only
    Object.defineProperty(this, "timeStamp", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function timeStamp() {
            return CPP_DKDomEvent_timeStamp(pointer)
=======
        get: function timeStamp(){
            return CPP_DKEvent_timeStamp(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only
    Object.defineProperty(this, "type", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function type() {
            return CPP_DKDomEvent_type(pointer)
=======
        get: function type(){
            return CPP_DKEvent_type(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        },
    })
    //Read Only
    Object.defineProperty(this, "isTrusted", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function isTrusted() {
            return CPP_DKDomEvent_isTrusted(pointer)
=======
        get: function isTrusted(){
            return CPP_DKEvent_isTrusted(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only

    //Obsolete properties
    Object.defineProperty(this, "scoped", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
        get: function scoped() {
            return CPP_DKDomEvent_scoped(pointer)
=======
        get: function scoped(){
            return CPP_DKEvent_scoped(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
        }
    })
    //Read Only, Obsolete

    //Methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
    Event.prototype.createEvent = function createEvent() {
        //Deprecated
        CPP_DKDomEvent_createEvent(pointer)
    }
    Event.prototype.composedPath = function composedPath() {
        CPP_DKDomEvent_composedPath(pointer)
    }
    Event.prototype.initEvent = function initEvent() {
        //Deprecated
        CPP_DKDomEvent_initEvent(pointer)
    }
    Event.prototype.preventDefault = function preventDefault() {
        CPP_DKDomEvent_preventDefault(pointer)
    }
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation() {
        CPP_DKDomEvent_stopImmediatePropagation(pointer)
    }
    Event.prototype.stopPropagation = function stopPropagation() {
        CPP_DKDomEvent_stopPropagation(pointer)
=======
    Event.prototype.createEvent = function createEvent(){
        //Deprecated
        CPP_DKEvent_createEvent(pointer);
    }
    ;
    Event.prototype.composedPath = function composedPath(){
        CPP_DKEvent_composedPath(pointer);
    }
    ;
    Event.prototype.initEvent = function initEvent(){
        //Deprecated
        CPP_DKEvent_initEvent(pointer);
    }
    ;
    Event.prototype.preventDefault = function preventDefault(){
        CPP_DKEvent_preventDefault(pointer);
    }
    ;
    Event.prototype.stopImmediatePropagation = function stopImmediatePropagation(){
        CPP_DKEvent_stopImmediatePropagation(pointer);
    }
    ;
    Event.prototype.stopPropagation = function stopPropagation(){
        CPP_DKEvent_stopPropagation(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
    }

    //Obsolete methods
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
    Event.prototype.getPreventDefault = function getPreventDefault() {
        //Not standardized
        CPP_DKDomEvent_getPreventDefault(pointer)
    }
    Event.prototype.preventBubble = function preventBubble() {
        //Not standardized, Obsolete
        CPP_DKDomEvent_preventBubble(pointer)
    }
    Event.prototype.preventCapture = function preventCapture() {
        //Not standardized, Obsolete
        CPP_DKDomEvent_preventCapture(pointer)
=======
    Event.prototype.getPreventDefault = function getPreventDefault(){
        //Not standardized
        CPP_DKEvent_getPreventDefault(pointer);
    }
    ;
    Event.prototype.preventBubble = function preventBubble(){
        //Not standardized, Obsolete
        CPP_DKEvent_preventBubble(pointer);
    }
    ;
    Event.prototype.preventCapture = function preventCapture(){
        //Not standardized, Obsolete
        CPP_DKEvent_preventCapture(pointer);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
    }

    //console.log("dispatching event")
    //this.currentTarget.dispatchEvent(this)
    //return this;
};

// Called from C++ to send events
///////////////////////////////
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEvent.js
function DispatchEvent(pointer) {
    var event = new Event(pointer)
	globalThis.event = event;
    //console.log("DispatchEvent("+pointer+"): event.type = "+event.type)
	//DKDEBUGFUNC(pointer, event.type);
    if (event.type === "mousemove" || event.type === "mouseover" || event.type === "mousedown" || event.type === "mouseup" || event.type === "click" || event.type === "dblclick" || event.type === "contextmenu") {
        var mouseEvent = new MouseEvent(pointer)
        mouseEvent.currentTarget.dispatchEvent(mouseEvent)
    } 
	else if (event.type === "keydown" || event.type === "keyup" || event.type === "keypress") {
        var keyboardEvent = new KeyboardEvent(pointer)
        keyboardEvent.currentTarget.dispatchEvent(keyboardEvent)
    } 
	else {
        event.currentTarget.dispatchEvent(event)
=======
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
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEvent.js
    }
}
