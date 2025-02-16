// [IDL] https://drafts.csswg.org/cssom-view/#the-screen-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Screen

// [Exposed=Window]
// interface Screen {
var Screen = function Screen(address) {
	//console.log("Screen("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKScreenDUK_constructor();

	
	// readonly attribute long availWidth;
	Object.defineProperty(this, "availWidth", {
        get: function availWidth()		{ return CPP_DKScreenDUK_availWidth(this.address) },
		//set: function availWidth(num)	{ return CPP_DKScreenDUK_availWidth(this.address, num) },
    })

	// readonly attribute long availHeight;
	Object.defineProperty(this, "availHeight", {
        get: function availHeight()		{ return CPP_DKScreenDUK_availHeight(this.address) },
		//set: function availHeight(num){ return CPP_DKScreenDUK_availHeight(this.address, num) },
    })
		
	// readonly attribute long width;
	Object.defineProperty(this, "width", {
        get: function width()			{ return CPP_DKScreenDUK_width(this.address) },
		//set: function width(num)		{ return CPP_DKScreenDUK_width(this.address, num) },
    })
		
	// readonly attribute long height;
	Object.defineProperty(this, "height", {
        get: function height()			{ return CPP_DKScreenDUK_height(this.address) },
		//set: function height(num)		{ return CPP_DKScreenDUK_height(this.address, num) },
    })
	
	// readonly attribute unsigned long colorDepth;
	Object.defineProperty(this, "colorDepth", {
        get: function colorDepth()		{ return CPP_DKScreenDUK_colorDepth(this.address) },
		//set: function colorDepth(num)	{ return CPP_DKScreenDUK_colorDepth(this.address, num) },
    })
	
	// readonly attribute unsigned long pixelDepth;
	Object.defineProperty(this, "pixelDepth", {
        get: function pixelDepth()		{ return CPP_DKScreenDUK_pixelDepth(this.address) },
		//set: function pixelDepth(num)	{ return CPP_DKScreenDUK_pixelDepth(this.address, num) },
    })
		
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Screen]" }
	
	return EventTarget.call(this)
}
Screen.prototype = EventTarget.prototype
