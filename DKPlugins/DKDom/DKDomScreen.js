//https://developer.mozilla.org/en-US/docs/Web/API/Screen

//////////////////////////////
var Screen = function(pointer)
{
	Object.defineProperty(this, "availTop", { 
		get: function(){ return CPP_DKDomScreen_availTop(this.pointer); } 
	});
	Object.defineProperty(this, "availLeft", {
		get: function(){ return CPP_DKDomScreen_availLeft(this.pointer); } 
	});
	Object.defineProperty(this, "availHeight", {
		get: function(){ return CPP_DKDomScreen_availHeight(this.pointer); } 
	});
	Object.defineProperty(this, "availWidth", {
		get: function(){ return CPP_DKDomScreen_availWidth(this.pointer); } 
	});
	Object.defineProperty(this, "colorDepth", {
		get: function(){ return CPP_DKDomScreen_colorDepth(this.pointer); } 
	});
	Object.defineProperty(this, "height", { 
		get: function(){ return CPP_DKDomScreen_height(this.pointer); } 
	});
	Object.defineProperty(this, "left", {
		get: function(){ return CPP_DKDomScreen_left(this.pointer); } 
	});
	Object.defineProperty(this, "orientation", {
		get: function(){ return CPP_DKDomScreen_orientation(this.pointer); } 
	});
	Object.defineProperty(this, "pixelDepth", {
		get: function(){ return CPP_DKDomScreen_pixelDepth(this.pointer); } 
	});
	Object.defineProperty(this, "top", {
		get: function(){ return CPP_DKDomScreen_top(this.pointer); } 
	});
	Object.defineProperty(this, "width", {
		get: function(){ return CPP_DKDomScreen_width(this.pointer); } 
	});
	Object.defineProperty(this, "mozEnabled", {
		get: function(){ return CPP_DKDomScreen_mozEnabled(this.pointer); } 
	});
	Object.defineProperty(this, "mozBrightness", {
		get: function(){ return CPP_DKDomScreen_mozBrightness(this.pointer); } 
	});
	
	Screen.prototype.lockOrientation   = function(orientation){ return CPP_DKDomScreen_lockOrientation(orientation); }
	Screen.prototype.unlockOrientation = function(){ return CPP_DKDomScreen_unlockOrientation(); }
	
	return EventTarget.call(this, pointer);
}

Screen.prototype = EventTarget.prototype;
var screen = new Screen("screen");