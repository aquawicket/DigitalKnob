//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

var stored_events = [];

var EventFromCPP = function(pointer, event) {
    //console.warn("EventFromCPP("+pointer+","+event.type+")");
    for (var i = 0; i < stored_events.length; i++) {
        if (pointer === stored_events[i].pointer) {
            stored_events[i].dispatchEvent(event);
        }
    }
}

var EventTarget = function(pointer) {
    this.pointer = pointer;
    this.listeners = {};

    EventTarget.prototype.listeners = null;
    EventTarget.prototype.addEventListener = function(type, callback, useCapture) {
        //console.warn("addEventListener this.pointer = "+this.pointer+", type = "+type);
        if (stored_events.indexOf(this) < 0) {
            stored_events.push(this);
        }
        CPP_DKEventTarget_addEventListener(this.pointer, type, callback);
        if (!(type in this.listeners)) {
            this.listeners[type] = [];
        }
        this.listeners[type].push(callback);
    }
    ;
    EventTarget.prototype.removeEventListener = function(type, callback, useCapture) {
        //console.warn("removeEventListener this.pointer = "+this.pointer);
        CPP_DKEventTarget_removeEventListener(this.pointer, type, callback);
        if (!(type in this.listeners)) {
            return;
        }
        var stack = this.listeners[type];
        for (var i = 0, l = stack.length; i < l; i++) {
            if (stack[i] === callback) {
                stack.splice(i, 1);
                return;
            }
        }
    }
    ;
    EventTarget.prototype.dispatchEvent = function(event) {
        //console.warn("dispatchEvent this.pointer = "+this.pointer);
        if (!(event.type in this.listeners)) {
            return true;
        }
        var stack = this.listeners[event.type].slice();
        for (var i = 0, l = stack.length; i < l; i++) {
            //console.warn("dispatchEvent(): pointer = "+this.pointer);

            if (this.pointer === "window") {
                event.currentTarget = window;
            } else {
                event.currentTarget = new HTMLElement(this.pointer);
            }

            //event.currentTarget = this;

            stack[i].call(this, event);
        }
        return !event.defaultPrevented;
    }
    ;
};
