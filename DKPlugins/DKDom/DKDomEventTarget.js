//https://developer.mozilla.org/en-US/docs/Web/API/EventTarget

var stored_events = [];

///////////////////////////////////////////
var EventFromCPP = function(pointer, event)
{
	//DKDEBUGFUNC();
	//console.warn("EventFromCPP("+pointer+","+event.type+")");
	for(var i=0; i<stored_events.length; i++){
		if(pointer == stored_events[i].pointer){
			stored_events[i].dispatchEvent(event);
		}
	}
}

instances = [];
///////////////////////////////////
var EventTarget = function(pointer)
{
	this.pointer = pointer;
	for(var i=0; i<instances.length; i++){
        if(instances[i].pointer == pointer){
			//console.log("return existing instance "+pointer);
            return instances[i];
        }
    }
	
	//console.log("creating instance "+pointer);
	instances.push(this);
	
	this.listeners = {};
	
	//EventTarget.prototype.listeners = null;

	Object.defineProperty(this, "addEventListener", {
		value: function(type, callback, useCapture){
			//console.log("EventTarget.addEventListener("+type+")");
			if(stored_events.indexOf(this) < 0){
				stored_events.push(this);
			}
			DKDomEventTarget_addEventListener(pointer, type, callback);
			if(!(type in this.listeners)){
				this.listeners[type] = [];
			}
			this.listeners[type].push(callback);
		} 
	});
	Object.defineProperty(this, "removeEventListener", {
		value: function(type, callback, useCapture){
			console.log("EventTarget.removeEventListener("+type+")");
			DKDomEventTarget_removeEventListener(pointer, type, callback);
			if(!(type in this.listeners)){
				return;
			}
			var stack = this.listeners[type];
			for(var i = 0, l = stack.length; i < l; i++){
				if(stack[i] === callback){
					stack.splice(i, 1);
					return;
				}
			}
		} 
	});
	Object.defineProperty(this, "dispatchEvent", {
		value: function(event){
			//console.log("dispatchEvent("+event.currentTarget+")")
			if(!(event.type in this.listeners)){
				return true;
			}
			var stack = this.listeners[event.type].slice();
			for(var i = 0, l = stack.length; i < l; i++){
				/*
				if(pointer == "window"){
					event.currentTarget = window;
				}
				else{
					event.currentTarget = new HTMLElement(pointer);
				}
				*/
				
				//event.currentTarget = this;
				//console.log(i);
				stack[i].call(this, event);
				return;
			}
			return !event.defaultPrevented;
		} 
	});
	
	return this;
};