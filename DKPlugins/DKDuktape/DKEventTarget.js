//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

/*
var stored_events = [];
var EventFromCPP = function EventFromCPP(pointer, event)
{
	//console.warn("EventFromCPP("+pointer+","+event.type+")");
	for(var i=0; i<stored_events.length; i++){
		if(pointer === stored_events[i].pointer){
			stored_events[i].dispatchEvent(event);
		}
	}
}
*/

// https://dom.spec.whatwg.org/#interface-eventtarget
instances = [];
var EventTarget = function EventTarget(pointer) {
    this.pointer = pointer;
    for (var i = 0; i < instances.length; i++) {
        if (instances[i].pointer === pointer) {
            return instances[i];
            //return already existing instance
        }
    }
    //console.log("creating instance "+pointer);
    instances.push(this);

    //EventTarget.prototype.listeners = null;
    this.listeners = {};

    Object.defineProperty(this, "addEventListener", {
        value: function addEventListener(type, callback, useCapture) {
            if (!(type in this.listeners)) {
                this.listeners[type] = [];
            }
            if (this.listeners[type].indexOf(callback) === -1) {
                //Do not allow duplicate entries
                this.listeners[type].push(callback);
            }
            CPP_DKEventTarget_addEventListener(pointer, type, callback);
            //Add or overwrite the event in RmlUi
        }
    });
    Object.defineProperty(this, "removeEventListener", {
        value: function removeEventListener(type, callback, useCapture) {
            if (!(type in this.listeners)) {
                return;
            }
            var stack = this.listeners[type];
            for (var i = 0, l = stack.length; i < l; i++) {
                if (stack[i] === callback) {
                    //console.log(stack[i]);
                    stack.splice(i, 1);
                    this.listeners[type].splice(i, 1);
                    CPP_DKEventTarget_removeEventListener(pointer, type, callback);
                    //Remove the event in RmlUi
                    return;
                }
            }
        }
    });
    Object.defineProperty(this, "dispatchEvent", {
        value: function dispatchEvent(event) {
            if (!(event.type in this.listeners)) {
                return true;
            }
            var stack = this.listeners[event.type].slice();
            for (var i = 0; i < stack.length; i++) {
                stack[i].call(this, event);
            }
            return !event.defaultPrevented;
        }
    });

	GlobalEventHandlers.call(this, pointer);
    return this;
};