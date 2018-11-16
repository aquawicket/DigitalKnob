function DKScreen_Init(){}

//////////////////////////////
var Screen = function(pointer)
{
	//DKDEBUGFUNC();
	//console.warn("Screen("+pointer+")");
	
	Object.defineProperty(this, "availTop",      { get: function(){ return DKScreen_availTop(this.pointer);      } });  //TODO
	Object.defineProperty(this, "availLeft",     { get: function(){ return DKScreen_availLeft(this.pointer);     } });  //TODO
	Object.defineProperty(this, "availHeight",   { get: function(){ return DKScreen_availHeight(this.pointer);   } });  //TODO
	Object.defineProperty(this, "availWidth",    { get: function(){ return DKScreen_availWidth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "colorDepth",    { get: function(){ return DKScreen_colorDepth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "height",        { get: function(){ return DKScreen_height(this.pointer);        } });  //TODO
	Object.defineProperty(this, "left",          { get: function(){ return DKScreen_left(this.pointer);          } });  //TODO
	Object.defineProperty(this, "orientation",   { get: function(){ return DKScreen_orientation(this.pointer);   } });  //TODO
	Object.defineProperty(this, "pixelDepth",    { get: function(){ return DKScreen_pixelDepth(this.pointer);    } });  //TODO
	Object.defineProperty(this, "top",           { get: function(){ return DKScreen_top(this.pointer);           } });  //TODO
	Object.defineProperty(this, "width",         { get: function(){ return DKScreen_width(this.pointer);         } });  //TODO
	Object.defineProperty(this, "mozEnabled",    { get: function(){ return DKScreen_mozEnabled(this.pointer);    } });  //TODO
	Object.defineProperty(this, "mozBrightness", { get: function(){ return DKScreen_mozBrightness(this.pointer); } });  //TODO
	
	Screen.prototype.lockOrientation = function(orientation){
		//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	}
	Screen.prototype.unlockOrientation = function(){
		//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	}
	
	return EventTarget.call(this, pointer);
}
Screen.prototype = EventTarget.prototype;

var screen = new Screen("screen");