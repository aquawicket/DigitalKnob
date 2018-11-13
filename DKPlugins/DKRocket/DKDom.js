//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

Window.defineProperty(this, "closed",                { get: function(){ return DKRocket_closed(this.pointer);           } });  //TODO
Window.defineProperty(this, "console",               { get: function(){ return console;                                 } });
Window.defineProperty(this, "controllers",           { get: function(){ return DKRocket_controllers(this.pointer);      } });  //TODO
Window.defineProperty(this, "customElements",        { get: function(){ return DKRocket_customElements(this.pointer);   } });  //TODO
Window.defineProperty(this, "crypto",                { get: function(){ return DKRocket_crypto(this.pointer);           } });  //TODO
Window.defineProperty(this, "devicePixelRatio",      { get: function(){ return DKRocket_devicePixelRatio(this.pointer); } });  //TODO
Window.defineProperty(this, "dialogArguments",       { get: function(){ return DKRocket_dialogArguments(this.pointer);  } });  //TODO
Window.defineProperty(this, "document",              { get: function(){ return document;                                } });
Window.defineProperty(this, "event",                 { get: function(){ return DKRocket_event(this.pointer);            } });  //TODO
Window.defineProperty(this, "frameElement",          { get: function(){ return DKRocket_frameElement(this.pointer);     } });  //TODO
Window.defineProperty(this, "frames",                { get: function(){ return DKRocket_frames(this.pointer);           } });  //TODO
Window.defineProperty(this, "fullScreen", {
	get: function()   { return DKRocket_fullScreen(this.pointer);      },
	set: function(val){ return DKRocket_fullScreen(this.pointer, val); }
});  //TODO
Window.defineProperty(this, "history",               { get: function(){ return DKRocket_history(this.pointer);          } });  //TODO
Window.defineProperty(this, "innerHeight",           { get: function(){ return DKRocket_innerHeight();                  } });  //TODO
Window.defineProperty(this, "innerWidth",            { get: function(){ return DKRocket_innerWidth();                   } });  //TODO
Window.defineProperty(this, "isSecureContext",       { get: function(){ return DKRocket_isSecureContext();              } });  //TODO, Experimental
Window.defineProperty(this, "length",                { get: function(){ return DKRocket_length();                       } });  //TODO
Window.defineProperty(this, "location",              { get: function(){ return location;                                } });
Window.defineProperty(this, "locationbar",           { get: function(){ return DKRocket_locationbar();                  } });  //TODO
Window.defineProperty(this, "localStorage",          { get: function(){ return DKRocket_localStorage();                 } });  //TODO
Window.defineProperty(this, "menubar",               { get: function(){ return DKRocket_menubar();                      } });  //TODO
Window.defineProperty(this, "messageManager",        { get: function(){ return DKRocket_messageManager();               } });  //TODO
Window.defineProperty(this, "mozAnimationStartTime", { get: function(){ return DKRocket_mozAnimationStartTime();        } });  //TODO, Deprecated
Window.defineProperty(this, "mozInnerScreenX",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
Window.defineProperty(this, "mozInnerScreenY",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
Window.defineProperty(this, "mozPaintCount",         { get: function(){ return DKRocket_mozPaintCount();                } });  //TODO
Window.defineProperty(this, "name", { 
	get: function()   { return DKRocket_name();    },
	set: function(val){ return DKRocket_setName(); }  
});  //TODO
Window.defineProperty(this, "navigator",             { get: function(){ return navigator;                               } });
Window.defineProperty(this, "opener",                { get: function(){ return DKRocket_opener();                       } });  //TODO
Window.defineProperty(this, "orientation",           { get: function(){ return DKRocket_orientation();                  } });  //TODO, Deprecated
Window.defineProperty(this, "outerHeight",           { get: function(){ return DKRocket_outerHeight();                  } });  //TODO
Window.defineProperty(this, "outerWidth",            { get: function(){ return DKRocket_outerWidth();                   } });  //TODO
Window.defineProperty(this, "pageXOffset",           { get: function(){ return DKRocket_pageXOffset();                  } });  //TODO
Window.defineProperty(this, "pageYOffset",           { get: function(){ return DKRocket_pageYOffset();                  } });  //TODO
Window.defineProperty(this, "parent",                { get: function(){ return DKRocket_parent ();                      } });  //TODO
Window.defineProperty(this, "performance",           { get: function(){ return DKRocket_performance();                  } });  //TODO
Window.defineProperty(this, "personalbar",           { get: function(){ return DKRocket_personalbar();                  } });  //TODO
Window.defineProperty(this, "returnValue",           { get: function(){ return DKRocket_returnValue();                  } });  //TODO
Window.defineProperty(this, "screen",                { get: function(){ return screen;                                  } });  //TODO
Window.defineProperty(this, "screenX",               { get: function(){ return DKRocket_screenX();                      } });  //TODO
Window.defineProperty(this, "screenY",               { get: function(){ return DKRocket_screenY();                      } });  //TODO
Window.defineProperty(this, "scrollbars",            { get: function(){ return DKRocket_scrollbars();                   } });  //TODO
Window.defineProperty(this, "scrollMaxX",            { get: function(){ return DKRocket_scrollMaxX();                   } });  //TODO
Window.defineProperty(this, "scrollMaxY",            { get: function(){ return DKRocket_scrollMaxY();                   } });  //TODO
Window.defineProperty(this, "scrollX",               { get: function(){ return DKRocket_scrollX();                      } });  //TODO
Window.defineProperty(this, "scrollY",               { get: function(){ return DKRocket_scrollY();                      } });  //TODO
Window.defineProperty(this, "self",                  { get: function(){ return DKRocket_self();                         } });  //TODO
Window.defineProperty(this, "sessionStorage",        { get: function(){ return DKRocket_sessionStorage();               } });  //TODO
Window.defineProperty(this, "sidebar",               { get: function(){ return DKRocket_sidebar();                      } });  //TODO
Window.defineProperty(this, "speechSynthesis",       { get: function(){ return DKRocket_speechSynthesis();              } });  //TODO
Window.defineProperty(this, "status", {
	get: function()   { return DKRocket_status();    },
	set: function(val){ return DKRocket_setStatus(); }
});  //TODO
Window.defineProperty(this, "statusbar",             { get: function(){ return DKRocket_statusbar();                    } });  //TODO
Window.defineProperty(this, "toolbar",               { get: function(){ return DKRocket_toolbar();                      } });  //TODO
Window.defineProperty(this, "top",                   { get: function(){ return DKRocket_top();                          } });  //TODO
Window.defineProperty(this, "visualViewport",        { get: function(){ return DKRocket_visualViewport();               } });  //TODO
Window.defineProperty(this, "window",                { get: function(){ return DKRocket_window();                       } });  //TODO

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