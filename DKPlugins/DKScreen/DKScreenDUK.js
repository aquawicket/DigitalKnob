// [INTERFACE] https://w3c.github.io/csswg-drafts/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen


var Screen = function Screen(address) {
	//console.log("Screen("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKScreenDUK();

	
	////// Instance properties //////
	// [Screen.availTop](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availTop
	Object.defineProperty(this, "availTop", {
        get: function availTop()		{ return CPP_DKScreenDUK_availTop(this.address) },
		//set: function availTop(num)	{ return CPP_DKScreenDUK_availTop(this.address, num) },
    })
	// [Screen.availLeft](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/availLeft
	Object.defineProperty(this, "availLeft", {
        get: function availLeft()		{ return CPP_DKScreenDUK_availLeft(this.address) },
		//set: function availLeft(num)	{ return CPP_DKScreenDUK_availLeft(this.address, num) },
    })
	// [Screen.availHeight] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availHeight
	Object.defineProperty(this, "availHeight", {
        get: function availHeight()		{ return CPP_DKScreenDUK_availHeight(this.address) },
		//set: function availHeight(num){ return CPP_DKScreenDUK_availHeight(this.address, num) },
    })
	// [Screen.availWidth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/availWidth
	Object.defineProperty(this, "availWidth", {
        get: function availWidth()		{ return CPP_DKScreenDUK_availWidth(this.address) },
		//set: function availWidth(num)	{ return CPP_DKScreenDUK_availWidth(this.address, num) },
    })
	// [Screen.colorDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/colorDepth
	Object.defineProperty(this, "colorDepth", {
        get: function colorDepth()		{ return CPP_DKScreenDUK_colorDepth(this.address) },
		//set: function colorDepth(num)	{ return CPP_DKScreenDUK_colorDepth(this.address, num) },
    })
	// [Screen.height] https://developer.mozilla.org/en-US/docs/Web/API/Screen/height
	Object.defineProperty(this, "height", {
        get: function height()		{ return CPP_DKScreenDUK_height(this.address) },
		//set: function height(num)	{ return CPP_DKScreenDUK_height(this.address, num) },
    })
	// [Screen.left](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/left
	Object.defineProperty(this, "left", {
        get: function left()		{ return CPP_DKScreenDUK_left(this.address) },
		//set: function left(num)	{ return CPP_DKScreenDUK_left(this.address, num) },
    })
	// [Screen.orientation] https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientation
	Object.defineProperty(this, "orientation", {
        get: function orientation()		{ return CPP_DKScreenDUK_orientation(this.address) },
		//set: function orientation(str){ return CPP_DKScreenDUK_orientation(this.address, str) },
    })
	// [Screen.pixelDepth] https://developer.mozilla.org/en-US/docs/Web/API/Screen/pixelDepth
	Object.defineProperty(this, "pixelDepth", {
        get: function pixelDepth()		{ return CPP_DKScreenDUK_pixelDepth(this.address) },
		//set: function pixelDepth(num)	{ return CPP_DKScreenDUK_pixelDepth(this.address, num) },
    })
	// [Screen.top](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/top
	Object.defineProperty(this, "top", {
        get: function top()		{ return CPP_DKScreenDUK_top(this.address) },
		//set: function top(num){ return CPP_DKScreenDUK_top(this.address, num) },
    })
	// [Screen.width] https://developer.mozilla.org/en-US/docs/Web/API/Screen/width
	Object.defineProperty(this, "width", {
        get: function width()		{ return CPP_DKScreenDUK_width(this.address) },
		//set: function width(num)	{ return CPP_DKScreenDUK_width(this.address, num) },
    })
	// [Screen.mozEnabled](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozEnabled
	Object.defineProperty(this, "mozEnabled", {
        get: function mozEnabled()		{ return CPP_DKScreenDUK_mozEnabled(this.address) },
		//set: function mozEnabled(flag){ return CPP_DKScreenDUK_mozEnabled(this.address, flag) },
    })
	// [Screen.mozBrightness](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/mozBrightness
	Object.defineProperty(this, "mozBrightness", {
        get: function mozBrightness()		{ return CPP_DKScreenDUK_mozBrightness(this.address) },
		//set: function mozBrightness(num)	{ return CPP_DKScreenDUK_mozBrightness(this.address, num) },
    })
	
	
	////// Instance methods //////
	// [Screen.lockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	Screen.prototype.lockOrientation = function lockOrientation(orientation) {
		return CPP_DKScreenDUK_lockOrientation(this.address, orientation)
    }
	// [Screen.unlockOrientation](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	Screen.prototype.unlockOrientation = function unlockOrientation() {
		return CPP_DKScreenDUK_unlockOrientation(this.address)
    }
	
	
	////// Events //////
	// [orientationchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Screen/orientationchange_event
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Screen]" }
	
	
	return EventTarget.call(this)
}
Screen.prototype = EventTarget.prototype
