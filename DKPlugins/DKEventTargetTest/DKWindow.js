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
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	Object.defineProperty(this, "devicePixelRatio", {
        get: function devicePixelRatio()		{ return CPP_DKWindow_devicePixelRatio(this.address) },
		//set: function devicePixelRatio(num)	{ return CPP_DKWindow_devicePixelRatio(this.address, num) },
    })
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	Object.defineProperty(this, "document", {
        get: function document()		{ return CPP_DKWindow_document(this.address) },
		//set: function document(str)	{ return CPP_DKWindow_document(this.address, str) },
    })
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	Object.defineProperty(this, "frameElement", {
        get: function frameElement()		{ return CPP_DKWindow_frameElement(this.address) },
		//set: function frameElement(str)	{ return CPP_DKWindow_frameElement(this.address, str) },
    })
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	Object.defineProperty(this, "frames", {
        get: function frames()		{ return CPP_DKWindow_frames(this.address) },
		//set: function frames(str)	{ return CPP_DKWindow_frames(this.address, str) },
    })
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	Object.defineProperty(this, "fullScreen", {
        get: function fullScreen()		{ return CPP_DKWindow_fullScreen(this.address) },
		set: function fullScreen(str)	{ return CPP_DKWindow_fullScreen(this.address, str) },
    })
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	Object.defineProperty(this, "history", {
        get: function history()		{ return CPP_DKWindow_history(this.address) },
		//set: function history(str){ return CPP_DKWindow_history(this.address, str) },
    })
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	Object.defineProperty(this, "indexedDB", {
        get: function indexedDB()		{ return CPP_DKWindow_indexedDB(this.address) },
		//set: function indexedDB(str)	{ return CPP_DKWindow_indexedDB(this.address, str) },
    })
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	Object.defineProperty(this, "innerHeight", {
        get: function innerHeight()		{ return CPP_DKWindow_innerHeight(this.address) },
		//set: function innerHeight(num){ return CPP_DKWindow_innerHeight(this.address, num) },
    })
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	Object.defineProperty(this, "innerWidth", {
        get: function innerWidth()		{ return CPP_DKWindow_innerWidth(this.address) },
		//set: function innerWidth(num){ return CPP_DKWindow_innerWidth(this.address, num) },
    })
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	Object.defineProperty(this, "isSecureContext", {
        get: function isSecureContext()		{ return CPP_DKWindow_isSecureContext(this.address) },
		//set: function isSecureContext(num){ return CPP_DKWindow_isSecureContext(this.address, num) },
    })
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	Object.defineProperty(this, "launchQueue", {
        get: function launchQueue()		{ return CPP_DKWindow_launchQueue(this.address) },
		//set: function launchQueue(str){ return CPP_DKWindow_launchQueue(this.address, str) },
    })
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	Object.defineProperty(this, "length", {
        get: function length()		{ return CPP_DKWindow_length(this.address) },
		//set: function length(num)	{ return CPP_DKWindow_length(this.address, num) },
    })
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	Object.defineProperty(this, "location", {
        get: function location()	{ return CPP_DKWindow_location(this.address) },
		set: function location(str)	{ return CPP_DKWindow_location(this.address, str) },
    })
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	Object.defineProperty(this, "locationbar", {
        get: function locationbar()		{ return CPP_DKWindow_locationbar(this.address) },
		//set: function locationbar(str){ return CPP_DKWindow_locationbar(this.address, str) },
    })
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	Object.defineProperty(this, "localStorage", {
        get: function localStorage()		{ return CPP_DKWindow_localStorage(this.address) },
		//set: function localStorage(str)	{ return CPP_DKWindow_localStorage(this.address, str) },
    })
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	Object.defineProperty(this, "menubar", {
        get: function menubar()			{ return CPP_DKWindow_menubar(this.address) },
		//set: function menubar(str)	{ return CPP_DKWindow_menubar(this.address, str) },
    })
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	Object.defineProperty(this, "mozInnerScreenX", {
        get: function mozInnerScreenX()		{ return CPP_DKWindow_mozInnerScreenX(this.address) },
		//set: function mozInnerScreenX(num){ return CPP_DKWindow_mozInnerScreenX(this.address, num) },
    })
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	Object.defineProperty(this, "mozInnerScreenY", {
        get: function mozInnerScreenY()		{ return CPP_DKWindow_mozInnerScreenY(this.address) },
		//set: function mozInnerScreenY(num){ return CPP_DKWindow_mozInnerScreenY(this.address, num) },
    })
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	Object.defineProperty(this, "name", {
        get: function name()	{ return CPP_DKWindow_name(this.address) },
		set: function name(str)	{ return CPP_DKWindow_name(this.address, str) },
    })
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	Object.defineProperty(this, "navigation", {
        get: function navigation()		{ return CPP_DKWindow_navigation(this.address) },
		//set: function navigation(str)	{ return CPP_DKWindow_navigation(this.address, str) },
    })
	

	////// Deprecated properties //////
	
	
	////// Instance methods //////
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
	Window.prototype.moveTo = function moveTo(x, y) {
		CPP_DKWindow_moveTo(this.address, x, y)
    }
	
	
	////// Deprecated methods //////
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	return EventTarget.call(this)
};
Window.prototype = EventTarget.prototype;
