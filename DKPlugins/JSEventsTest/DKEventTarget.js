// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget
// [INTERFACE] https://dom.spec.whatwg.org/#interface-eventtarget

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

instances = [];

// [EventTarget()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/EventTarget
var EventTarget = function EventTarget(pointer) {

    this.pointer = pointer;
    for (var i = 0; i < instances.length; i++) {
        if (instances[i].pointer === pointer)
            return instances[i]; //return already existing instance
    }
    instances.push(this); //create instance
    this.listeners = {};

	// [EventTarget.addEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
    Object.defineProperty(this, "addEventListener", {
        value: function addEventListener(type, callback, useCapture) {
            if (!(type in this.listeners))
                this.listeners[type] = [];
            if (this.listeners[type].indexOf(callback) === -1)
                this.listeners[type].push(callback) //Do not allow duplicate entries
            //CPP_DKEventTarget_addEventListener(pointer, type, callback);
            //Add or overwrite the event in RmlUi
        }
    });
	// [EventTarget.removeEventListener()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
    Object.defineProperty(this, "removeEventListener", {
        value: function removeEventListener(type, callback, useCapture) {
            if (!(type in this.listeners))
                return;
            var stack = this.listeners[type];
            for (var i = 0, l = stack.length; i < l; i++) {
                if (stack[i] === callback) {
                    //console.log(stack[i]);
                    stack.splice(i, 1);
                    this.listeners[type].splice(i, 1);
                    //CPP_DKEventTarget_removeEventListener(pointer, type, callback);
                    //Remove the event in RmlUi
                    return;
                }
            }
        }
    });
	// [EventTarget.dispatchEvent()] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/dispatchEvent
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

	////// toString //////
	if(this.toString() === "[object Object]"){
		this.toString = function(){
			return "[object EventTarget]"
		}
	}
	
	GlobalEventHandlers.call(this, pointer);
    return this;
};
