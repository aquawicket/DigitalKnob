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

/////////////////////////
function DK_Id(event, id)
{
	DKDEBUGFUNC(event, id);
	var element = DKWidget_GetElement(event);
	//DKWARN("DK_Id(): element="+element.id+"\n");
	if((element == window || element == document) && id == "GLOBAL"){ return true; }
	if(element && element.id == id){ return true; }
	if(event[0] && event[0] == id){ return true; }
	return false;
}

/////////////////////////////
function DK_Type(event, type)
{
	//DKDEBUGFUNC(event, type);
	//console.warn("DK_Type("+event.type+","+type+")");
	if(!event){ return false;}
	
	if(event.type && event.type == "contextmenu"){ //rightclick
		PreventDefault(event);
	}
	if(event.type && event.type == type){
		return true;
	}
	if(event.type && "window_"+event.type == type){ //window_resize
		return true;
	}
	if(event[1] && event[1] == type){ 
		return true;
	}
	//console.error("DK_Type("+event+","+type+"): cannot match the type");
	return false;
}