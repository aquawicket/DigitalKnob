var stored_events = [];

//////////////////////////////////////////////
var EventFromRocket = function(pointer, event)
{
	//DKWARN("EventFromRocket("+pointer+","+event.type+")");
	for(var i=0; i<stored_events.length; i++){
		if(pointer == stored_events[i].pointer){
			stored_events[i].dispatchEvent(event);
		}
	}
}

///////////////////////////////////
var EventTarget = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("EventTarget("+pointer+")");
	
	this.pointer = pointer;
	this.listeners = {};
	
	EventTarget.prototype.listeners = null;
	EventTarget.prototype.addEventListener = function(type, callback, useCapture){
		console.warn("addEventListener this.pointer = "+this.pointer);
		if(stored_events.indexOf(this) < 0){
			stored_events.push(this);
		}
		if(this.pointer != "window"){
			DKEventTarget_addEventListner(this.pointer, type, callback);
			//DKRocket_addEventListener(this.pointer, type, useCapture);
		}
		if(!(type in this.listeners)){
			this.listeners[type] = [];
		}
		this.listeners[type].push(callback);
	};
	EventTarget.prototype.removeEventListener = function(type, callback, useCapture){
		DKEventTarget_removeEventListner(this.pointer, type, callback);
		//DKRocket_removeEventListener(this.pointer, type, useCapture);
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
	};
	EventTarget.prototype.dispatchEvent = function(event){
		if(!(event.type in this.listeners)){
			return true;
		}
		var stack = this.listeners[event.type].slice();
		for (var i = 0, l = stack.length; i < l; i++){
			console.warn("dispatchEvent(): pointer = "+this.pointer);
			if(this.pointer != "window"){
				event.currentTarget = new HTMLElement(this.pointer);
			}
			stack[i].call(this, event);
		}
		return !event.defaultPrevented;
	};
};


//These functions may be overwritten by DK/DK.js
///////////////////////////////////////
function DKAddEvent(id, type, Function)
{
	console.warn("DKAddEvent("+id+","+type+",Function)")
	if(id == "GLOBAL"){
		var global = new EventTarget("GLOBAL");
		global.addEventListener(type, Function, false);
		return true;
	}
	var element = document.getElementById(id);
	if(element){
		element.addEventListner(type, Function);
	}
}

//////////////////////////////////////////
function DKRemoveEvent(id, type, Function)
{
	console.warn("DKRemoveEvent("+id+","+type+",Function)")
	if(id == "GLOBAL"){
		var global = new EventTarget("GLOBAL");
		global.removeEventListner(type, Function, false);
		return true;
	}
	var element = document.getElementById(id);
	if(element){
		element.removeEventListner(type, Function);
	}
}

/////////////////////////////////
function DKRemoveEvents(Function)
{
	//TODO
}