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
        get: function caches()		{ return JSON.parse(CPP_DKWindow_caches(this.address)) },
		//set: function caches(str)	{ return JSON.parse(CPP_DKWindow_caches(this.address, JSON.stringify(str))) },
		configurable: true
    })

	
	////// toString //////
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	var eventTarget = EventTarget.call(this)
	
	// Make properties (Read Only) after assignment
	//Object.defineProperty(this, "???", 		{ set: undefined })
	
	return eventTarget
};
Window.prototype = EventTarget.prototype;
