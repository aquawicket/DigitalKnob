// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/EventTarget.idl
// [SOURCE] https://dom.spec.whatwg.org/#interface-eventtarget
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/EventTarget


// Source: DOM Standard (https://dom.spec.whatwg.org/)
// [Exposed=*]
// interface EventTarget {
// constructor();
var EventTarget = function EventTarget(address) {
	console.log("EventTarget("+address+")")

    if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKEventTargetDUK_constructor();
	
	/*
    for (var i = 0; i < instances.length; i++) {
        if (instances[i].address === address)
            return instances[i]; //return already existing instance
    }
    instances.push(this); //create instance
    this.callbacks = {};
	*/

	// undefined addEventListener(DOMString type, EventListener? callback, optional (AddEventListenerOptions or boolean) options = {});
    Object.defineProperty(this, "addEventListener", {
        value: function addEventListener(type, callback, useCapture) {
            /*
			if (!(type in this.callbacks))
                this.callbacks[type] = [];
            if (this.callbacks[type].indexOf(callback) === -1)
                this.callbacks[type].push(callback) //Do not allow duplicate entries
			*/
            CPP_DKEventTargetDUK_addEventListener(this.address, type, callback);
        },
    });
	
	// undefined removeEventListener(DOMString type, EventListener? callback, optional (EventListenerOptions or boolean) options = {});
    Object.defineProperty(this, "removeEventListener", {
        value: function removeEventListener(type, callback, useCapture) {
			/*
            if (!(type in this.callbacks))
                return;
            var stack = this.callbacks[type];
            for (var i = 0, l = stack.length; i < l; i++) {
                if (stack[i] === callback) {
                    //console.log(stack[i]);
                    stack.splice(i, 1);
                    this.callbacks[type].splice(i, 1);
                    return;
                }
            }
			*/
			CPP_DKEventTargetDUK_removeEventListener(this.address, type, callback);
        },
    });
	
	// boolean dispatchEvent(Event event);
    Object.defineProperty(this, "dispatchEvent", {
        value: function dispatchEvent(event) {
			/*
            if (!(event.type in this.callbacks)) {
                return true;
            }
            var stack = this.callbacks[event.type].slice();
            for (var i = 0; i < stack.length; i++) {
                stack[i].call(this, event);
            }
            */
			CPP_DKEventTargetDUK_dispatchEvent(this.address, event.address);
			return !event.defaultPrevented;
        },
    });


	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object EventTarget]" }
	
	
	//GlobalEventHandlers.call(this, this.address);
    return this;
};
