//https://developer.mozilla.org/en-US/docs/Web/API/Event

//////////////////////////
var Event = function(type)
{
	//Properties
	Object.defineProperty(this, "bubbles",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "cancelBubble",{
		value: "TODO",
	});
	Object.defineProperty(this, "cancelable",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "composed",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "currentTarget",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "deepPath",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "defaultPrevented",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "eventPhase",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "explicitOriginalTarget",{ //Read only, Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "originalTarget",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "returnValue",{
		value: "TODO",
	});
	Object.defineProperty(this, "srcElement",{ //Not standardized
		value: "TODO",
	});
	Object.defineProperty(this, "target",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "timeStamp",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "type",{ //Read only
		value: "TODO",
	});
	Object.defineProperty(this, "isTrusted",{ //Read only
		value: "TODO",
	});
	
	//Obsolete properties
	Object.defineProperty(this, "scoped",{ //Read only, Obsolete
		value: "TODO",
	});
	
	//Methods
	Event.prototype.createEvent = function(){ //Deprecated
		//TODO
	};
	Event.prototype.composedPath = function(){
		//TODO
	};
	Event.prototype.initEvent = function(){ //Deprecated
		//TODO
	};
	Event.prototype.preventDefault = function(){
		//TODO
	};
	Event.prototype.stopImmediatePropagation = function(){
		//TODO
	};
	Event.prototype.stopPropagation = function(){
		//TODO
	};
	
	//Obsolete methods
	Event.prototype.getPreventDefault = function(){ //Not standardized
		//TODO
	};
	Event.prototype.preventBubble = function(){ //Not standardized, Obsolete
		//TODO
	};
	Event.prototype.preventCapture = function(){ //Not standardized, Obsolete
		//TODO
	};
};