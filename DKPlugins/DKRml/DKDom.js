//https://www.w3schools.com/js/js_htmldom_navigation.asp
//https://developer.mozilla.org/en-US/docs/Web/API/Window
//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

Object.defineProperty(window, "closed",                { get: function(){ /* return DKRml_closed(this.pointer); */           } });
Object.defineProperty(window, "console",               { get: function(){ return console;                                    } });
Object.defineProperty(window, "controllers",           { get: function(){ /* return DKRml_controllers(this.pointer); */      } });
Object.defineProperty(window, "customElements",        { get: function(){ /* return DKRml_customElements(this.pointer); */   } });
Object.defineProperty(window, "crypto",                { get: function(){ /* return DKRml_crypto(this.pointer); */           } });
Object.defineProperty(window, "devicePixelRatio",      { 
	get: function()   {  return DKRml_devicePixelRatio(this.pointer);      },
	set: function(val){  return DKRml_devicePixelRatio(this.pointer, val); }
});
Object.defineProperty(window, "dialogArguments",       { get: function(){ /* return DKRml_dialogArguments(this.pointer); */  } });
Object.defineProperty(window, "document",              { get: function(){ return document;                                   } });
Object.defineProperty(window, "event",                 { get: function(){ /* return DKRml_event(this.pointer); */            } });
Object.defineProperty(window, "frameElement",          { get: function(){ /* return DKRml_frameElement(this.pointer); */     } });
Object.defineProperty(window, "frames",                { get: function(){ /* return DKRml_frames(this.pointer); */           } });
Object.defineProperty(window, "fullScreen", {
	get: function()   { /* return DKRml_fullScreen(this.pointer); */      },
	set: function(val){ /* return DKRml_fullScreen(this.pointer, val); */ }
});
Object.defineProperty(window, "history",               { get: function(){ /* return DKRml_history(this.pointer); */          } });
Object.defineProperty(window, "innerHeight",           { get: function(){ return DKRml_innerHeight();                        } });
Object.defineProperty(window, "innerWidth",            { get: function(){ return DKRml_innerWidth();                         } });
Object.defineProperty(window, "isSecureContext",       { get: function(){ /* return DKRml_isSecureContext(); */              } });
Object.defineProperty(window, "length",                { get: function(){ /* return DKRml_length(); */                       } });
Object.defineProperty(window, "location",              { get: function(){ return location;                                   } });
Object.defineProperty(window, "locationbar",           { get: function(){ /* return DKRml_locationbar(); */                  } });
Object.defineProperty(window, "localStorage",          { get: function(){ /* return DKRml_localStorage(); */                 } });
Object.defineProperty(window, "menubar",               { get: function(){ /* return DKRml_menubar(); */                      } });
Object.defineProperty(window, "messageManager",        { get: function(){ /* return DKRml_messageManager(); */               } });
Object.defineProperty(window, "mozAnimationStartTime", { get: function(){ /* return DKRml_mozAnimationStartTime(); */        } });
Object.defineProperty(window, "mozInnerScreenX",       { get: function(){ /* return DKRml_mozInnerScreenX(); */              } });
Object.defineProperty(window, "mozInnerScreenY",       { get: function(){ /* return DKRml_mozInnerScreenX(); */              } });
Object.defineProperty(window, "mozPaintCount",         { get: function(){ /* return DKRml_mozPaintCount(); */                } });
Object.defineProperty(window, "name", { 
	get: function()   { return DKRml_name();    },
	set: function(val){ return DKRml_name(val); }  
});
Object.defineProperty(window, "navigator",             { get: function(){ return navigator;                                  } });
Object.defineProperty(window, "opener",                { get: function(){ /* return DKRml_opener(); */                       } });
Object.defineProperty(window, "orientation",           { get: function(){ /* return DKRml_orientation(); */                  } });
Object.defineProperty(window, "outerHeight",           { get: function(){ /* return DKRml_outerHeight(); */                  } });
Object.defineProperty(window, "outerWidth",            { get: function(){ /* return DKRml_outerWidth(); */                   } });
Object.defineProperty(window, "pageXOffset",           { get: function(){ /* return DKRml_pageXOffset(); */                  } });
Object.defineProperty(window, "pageYOffset",           { get: function(){ /* return DKRml_pageYOffset(); */                  } });
Object.defineProperty(window, "parent",                { get: function(){ /* return DKRml_parent(); */                       } });
Object.defineProperty(window, "performance",           { get: function(){ /* return DKRml_performance(); */                  } });
Object.defineProperty(window, "personalbar",           { get: function(){ /* return DKRml_personalbar(); */                  } });
Object.defineProperty(window, "returnValue",           { get: function(){ /* return DKRml_returnValue(); */                  } });
Object.defineProperty(window, "screen",                { get: function(){ return screen;                                     } });
Object.defineProperty(window, "screenX",               { get: function(){ /* return DKRml_screenX(); */                      } });
Object.defineProperty(window, "screenY",               { get: function(){ /* return DKRml_screenY(); */                      } });
Object.defineProperty(window, "scrollbars",            { get: function(){ /* return DKRml_scrollbars(); */                   } });
Object.defineProperty(window, "scrollMaxX",            { get: function(){ /* return DKRml_scrollMaxX(); */                   } });
Object.defineProperty(window, "scrollMaxY",            { get: function(){ /* return DKRml_scrollMaxY(); */                   } });
Object.defineProperty(window, "scrollX",               { get: function(){ /* return DKRml_scrollX(); */                      } });
Object.defineProperty(window, "scrollY",               { get: function(){ /* return DKRml_scrollY(); */                      } });
Object.defineProperty(window, "self",                  { get: function(){ /* return DKRml_self(); */                         } });
Object.defineProperty(window, "sessionStorage",        { get: function(){ /* return DKRml_sessionStorage(); */               } });
Object.defineProperty(window, "sidebar",               { get: function(){ /* return DKRml_sidebar(); */                      } });
Object.defineProperty(window, "speechSynthesis",       { get: function(){ /* return DKRml_speechSynthesis(); */              } });
Object.defineProperty(window, "status", {
	get: function()   { /* return DKRml_status(); */   },
	set: function(val){ /* return DKRml_setStatus(); */ }
});
Object.defineProperty(window, "statusbar",             { get: function(){ /* return DKRml_statusbar(); */                    } });
Object.defineProperty(window, "toolbar",               { get: function(){ /* return DKRml_toolbar(); */                      } });
Object.defineProperty(window, "top",                   { get: function(){ /* return DKRml_top(); */                          } });
Object.defineProperty(window, "visualViewport",        { get: function(){ /* return DKRml_visualViewport(); */               } });
Object.defineProperty(window, "window",                { get: function(){ /* return DKRml_window(); */                       } }); 

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