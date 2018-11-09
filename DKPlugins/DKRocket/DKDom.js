//https://hackernoon.com/inheritance-in-javascript-21d2b82ffa6f

var window;
//var objectMap;
//var stored_objects = [];

/////////////////////
function DKDom_Init()
{
	DKDEBUGFUNC();
}

////////////////////
function DKDom_End()
{
	DKDEBUGFUNC();
}

/////////////////////////////
function DKDom_OnEvent(event)
{
	DKDEBUGFUNC(event);
}

/*
//////////////////////////
var ObjectMap = function()
{
	this.pointers = [];
	this.objects = [];
	
	ObjectMap.prototype.add = function(pointer, obj){
		if(this.objects.indexOf(obj) > -1){ return null; }
		this.pointers.push(pointer);
		this.objects.push(obj);
	}
	ObjectMap.prototype.get = function(pointer, type){
		//DKWARN("objectMap:get("+pointer+")");
		var i = this.pointers.indexOf(pointer);
		if(i < 0){ return null; }
		
		if(this.objects[i] instanceof type){
			DKWARN("objectMap:get found match");
			return this.objects[i];
		}
		return null;
	}
	ObjectMap.prototype.print = function(){
		for(var i=0; i<this.pointers.length; i++){
			DKWARN(this.pointers[i]+" "+this.objects[i]);
		}
	}
}
*/


//////////////////////////////
var Window = function(pointer)
{
	//DKDEBUGFUNC();
	Object.defineProperty(this, "closed",                { get: function(){ return DKRocket_closed(this.pointer);           } });  //TODO
	Object.defineProperty(this, "console",               { get: function(){ return console;                                 } });
	Object.defineProperty(this, "controllers",           { get: function(){ return DKRocket_controllers(this.pointer);      } });  //TODO
	Object.defineProperty(this, "customElements",        { get: function(){ return DKRocket_customElements(this.pointer);   } });  //TODO
	Object.defineProperty(this, "crypto",                { get: function(){ return DKRocket_crypto(this.pointer);           } });  //TODO
	Object.defineProperty(this, "devicePixelRatio",      { get: function(){ return DKRocket_devicePixelRatio(this.pointer); } });  //TODO
	Object.defineProperty(this, "dialogArguments",       { get: function(){ return DKRocket_dialogArguments(this.pointer);  } });  //TODO
	Object.defineProperty(this, "document",              { get: function(){ return document;                                } });
	Object.defineProperty(this, "event",                 { get: function(){ return DKRocket_event(this.pointer);            } });  //TODO
	Object.defineProperty(this, "frameElement",          { get: function(){ return DKRocket_frameElement(this.pointer);     } });  //TODO
	Object.defineProperty(this, "frames",                { get: function(){ return DKRocket_frames(this.pointer);           } });  //TODO
	Object.defineProperty(this, "fullScreen", {
		get: function()   { return DKRocket_fullScreen(this.pointer);      },
		set: function(val){ return DKRocket_fullScreen(this.pointer, val); }
	});  //TODO
	Object.defineProperty(this, "history",               { get: function(){ return DKRocket_history(this.pointer);          } });  //TODO
	Object.defineProperty(this, "innerHeight",           { get: function(){ return DKRocket_innerHeight();                  } });  //TODO
	Object.defineProperty(this, "innerWidth",            { get: function(){ return DKRocket_innerWidth();                   } });  //TODO
	Object.defineProperty(this, "isSecureContext",       { get: function(){ return DKRocket_isSecureContext();              } });  //TODO, Experimental
	Object.defineProperty(this, "length",                { get: function(){ return DKRocket_length();                       } });  //TODO
	Object.defineProperty(this, "location",              { get: function(){ return location;                                } });
	Object.defineProperty(this, "locationbar",           { get: function(){ return DKRocket_locationbar();                  } });  //TODO
	Object.defineProperty(this, "localStorage",          { get: function(){ return DKRocket_localStorage();                 } });  //TODO
	Object.defineProperty(this, "menubar",               { get: function(){ return DKRocket_menubar();                      } });  //TODO
	Object.defineProperty(this, "messageManager",        { get: function(){ return DKRocket_messageManager();               } });  //TODO
	Object.defineProperty(this, "mozAnimationStartTime", { get: function(){ return DKRocket_mozAnimationStartTime();        } });  //TODO, Deprecated
	Object.defineProperty(this, "mozInnerScreenX",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
	Object.defineProperty(this, "mozInnerScreenY",       { get: function(){ return DKRocket_mozInnerScreenX();              } });  //TODO
	Object.defineProperty(this, "mozPaintCount",         { get: function(){ return DKRocket_mozPaintCount();                } });  //TODO
	Object.defineProperty(this, "name", { 
		get: function()   { return DKRocket_name();    },
		set: function(val){ return DKRocket_setName(); }  
	});  //TODO
	Object.defineProperty(this, "navigator",             { get: function(){ return navigator;                               } });
	Object.defineProperty(this, "opener",                { get: function(){ return DKRocket_opener();                       } });  //TODO
	Object.defineProperty(this, "orientation",           { get: function(){ return DKRocket_orientation();                  } });  //TODO, Deprecated
	Object.defineProperty(this, "outerHeight",           { get: function(){ return DKRocket_outerHeight();                  } });  //TODO
	Object.defineProperty(this, "outerWidth",            { get: function(){ return DKRocket_outerWidth();                   } });  //TODO
	Object.defineProperty(this, "pageXOffset",           { get: function(){ return DKRocket_pageXOffset();                  } });  //TODO
	Object.defineProperty(this, "pageYOffset",           { get: function(){ return DKRocket_pageYOffset();                  } });  //TODO
	Object.defineProperty(this, "parent",                { get: function(){ return DKRocket_parent ();                      } });  //TODO
	Object.defineProperty(this, "performance",           { get: function(){ return DKRocket_performance();                  } });  //TODO
	Object.defineProperty(this, "personalbar",           { get: function(){ return DKRocket_personalbar();                  } });  //TODO
	Object.defineProperty(this, "returnValue",           { get: function(){ return DKRocket_returnValue();                  } });  //TODO
	Object.defineProperty(this, "screen",                { get: function(){ return screen;                                  } });  //TODO
	Object.defineProperty(this, "screenX",               { get: function(){ return DKRocket_screenX();                      } });  //TODO
	Object.defineProperty(this, "screenY",               { get: function(){ return DKRocket_screenY();                      } });  //TODO
	Object.defineProperty(this, "scrollbars",            { get: function(){ return DKRocket_scrollbars();                   } });  //TODO
	Object.defineProperty(this, "scrollMaxX",            { get: function(){ return DKRocket_scrollMaxX();                   } });  //TODO
	Object.defineProperty(this, "scrollMaxY",            { get: function(){ return DKRocket_scrollMaxY();                   } });  //TODO
	Object.defineProperty(this, "scrollX",               { get: function(){ return DKRocket_scrollX();                      } });  //TODO
	Object.defineProperty(this, "scrollY",               { get: function(){ return DKRocket_scrollY();                      } });  //TODO
	Object.defineProperty(this, "self",                  { get: function(){ return DKRocket_self();                         } });  //TODO
	Object.defineProperty(this, "sessionStorage",        { get: function(){ return DKRocket_sessionStorage();               } });  //TODO
	Object.defineProperty(this, "sidebar",               { get: function(){ return DKRocket_sidebar();                      } });  //TODO
	Object.defineProperty(this, "speechSynthesis",       { get: function(){ return DKRocket_speechSynthesis();              } });  //TODO
	Object.defineProperty(this, "status", {
		get: function()   { return DKRocket_status();    },
		set: function(val){ return DKRocket_setStatus(); }
	});  //TODO
	Object.defineProperty(this, "statusbar",             { get: function(){ return DKRocket_statusbar();                    } });  //TODO
	Object.defineProperty(this, "toolbar",               { get: function(){ return DKRocket_toolbar();                      } });  //TODO
	Object.defineProperty(this, "top",                   { get: function(){ return DKRocket_top();                          } });  //TODO
	Object.defineProperty(this, "visualViewport",        { get: function(){ return DKRocket_visualViewport();               } });  //TODO
	Object.defineProperty(this, "window",                { get: function(){ return DKRocket_window();                       } });  //TODO
	
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
	
	return EventTarget.call(this, pointer);
}
Window.prototype = EventTarget.prototype;


////// Create Global Window Object /////////
//objectMap = new ObjectMap();
window = new Window("window");