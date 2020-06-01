//https://developer.mozilla.org/en-US/docs/Web/API/Event

/////////////////////////////
var Event = function(pointer)
{
	this.pointer = pointer;
	
	//Properties
	Object.defineProperty(this, "bubbles",                { get: function(){ return DKEvent_bubbles(this.pointer);                } }); //Read Only
	Object.defineProperty(this, "cancelBubble",           { get: function(){ return DKEvent_cancelBubble(this.pointer);           } });
	Object.defineProperty(this, "cancelable",             { get: function(){ return DKEvent_cancelable(this.pointer);             } }); //Read Only
	Object.defineProperty(this, "composed",               { get: function(){ return DKEvent_composed(this.pointer);               } }); //Read Only
	Object.defineProperty(this, "currentTarget",          { get: function(){ return DKEvent_currentTarget(this.pointer);          } }); //Read Only
	Object.defineProperty(this, "deepPath",               { get: function(){ return DKEvent_deepPath(this.pointer);               } }); //Not standardized
	Object.defineProperty(this, "defaultPrevented",       { get: function(){ return DKEvent_defaultPrevented(this.pointer);       } }); //Read Only
	Object.defineProperty(this, "eventPhase",             { get: function(){ return DKEvent_eventPhase(this.pointer);             } }); //Read Only
	Object.defineProperty(this, "explicitOriginalTarget", { get: function(){ return DKEvent_explicitOriginalTarget(this.pointer); } }); //Not standardized, Read Only
	Object.defineProperty(this, "originalTarget",         { get: function(){ return DKEvent_originalTarget(this.pointer);         } }); //Not standardized, Read only
	Object.defineProperty(this, "returnValue",            { get: function(){ return DKEvent_returnValue(this.pointer);            } });
	Object.defineProperty(this, "srcElement",             { get: function(){ return DKEvent_srcElement(this.pointer);             } }); //Not standardized
	Object.defineProperty(this, "target",                 { get: function(){ return DKEvent_target(this.pointer);                 } }); //Read Only
	Object.defineProperty(this, "timeStamp",              { get: function(){ return DKEvent_timeStamp(this.pointer);              } }); //Read Only
	Object.defineProperty(this, "type",                   { get: function(){ return DKEvent_type(this.pointer);                   } }); //Read Only
	Object.defineProperty(this, "isTrusted",              { get: function(){ return DKEvent_isTrusted(this.pointer);              } }); //Read Only
	
	//Obsolete properties
	Object.defineProperty(this, "scoped",                 { get: function(){ return DKEvent_scoped(this.pointer);                 } }); //Read Only, Obsolete
	
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