//https://developer.mozilla.org/en-US/docs/Web/API/Window

//////////////////////////////
var Window = function(pointer)
{
	Object.defineProperty(this, "closed", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_closed(pointer); */ } 
	});
	Object.defineProperty(this, "console", { 
		configurable: true,
		get: function(){ return console; } 
	});
	Object.defineProperty(this, "controllers", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_controllers(pointer); */ }
	});
	Object.defineProperty(this, "customElements", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_customElements(pointer); */ } 
	});
	Object.defineProperty(this, "crypto", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_crypto(pointer); */ } 
	});
	Object.defineProperty(this, "devicePixelRatio", {
		configurable: true,
		get: function()   {  return DKDomWindow_devicePixelRatio(pointer);      },
		set: function(val){  return DKDomWindow_devicePixelRatio(pointer, val); }
	});
	Object.defineProperty(this, "dialogArguments", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_dialogArguments(pointer); */ } 
	});
	Object.defineProperty(this, "document", { 
		configurable: true,
		get: function(){ return document; } 
	});
	Object.defineProperty(this, "event", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_event(pointer); */ } 
	});
	Object.defineProperty(this, "frameElement", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_frameElement(pointer); */ } 
	});
	Object.defineProperty(this, "frames", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_frames(pointer); */ }
	});
	Object.defineProperty(this, "fullScreen", {
		configurable: true,
		get: function()   { /* return DKDomWindow_fullScreen(pointer); */      },
		set: function(val){ /* return DKDomWindow_fullScreen(pointer, val); */ }
	});
	Object.defineProperty(this, "history", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_history(pointer); */ } 
	});
	Object.defineProperty(this, "innerHeight", { 
		configurable: true,
		get: function(){ return DKDomWindow_innerHeight(); } 
	});
	Object.defineProperty(this, "innerWidth", { 
		configurable: true,
		get: function(){ return DKDomWindow_innerWidth(); } 
	});
	Object.defineProperty(this, "isSecureContext", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_isSecureContext(); */ } 
	});
	Object.defineProperty(this, "length", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_length(); */ } 
	});
	Object.defineProperty(this, "location", { 
		configurable: true,
		get: function(){ return location; } 
	});
	Object.defineProperty(this, "locationbar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_locationbar(); */ } 
	});
	Object.defineProperty(this, "localStorage", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_localStorage(); */ } 
	});
	Object.defineProperty(this, "menubar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_menubar(); */ } 
	});
	Object.defineProperty(this, "messageManager", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_messageManager(); */ } 
	});
	Object.defineProperty(this, "mozAnimationStartTime", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_mozAnimationStartTime(); */ } 
	});
	Object.defineProperty(this, "mozInnerScreenX", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_mozInnerScreenX(); */ } 
	});
	Object.defineProperty(this, "mozInnerScreenY", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_mozInnerScreenX(); */ } 
	});
	Object.defineProperty(this, "mozPaintCount", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_mozPaintCount(); */ } 
	});
	Object.defineProperty(this, "name", { 
		configurable: true,
		get: function()   { return DKDomWindow_name();    },
		set: function(val){ return DKDomWindow_name(val); }  
	});
	Object.defineProperty(this, "navigator", { 
		configurable: true,
		get: function(){ return navigator; } 
	});
	Object.defineProperty(this, "opener", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_opener(); */ } 
	});
	Object.defineProperty(this, "orientation", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_orientation(); */ } 
	});
	Object.defineProperty(this, "outerHeight", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_outerHeight(); */ } 
	});
	Object.defineProperty(this, "outerWidth", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_outerWidth(); */ } 
	});
	Object.defineProperty(this, "pageXOffset", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_pageXOffset(); */ } 
	});
	Object.defineProperty(this, "pageYOffset", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_pageYOffset(); */ } 
	});
	Object.defineProperty(this, "parent", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_parent(); */ } 
	});
	Object.defineProperty(this, "performance", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_performance(); */ } 
	});
	Object.defineProperty(this, "personalbar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_personalbar(); */ } 
	});
	Object.defineProperty(this, "returnValue", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_returnValue(); */ } 
	});
	Object.defineProperty(this, "screen", { 
		configurable: true,
		get: function(){ return screen; } 
	});
	Object.defineProperty(this, "screenX", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_screenX(); */ } 
	});
	Object.defineProperty(this, "screenY", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_screenY(); */ } 
	});
	Object.defineProperty(this, "scrollbars", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_scrollbars(); */ } 
	});
	Object.defineProperty(this, "scrollMaxX", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_scrollMaxX(); */ } 
	});
	Object.defineProperty(this, "scrollMaxY", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_scrollMaxY(); */ } 
	});
	Object.defineProperty(this, "scrollX", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_scrollX(); */ } 
	});
	Object.defineProperty(this, "scrollY", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_scrollY(); */ } 
	});
	Object.defineProperty(this, "self", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_self(); */ } 
	});
	Object.defineProperty(this, "sessionStorage", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_sessionStorage(); */ } 
	});
	Object.defineProperty(this, "sidebar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_sidebar(); */ } 
	});
	Object.defineProperty(this, "speechSynthesis", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_speechSynthesis(); */ } 
	});
	Object.defineProperty(this, "status", {
		configurable: true,
		get: function()   { /* return DKDomWindow_status(); */   },
		set: function(val){ /* return DKDomWindow_setStatus(); */ }
	});
	Object.defineProperty(this, "statusbar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_statusbar(); */ } 
	});
	Object.defineProperty(this, "toolbar", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_toolbar(); */ } 
	});
	Object.defineProperty(this, "top", {
		configurable: true,
		get: function(){ return this; } 
	});
	Object.defineProperty(this, "visualViewport", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_visualViewport(); */ } 
	});
	Object.defineProperty(this, "window", { 
		configurable: true,
		get: function(){ /* return DKDomWindow_window(); */ } 
	}); 
	
	Window.prototype.alert = function(msg){ console.warn("alert: "+msg); }
	Window.prototype.blur = function(){}
	Window.prototype.cancelAnimationFrame = function(){}
	Window.prototype.cancelIdleCallback = function(){}
	Window.prototype.captureEvents = function(){}
	Window.prototype.clearImmediate = function(){}
	Window.prototype.close = function(){}
	Window.prototype.confirm = function(){}
	Window.prototype.dispatchEvent = function(){}
	Window.prototype.dump = function(){}
	Window.prototype.find = function(){}
	Window.prototype.focus = function(){}
	Window.prototype.getAttentionWithCycleCount = function(){}
	Window.prototype.getComputedStyle = function(){}
	Window.prototype.getDefaultComputedStyle = function(){}
	Window.prototype.getSelection = function(){}
	Window.prototype.matchMedia = function(){}
	Window.prototype.maximize = function(){}
	Window.prototype.minimize = function(){}
	Window.prototype.moveBy = function(){}
	Window.prototype.moveTo = function(x,y){ DKWindow_moveTo(x,y); }
	Window.prototype.open = function(){}
	Window.prototype.postMessage = function(){}
	Window.prototype.print = function(){}
	Window.prototype.prompt = function(){}
	Window.prototype.releaseEvents = function(){}
	Window.prototype.requestAnimationFrame = function(){}
	Window.prototype.requestIdleCallback = function(){}
	Window.prototype.resizeBy = function(){}
	Window.prototype.resizeTo = function(width, height){ DKWindow_resizeTo(width,height); }
	Window.prototype.scroll = function(){}
	Window.prototype.scrollBy = function(){}
	Window.prototype.scrollByLines = function(){}
	Window.prototype.scrollByPages = function(){}
	Window.prototype.scrollTo = function(){}
	Window.prototype.setCursor = function(){}
	Window.prototype.setImmediate = function(){}
	Window.prototype.setResizable = function(){}
	Window.prototype.sizeToContent = function(){}
	Window.prototype.stop = function(){}
	Window.prototype.updateCommands = function(){}

	return EventTarget.call(this, pointer);
}

Window.prototype = EventTarget.prototype;
var window = new Window("window"); //Create the global window object