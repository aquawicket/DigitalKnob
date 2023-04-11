// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window


// [Window()] https://developer.mozilla.org/en-US/docs/Web/API/Window
var Window = function Window(address) {
	//console.log("Window("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKWindow();

	
	////// Instance properties //////
	// [Window.caches](Read only)
	Object.defineProperty(this, "caches", {
        get: function caches()		{ return CPP_DKWindow_caches(this.address) },
		set: function caches(str)	{ return CPP_DKWindow_caches(this.address, str) },
    })
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	Object.defineProperty(this, "clientInformation", {
        get: function clientInformation()		{ return CPP_DKWindow_clientInformation(this.address) },
		set: function clientInformation(str)	{ return CPP_DKWindow_clientInformation(this.address, str) },
    })

	
	////// toString //////
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	return EventTarget.call(this)
};
Window.prototype = EventTarget.prototype;
