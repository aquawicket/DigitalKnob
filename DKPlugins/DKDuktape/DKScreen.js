//https://developer.mozilla.org/en-US/docs/Web/API/Screen

//////////////////////////////
var Screen = function(pointer)
{
	//DKDEBUGFUNC();
	
	Object.defineProperty(this, "availTop",      { get: function(){ return DKScreen_availTop(this.pointer);      } });
	Object.defineProperty(this, "availLeft",     { get: function(){ return DKScreen_availLeft(this.pointer);     } });
	Object.defineProperty(this, "availHeight",   { get: function(){ return DKScreen_availHeight(this.pointer);   } });
	Object.defineProperty(this, "availWidth",    { get: function(){ return DKScreen_availWidth(this.pointer);    } });
	Object.defineProperty(this, "colorDepth",    { get: function(){ return DKScreen_colorDepth(this.pointer);    } });
	Object.defineProperty(this, "height",        { get: function(){ return DKScreen_height(this.pointer);        } });
	Object.defineProperty(this, "left",          { get: function(){ return DKScreen_left(this.pointer);          } });
	Object.defineProperty(this, "orientation",   { get: function(){ return DKScreen_orientation(this.pointer);   } });
	Object.defineProperty(this, "pixelDepth",    { get: function(){ return DKScreen_pixelDepth(this.pointer);    } });
	Object.defineProperty(this, "top",           { get: function(){ return DKScreen_top(this.pointer);           } });
	Object.defineProperty(this, "width",         { get: function(){ return DKScreen_width(this.pointer);         } });
	Object.defineProperty(this, "mozEnabled",    { get: function(){ return DKScreen_mozEnabled(this.pointer);    } });
	Object.defineProperty(this, "mozBrightness", { get: function(){ return DKScreen_mozBrightness(this.pointer); } });
	
	Screen.prototype.lockOrientation   = function(orientation){ return DKScreen_lockOrientation(orientation); }
	Screen.prototype.unlockOrientation = function(){ return DKScreen_unlockOrientation(); }
	
	return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");