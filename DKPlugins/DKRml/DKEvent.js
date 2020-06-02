//https://developer.mozilla.org/en-US/docs/Web/API/Event

/////////////////////////////
var Event = function(pointer)
{
	this.pointer = pointer;
	
	//Properties
	Object.defineProperty(this, "bubbles",                { get: function(){ return DKEvent_bubbles(this.pointer);                } }); //Read Only
	Object.defineProperty(this, "cancelBubble", { 
		set: function(flag){ 
			return DKEvent_cancelBubble(this.pointer, flag);
		}
	});
	Object.defineProperty(this, "cancelable",             { get: function(){ return DKEvent_cancelable(this.pointer);             } }); //Read Only
	Object.defineProperty(this, "composed",               { get: function(){ return DKEvent_composed(this.pointer);               } }); //Read Only
	Object.defineProperty(this, "currentTarget", { 
		get: function(){ 
			var elementPointer = DKEvent_currentTarget(this.pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "deepPath",               { get: function(){ return DKEvent_deepPath(this.pointer);               } }); //Not standardized
	Object.defineProperty(this, "defaultPrevented",       { get: function(){ return DKEvent_defaultPrevented(this.pointer);       } }); //Read Only
	Object.defineProperty(this, "eventPhase",             { get: function(){ return DKEvent_eventPhase(this.pointer);             } }); //Read Only
	Object.defineProperty(this, "explicitOriginalTarget", { get: function(){ return DKEvent_explicitOriginalTarget(this.pointer); } }); //Not standardized, Read Only
	Object.defineProperty(this, "originalTarget",         { get: function(){ return DKEvent_originalTarget(this.pointer);         } }); //Not standardized, Read only
	Object.defineProperty(this, "returnValue",            { get: function(){ return DKEvent_returnValue(this.pointer);            } });
	Object.defineProperty(this, "srcElement", { //Not standardized
		get: function(){ 
			var elementPointer = DKEvent_srcElement(this.pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "target", { //Read Only
		get: function(){ 
			var elementPointer = DKEvent_target(this.pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "timeStamp",              { get: function(){ return DKEvent_timeStamp(this.pointer);              } }); //Read Only
	Object.defineProperty(this, "type",                   { get: function(){ return DKEvent_type(this.pointer);                   } }); //Read Only
	Object.defineProperty(this, "isTrusted",              { get: function(){ return DKEvent_isTrusted(this.pointer);              } }); //Read Only
	
	//Obsolete properties
	Object.defineProperty(this, "scoped",                 { get: function(){ return DKEvent_scoped(this.pointer);                 } }); //Read Only, Obsolete
	
	//Methods
	Event.prototype.createEvent = function(){ //Deprecated
		DKEvent_createEvent(this.pointer);
	};
	Event.prototype.composedPath = function(){
		DKEvent_composedPath(this.pointer);
	};
	Event.prototype.initEvent = function(){ //Deprecated
		DKEvent_initEvent(this.pointer);
	};
	Event.prototype.preventDefault = function(){
		DKEvent_preventDefault(this.pointer);
	};
	Event.prototype.stopImmediatePropagation = function(){
		DKEvent_stopImmediatePropagation(this.pointer);
	};
	Event.prototype.stopPropagation = function(){
		DKEvent_stopPropagation(this.pointer);
	};
	
	//Obsolete methods
	Event.prototype.getPreventDefault = function(){ //Not standardized
		DKEvent_getPreventDefault(this.pointer);
	};
	Event.prototype.preventBubble = function(){ //Not standardized, Obsolete
		DKEvent_preventBubble(this.pointer);
	};
	Event.prototype.preventCapture = function(){ //Not standardized, Obsolete
		DKEvent_preventCapture(this.pointer);
	};
	
	return this;
};