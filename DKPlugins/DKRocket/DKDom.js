//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

Object.defineProperty(window, "closed",                { get: function(){ return DKRocket_closed(this.pointer);           } });  //TODO
Object.defineProperty(window, "console",               { get: function(){ return console;                                 } });
Object.defineProperty(window, "controllers",           { get: function(){ return DKRocket_controllers(this.pointer);      } });  //TODO
Object.defineProperty(window, "customElements",        { get: function(){ return DKRocket_customElements(this.pointer);   } });  //TODO
Object.defineProperty(window, "crypto",                { get: function(){ return DKRocket_crypto(this.pointer);           } });  //TODO
Object.defineProperty(window, "devicePixelRatio",      { get: function(){ return DKRocket_devicePixelRatio(this.pointer); } });  //TODO
Object.defineProperty(window, "dialogArguments",       { get: function(){ return DKRocket_dialogArguments(this.pointer);  } });  //TODO
Object.defineProperty(window, "document",              { get: function(){ return document;                                } });
Object.defineProperty(window, "event",                 { get: function(){ return DKRocket_event(this.pointer);            } });  //TODO
Object.defineProperty(window, "frameElement",          { get: function(){ return DKRocket_frameElement(this.pointer);     } });  //TODO
Object.defineProperty(window, "frames",                { get: function(){ return DKRocket_frames(this.pointer);           } });  //TODO
Object.defineProperty(window, "fullScreen", {
	get: function()   { return DKRocket_fullScreen(this.pointer);      },
	set: function(val){ return DKRocket_fullScreen(this.pointer, val); }
});  //TODO
Object.defineProperty(window, "history",               { get: function(){ return DKRocket_history(this.pointer);          } });  //TODO
Object.defineProperty(window, "innerHeight",           { get: function(){ return DKRocket_innerHeight();                  } });  //TODO
Object.defineProperty(window, "innerWidth",            { get: function(){ return DKRocket_innerWidth();                   } });  //TODO
Object.defineProperty(window, "isSecureContext",       { get: function(){ return DKRocket_isSecureContext();              } });  //TODO, Experimental
Object.defineProperty(window, "length",                { get: function(){ return DKRocket_length();                       } });  //TODO
Object.defineProperty(window, "location",              { get: function(){ return location;                                } });
Object.defineProperty(window, "locationbar",           { get: function(){ return DKRocket_locationbar();                  } });  //TODO
Object.defineProperty(window, "localStorage",          { get: function(){ return DKRocket_localStorage();                 } });  //TODO
Object.defineProperty(window, "menubar",               { get: function(){ return DKRocket_menubar();                      } });  //TODO
Object.defineProperty(window, "messageManager",        { get: function(){ return DKRocket_messageManager();               } });  //TODO
Object.defineProperty(window, "mozAnimationStartTime", { get: function(){ return DKRocket_mozAnimationStartTime();        } });  //TODO, Deprecated
Object.defineProperty(window, "mozInnerScreenX",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
Object.defineProperty(window, "mozInnerScreenY",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
Object.defineProperty(window, "mozPaintCount",         { get: function(){ return DKRocket_mozPaintCount();                } });  //TODO
Object.defineProperty(window, "name", { 
	get: function()   { return DKRocket_name();    },
	set: function(val){ return DKRocket_setName(); }  
});  //TODO
Object.defineProperty(window, "navigator",             { get: function(){ return navigator;                               } });
Object.defineProperty(window, "opener",                { get: function(){ return DKRocket_opener();                       } });  //TODO
Object.defineProperty(window, "orientation",           { get: function(){ return DKRocket_orientation();                  } });  //TODO, Deprecated
Object.defineProperty(window, "outerHeight",           { get: function(){ return DKRocket_outerHeight();                  } });  //TODO
Object.defineProperty(window, "outerWidth",            { get: function(){ return DKRocket_outerWidth();                   } });  //TODO
Object.defineProperty(window, "pageXOffset",           { get: function(){ return DKRocket_pageXOffset();                  } });  //TODO
Object.defineProperty(window, "pageYOffset",           { get: function(){ return DKRocket_pageYOffset();                  } });  //TODO
Object.defineProperty(window, "parent",                { get: function(){ return DKRocket_parent ();                      } });  //TODO
Object.defineProperty(window, "performance",           { get: function(){ return DKRocket_performance();                  } });  //TODO
Object.defineProperty(window, "personalbar",           { get: function(){ return DKRocket_personalbar();                  } });  //TODO
Object.defineProperty(window, "returnValue",           { get: function(){ return DKRocket_returnValue();                  } });  //TODO
Object.defineProperty(window, "screen",                { get: function(){ return screen;                                  } });  //TODO
Object.defineProperty(window, "screenX",               { get: function(){ return DKRocket_screenX();                      } });  //TODO
Object.defineProperty(window, "screenY",               { get: function(){ return DKRocket_screenY();                      } });  //TODO
Object.defineProperty(window, "scrollbars",            { get: function(){ return DKRocket_scrollbars();                   } });  //TODO
Object.defineProperty(window, "scrollMaxX",            { get: function(){ return DKRocket_scrollMaxX();                   } });  //TODO
Object.defineProperty(window, "scrollMaxY",            { get: function(){ return DKRocket_scrollMaxY();                   } });  //TODO
Object.defineProperty(window, "scrollX",               { get: function(){ return DKRocket_scrollX();                      } });  //TODO
Object.defineProperty(window, "scrollY",               { get: function(){ return DKRocket_scrollY();                      } });  //TODO
Object.defineProperty(window, "self",                  { get: function(){ return DKRocket_self();                         } });  //TODO
Object.defineProperty(window, "sessionStorage",        { get: function(){ return DKRocket_sessionStorage();               } });  //TODO
Object.defineProperty(window, "sidebar",               { get: function(){ return DKRocket_sidebar();                      } });  //TODO
Object.defineProperty(window, "speechSynthesis",       { get: function(){ return DKRocket_speechSynthesis();              } });  //TODO
Object.defineProperty(window, "status", {
	get: function()   { return DKRocket_status();    },
	set: function(val){ return DKRocket_setStatus(); }
});  //TODO
Object.defineProperty(window, "statusbar",             { get: function(){ return DKRocket_statusbar();                    } });  //TODO
Object.defineProperty(window, "toolbar",               { get: function(){ return DKRocket_toolbar();                      } });  //TODO
Object.defineProperty(window, "top",                   { get: function(){ return DKRocket_top();                          } });  //TODO
Object.defineProperty(window, "visualViewport",        { get: function(){ return DKRocket_visualViewport();               } });  //TODO
Object.defineProperty(window, "window",                { get: function(){ return DKRocket_window();                       } });  //TODO

Window.prototype.alert = function(msg){
	console.warn("alert: "+msg); //TODO - create an actual popup window
}
Window.prototype.blur = function(){
	//TODO
}
Window.prototype.cancelAnimationFrame = function(){
	//TODO
}
Window.prototype.cancelIdleCallback = function(){
	//TODO
}
Window.prototype.captureEvents = function(){
	//TODO, deprecated
}
Window.prototype.clearImmediate = function(){
	//TODO
}
Window.prototype.close = function(){
	//TODO
}
Window.prototype.confirm = function(){
	//TODO
}
Window.prototype.dispatchEvent = function(){
	//TODO
}
Window.prototype.dump = function(){
	//TODO
}
Window.prototype.find = function(){
	//TODO
}
Window.prototype.focus = function(){
	//TODO
}
Window.prototype.getAttentionWithCycleCount = function(){
	//TODO
}
Window.prototype.getComputedStyle = function(){
	//TODO
}
Window.prototype.getDefaultComputedStyle = function(){
	//TODO
}
Window.prototype.getSelection = function(){
	//TODO
}
Window.prototype.matchMedia = function(){
	//TODO
}
Window.prototype.maximize = function(){
	//TODO
}
Window.prototype.minimize = function(){
	//TODO
}
Window.prototype.moveBy = function(){
	//TODO
}
Window.prototype.moveTo = function(){
	//TODO
}
Window.prototype.open = function(){
	//TODO
}
Window.prototype.postMessage = function(){
	//TODO
}
Window.prototype.print = function(){
	//TODO
}
Window.prototype.prompt = function(){
	//TODO
}
Window.prototype.releaseEvents = function(){
	//TODO, deprecated
}
Window.prototype.requestAnimationFrame = function(){
	//TODO
}
Window.prototype.requestIdleCallback = function(){
	//TODO
}
Window.prototype.resizeBy = function(){
	//TODO
}
Window.prototype.resizeTo = function(){
	//TODO
}
Window.prototype.scroll = function(){
	//TODO
}
Window.prototype.scrollBy = function(){
	//TODO
}
Window.prototype.scrollByLines = function(){
	//TODO
}
Window.prototype.scrollByPages = function(){
	//TODO
}
Window.prototype.scrollTo = function(){
	//TODO
}
Window.prototype.setCursor = function(){
	//TODO
}
Window.prototype.setImmediate = function(){
	//TODO
}
Window.prototype.setResizable = function(){
	//TODO
}
Window.prototype.sizeToContent = function(){
	//TODO
}
Window.prototype.stop = function(){
	//TODO
}
Window.prototype.updateCommands = function(){
	//TODO
}