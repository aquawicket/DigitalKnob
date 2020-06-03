//https://developer.mozilla.org/en-US/docs/Web/API/Event

/////////////////////////////
var Event = function(pointer)
{
	//Properties
	Object.defineProperty(this, "bubbles",                { get: function(){ return DKEvent_bubbles(pointer);                } }); //Read Only
	Object.defineProperty(this, "cancelBubble", { 
		set: function(flag){ 
			return DKEvent_cancelBubble(pointer, flag);
		}
	});
	Object.defineProperty(this, "cancelable",             { get: function(){ return DKEvent_cancelable(pointer);             } }); //Read Only
	Object.defineProperty(this, "composed",               { get: function(){ return DKEvent_composed(pointer);               } }); //Read Only
	Object.defineProperty(this, "currentTarget", { 
		get: function(){ 
			var elementPointer = DKEvent_currentTarget(pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "deepPath",               { get: function(){ return DKEvent_deepPath(pointer);               } }); //Not standardized
	Object.defineProperty(this, "defaultPrevented",       { get: function(){ return DKEvent_defaultPrevented(pointer);       } }); //Read Only
	Object.defineProperty(this, "eventPhase",             { get: function(){ return DKEvent_eventPhase(pointer);             } }); //Read Only
	Object.defineProperty(this, "explicitOriginalTarget", { get: function(){ return DKEvent_explicitOriginalTarget(pointer); } }); //Not standardized, Read Only
	Object.defineProperty(this, "originalTarget",         { get: function(){ return DKEvent_originalTarget(pointer);         } }); //Not standardized, Read only
	Object.defineProperty(this, "returnValue",            { get: function(){ return DKEvent_returnValue(pointer);            } });
	Object.defineProperty(this, "srcElement", { //Not standardized
		get: function(){ 
			var elementPointer = DKEvent_srcElement(pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "target", { //Read Only
		get: function(){ 
			var elementPointer = DKEvent_target(pointer);
			if(!elementPointer){ return; }
			var element = new HTMLElement(elementPointer);
			return element;
		} 
	}); //Read Only
	Object.defineProperty(this, "timeStamp",              { get: function(){ return DKEvent_timeStamp(pointer);              } }); //Read Only
	Object.defineProperty(this, "type",                   { get: function(){ return DKEvent_type(pointer);                   } }); //Read Only
	Object.defineProperty(this, "isTrusted",              { get: function(){ return DKEvent_isTrusted(pointer);              } }); //Read Only
	
	//Obsolete properties
	Object.defineProperty(this, "scoped",                 { get: function(){ return DKEvent_scoped(pointer);                 } }); //Read Only, Obsolete
	
	//Methods
	Event.prototype.createEvent = function(){ //Deprecated
		DKEvent_createEvent(pointer);
	};
	Event.prototype.composedPath = function(){
		DKEvent_composedPath(pointer);
	};
	Event.prototype.initEvent = function(){ //Deprecated
		DKEvent_initEvent(pointer);
	};
	Event.prototype.preventDefault = function(){
		DKEvent_preventDefault(pointer);
	};
	Event.prototype.stopImmediatePropagation = function(){
		DKEvent_stopImmediatePropagation(pointer);
	};
	Event.prototype.stopPropagation = function(){
		DKEvent_stopPropagation(pointer);
	};
	
	//Obsolete methods
	Event.prototype.getPreventDefault = function(){ //Not standardized
		DKEvent_getPreventDefault(pointer);
	};
	Event.prototype.preventBubble = function(){ //Not standardized, Obsolete
		DKEvent_preventBubble(pointer);
	};
	Event.prototype.preventCapture = function(){ //Not standardized, Obsolete
		DKEvent_preventCapture(pointer);
	};
	
	return this;
};