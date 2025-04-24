//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

/*
var stored_events = [];
var EventFromCPP = function EventFromCPP(pointer, event)
{
	//console.warn("EventFromCPP("+pointer+","+event.type+")")
	for(var i=0; i<stored_events.length; i++){
		if(pointer === stored_events[i].pointer){
			stored_events[i].dispatchEvent(event)
		}
	}
}
*/

// https://dom.spec.whatwg.org/#interface-eventtarget
instances = [];
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEventTarget.js
var EventTarget = function EventTarget(pointer) {
    this.pointer = pointer;
    for (var i = 0; i < instances.length; i++) {
        if (instances[i].pointer === pointer)
            return instances[i]; //return already existing instance
=======
var EventTarget = function EventTarget(pointer){
    this.pointer = pointer;
    for (var i = 0; i < instances.length; i++){
        if (instances[i].pointer === pointer){
            return instances[i];
            //return already existing instance
        }
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEventTarget.js
    }
    //console.log("creating instance "+pointer)
    instances.push(this)
    //EventTarget.prototype.listeners = null;
    this.listeners = {};
    Object.defineProperty(this, "addEventListener", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEventTarget.js
        value: function addEventListener(type, callback, useCapture) {
            if (!(type in this.listeners))
                this.listeners[type] = [];
            if (this.listeners[type].indexOf(callback) === -1)
                this.listeners[type].push(callback) //Do not allow duplicate entries
            CPP_DKDomEventTarget_addEventListener(pointer, type, callback)
=======
        value: function addEventListener(type, callback, useCapture){
            if (!(type in this.listeners)){
                this.listeners[type] = [];
            }
            if (this.listeners[type].indexOf(callback) === -1){
                //Do not allow duplicate entries
                this.listeners[type].push(callback);
            }
            CPP_DKEventTarget_addEventListener(pointer, type, callback);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEventTarget.js
            //Add or overwrite the event in RmlUi
        }
    })
    Object.defineProperty(this, "removeEventListener", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEventTarget.js
        value: function removeEventListener(type, callback, useCapture) {
            if (!(type in this.listeners))
=======
        value: function removeEventListener(type, callback, useCapture){
            if (!(type in this.listeners)){
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEventTarget.js
                return;
            var stack = this.listeners[type];
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEventTarget.js
            for (var i = 0, l = stack.length; i < l; i++) {
                if (stack[i] === callback) {
                    //console.log(stack[i])
                    stack.splice(i, 1)
                    this.listeners[type].splice(i, 1)
                    CPP_DKDomEventTarget_removeEventListener(pointer, type, callback)
=======
            for (var i = 0, l = stack.length; i < l; i++){
                if (stack[i] === callback){
                    //console.log(stack[i]);
                    stack.splice(i, 1);
                    this.listeners[type].splice(i, 1);
                    CPP_DKEventTarget_removeEventListener(pointer, type, callback);
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEventTarget.js
                    //Remove the event in RmlUi
                    return;
                }
            }
        }
    })
    Object.defineProperty(this, "dispatchEvent", {
<<<<<<< HEAD:DKPlugins/DKDom/DKDomEventTarget.js
        value: function dispatchEvent(event) {
			if(!this){
				console.error("dispatchEvent(): this invalid"); 
				return false;
			}
			if(!this.listeners){
				console.error("dispatchEvent(): this.listeners invalid"); 
				return false;
			}
			if(!event){
				console.error("dispatchEvent(): event invalid");
				return false;
			}
			if(!event.type){
				console.error("dispatchEvent(): event.type invalid"); 
				return false;
			}
            if(!(event.type in this.listeners))
                return true;
			
			/*
			//print event variable
			console.log("--------EVENT-------------------------")
			console.log(" event                  = "+event)
			console.log(" event.type             = "+event.type)
			console.log(" event.currentTarget    = "+event.currentTarget)
			console.log(" event.currentTarget.id = "+event.currentTarget.id)
			console.log(" event.value            = "+event.value)
			console.log("--------------------------------------")
			*/
			
            var stack = this.listeners[event.type].slice()
            for (var i = 0; i < stack.length; i++)
                stack[i] && stack[i].call(this, event)
=======
        value: function dispatchEvent(event){
            if (!(event.type in this.listeners)){
                return true;
            }
            var stack = this.listeners[event.type].slice();
            for (var i = 0; i < stack.length; i++){
                stack[i].call(this, event);
            }
>>>>>>> Development:DKCpp/plugins/DKDuktapeDom/DKEventTarget.js
            return !event.defaultPrevented;
        }
    })
	GlobalEventHandlers.call(this, pointer)
    return this;
};