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
		//set: function caches(str)	{ return CPP_DKWindow_caches(this.address, str) },
    })
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	Object.defineProperty(this, "clientInformation", {
        get: function clientInformation()		{ return CPP_DKWindow_clientInformation(this.address) },
		//set: function clientInformation(str)	{ return CPP_DKWindow_clientInformation(this.address, str) },
    })
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	Object.defineProperty(this, "closed", {
        get: function closed()		{ return CPP_DKWindow_closed(this.address) },
		//set: function closed(flag){ return CPP_DKWindow_closed(this.address, flag) },
    })
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	Object.defineProperty(this, "console", {
        get: function console()		{ return CPP_DKWindow_console(this.address) },
		//set: function console(str){ return CPP_DKWindow_console(this.address, str) },
    })
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	Object.defineProperty(this, "credentialless", {
        get: function credentialless()		{ return CPP_DKWindow_credentialless(this.address) },
		//set: function credentialless(flag){ return CPP_DKWindow_credentialless(this.address, flag) },
    })
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	Object.defineProperty(this, "crypto", {
        get: function crypto()		{ return CPP_DKWindow_crypto(this.address) },
		//set: function crypto(str)	{ return CPP_DKWindow_crypto(this.address, str) },
    })
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	Object.defineProperty(this, "customElements", {
        get: function customElements()		{ return CPP_DKWindow_customElements(this.address) },
		//set: function customElements(str)	{ return CPP_DKWindow_customElements(this.address, str) },
    })

	
	////// toString //////
	//// toString ////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	return EventTarget.call(this)
};
Window.prototype = EventTarget.prototype;
