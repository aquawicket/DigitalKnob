//https://developer.mozilla.org/en-US/docs/Web/API/Window

//////////////////////////////
var Window = function(pointer)
{
	Object.defineProperty(window, "closed",                { get: function(){ /* return DKDomWindow_closed(this.pointer); */           } });
	Object.defineProperty(window, "console",               { get: function(){ return console;                                    } });
	Object.defineProperty(window, "controllers",           { get: function(){ /* return DKDomWindow_controllers(this.pointer); */      } });
	Object.defineProperty(window, "customElements",        { get: function(){ /* return DKDomWindow_customElements(this.pointer); */   } });
	Object.defineProperty(window, "crypto",                { get: function(){ /* return DKDomWindow_crypto(this.pointer); */           } });
	Object.defineProperty(window, "devicePixelRatio",      { 
		get: function()   {  return DKDomWindow_devicePixelRatio(this.pointer);      },
		set: function(val){  return DKDomWindow_devicePixelRatio(this.pointer, val); }
	});
	Object.defineProperty(window, "dialogArguments",       { get: function(){ /* return DKDomWindow_dialogArguments(this.pointer); */  } });
	Object.defineProperty(window, "document",              { get: function(){ return document;                                   } });
	Object.defineProperty(window, "event",                 { get: function(){ /* return DKDomWindow_event(this.pointer); */            } });
	Object.defineProperty(window, "frameElement",          { get: function(){ /* return DKDomWindow_frameElement(this.pointer); */     } });
	Object.defineProperty(window, "frames",                { get: function(){ /* return DKDomWindow_frames(this.pointer); */           } });
	Object.defineProperty(window, "fullScreen", {
		get: function()   { /* return DKDomWindow_fullScreen(this.pointer); */      },
		set: function(val){ /* return DKDomWindow_fullScreen(this.pointer, val); */ }
	});
	Object.defineProperty(window, "history",               { get: function(){ /* return DKDomWindow_history(this.pointer); */          } });
	Object.defineProperty(window, "innerHeight",           { get: function(){ return DKDomWindow_innerHeight();                        } });
	Object.defineProperty(window, "innerWidth",            { get: function(){ return DKDomWindow_innerWidth();                         } });
	Object.defineProperty(window, "isSecureContext",       { get: function(){ /* return DKDomWindow_isSecureContext(); */              } });
	Object.defineProperty(window, "length",                { get: function(){ /* return DKDomWindow_length(); */                       } });
	Object.defineProperty(window, "location",              { get: function(){ return location;                                   } });
	Object.defineProperty(window, "locationbar",           { get: function(){ /* return DKDomWindow_locationbar(); */                  } });
	Object.defineProperty(window, "localStorage",          { get: function(){ /* return DKDomWindow_localStorage(); */                 } });
	Object.defineProperty(window, "menubar",               { get: function(){ /* return DKDomWindow_menubar(); */                      } });
	Object.defineProperty(window, "messageManager",        { get: function(){ /* return DKDomWindow_messageManager(); */               } });
	Object.defineProperty(window, "mozAnimationStartTime", { get: function(){ /* return DKDomWindow_mozAnimationStartTime(); */        } });
	Object.defineProperty(window, "mozInnerScreenX",       { get: function(){ /* return DKDomWindow_mozInnerScreenX(); */              } });
	Object.defineProperty(window, "mozInnerScreenY",       { get: function(){ /* return DKDomWindow_mozInnerScreenX(); */              } });
	Object.defineProperty(window, "mozPaintCount",         { get: function(){ /* return DKDomWindow_mozPaintCount(); */                } });
	Object.defineProperty(window, "name", { 
		get: function()   { return DKDomWindow_name();    },
		set: function(val){ return DKDomWindow_name(val); }  
	});
	Object.defineProperty(window, "navigator",             { get: function(){ return navigator;                                  } });
	Object.defineProperty(window, "opener",                { get: function(){ /* return DKDomWindow_opener(); */                       } });
	Object.defineProperty(window, "orientation",           { get: function(){ /* return DKDomWindow_orientation(); */                  } });
	Object.defineProperty(window, "outerHeight",           { get: function(){ /* return DKDomWindow_outerHeight(); */                  } });
	Object.defineProperty(window, "outerWidth",            { get: function(){ /* return DKDomWindow_outerWidth(); */                   } });
	Object.defineProperty(window, "pageXOffset",           { get: function(){ /* return DKDomWindow_pageXOffset(); */                  } });
	Object.defineProperty(window, "pageYOffset",           { get: function(){ /* return DKDomWindow_pageYOffset(); */                  } });
	Object.defineProperty(window, "parent",                { get: function(){ /* return DKDomWindow_parent(); */                       } });
	Object.defineProperty(window, "performance",           { get: function(){ /* return DKDomWindow_performance(); */                  } });
	Object.defineProperty(window, "personalbar",           { get: function(){ /* return DKDomWindow_personalbar(); */                  } });
	Object.defineProperty(window, "returnValue",           { get: function(){ /* return DKDomWindow_returnValue(); */                  } });
	Object.defineProperty(window, "screen",                { get: function(){ return screen;                                     } });
	Object.defineProperty(window, "screenX",               { get: function(){ /* return DKDomWindow_screenX(); */                      } });
	Object.defineProperty(window, "screenY",               { get: function(){ /* return DKDomWindow_screenY(); */                      } });
	Object.defineProperty(window, "scrollbars",            { get: function(){ /* return DKDomWindow_scrollbars(); */                   } });
	Object.defineProperty(window, "scrollMaxX",            { get: function(){ /* return DKDomWindow_scrollMaxX(); */                   } });
	Object.defineProperty(window, "scrollMaxY",            { get: function(){ /* return DKDomWindow_scrollMaxY(); */                   } });
	Object.defineProperty(window, "scrollX",               { get: function(){ /* return DKDomWindow_scrollX(); */                      } });
	Object.defineProperty(window, "scrollY",               { get: function(){ /* return DKDomWindow_scrollY(); */                      } });
	Object.defineProperty(window, "self",                  { get: function(){ /* return DKDomWindow_self(); */                         } });
	Object.defineProperty(window, "sessionStorage",        { get: function(){ /* return DKDomWindow_sessionStorage(); */               } });
	Object.defineProperty(window, "sidebar",               { get: function(){ /* return DKDomWindow_sidebar(); */                      } });
	Object.defineProperty(window, "speechSynthesis",       { get: function(){ /* return DKDomWindow_speechSynthesis(); */              } });
	Object.defineProperty(window, "status", {
		get: function()   { /* return DKDomWindow_status(); */   },
		set: function(val){ /* return DKDomWindow_setStatus(); */ }
	});
	Object.defineProperty(window, "statusbar",             { get: function(){ /* return DKDomWindow_statusbar(); */                    } });
	Object.defineProperty(window, "toolbar",               { get: function(){ /* return DKDomWindow_toolbar(); */                      } });
	Object.defineProperty(window, "top",                   { get: function(){ /* return DKDomWindow_top(); */                          } });
	Object.defineProperty(window, "visualViewport",        { get: function(){ /* return DKDomWindow_visualViewport(); */               } });
	Object.defineProperty(window, "window",                { get: function(){ /* return DKDomWindow_window(); */                       } }); 
	
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