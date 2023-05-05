// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window


// [Window()] https://developer.mozilla.org/en-US/docs/Web/API/Window
var Window = function Window(address) {
	//console.log("Window("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKWindowDUK();

	
	////// Instance properties //////
	/*
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/caches
	Object.defineProperty(this, "caches", {
        get: function caches()					{ return CPP_DKWindowDUK_caches(this.address) },
		//set: function caches(data)			{ return CPP_DKWindowDUK_caches(this.address, data) },
    })
	*/
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/clientInformation
	Object.defineProperty(this, "clientInformation", {
        get: function clientInformation()		{ return CPP_DKWindowDUK_clientInformation(this.address) },
		//set: function clientInformation(data)	{ return CPP_DKWindowDUK_clientInformation(this.address, data) },
    })
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	Object.defineProperty(this, "closed", {
        get: function closed()					{ return CPP_DKWindowDUK_closed(this.address) },
		//set: function closed(data)			{ return CPP_DKWindowDUK_closed(this.address, data) },
    })
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	Object.defineProperty(this, "console", {
        get: function console()					{ return CPP_DKWindowDUK_console(this.address) },
		//set: function console(data)			{ return CPP_DKWindowDUK_console(this.address, data) },
    })
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	Object.defineProperty(this, "credentialless", {
        get: function credentialless()			{ return CPP_DKWindowDUK_credentialless(this.address) },
		//set: function credentialless(data)	{ return CPP_DKWindowDUK_credentialless(this.address, data) },
    })
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	Object.defineProperty(this, "crypto", {
        get: function crypto()					{ return CPP_DKWindowDUK_crypto(this.address) },
		//set: function crypto(data)			{ return CPP_DKWindowDUK_crypto(this.address, data) },
    })
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	Object.defineProperty(this, "customElements", {
        get: function customElements()			{ return CPP_DKWindowDUK_customElements(this.address) },
		//set: function customElements(data)	{ return CPP_DKWindowDUK_customElements(this.address, data) },
    })
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	Object.defineProperty(this, "devicePixelRatio", {
        get: function devicePixelRatio()		{ return CPP_DKWindowDUK_devicePixelRatio(this.address) },
		//set: function devicePixelRatio(data)	{ return CPP_DKWindowDUK_devicePixelRatio(this.address, data) },
    })
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	Object.defineProperty(this, "document", {
        get: function document()				{ return CPP_DKWindowDUK_document(this.address) },
		//set: function document(data)			{ return CPP_DKWindowDUK_document(this.address, data) },
    })
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	Object.defineProperty(this, "frameElement", {
        get: function frameElement()			{ return CPP_DKWindowDUK_frameElement(this.address) },
		//set: function frameElement(data)		{ return CPP_DKWindowDUK_frameElement(this.address, data) },
    })
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	Object.defineProperty(this, "frames", {
        get: function frames()					{ return CPP_DKWindowDUK_frames(this.address) },
		//set: function frames(data)			{ return CPP_DKWindowDUK_frames(this.address, data) },
    })
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	Object.defineProperty(this, "fullScreen", {
        get: function fullScreen()				{ return CPP_DKWindowDUK_fullScreen(this.address) },
		set: function fullScreen(data)			{ return CPP_DKWindowDUK_fullScreen(this.address, data) },
    })
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	Object.defineProperty(this, "history", {
        get: function history()					{ return CPP_DKWindowDUK_history(this.address) },
		//set: function history(data)			{ return CPP_DKWindowDUK_history(this.address, data) },
    })
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	Object.defineProperty(this, "indexedDB", {
        get: function indexedDB()				{ return CPP_DKWindowDUK_indexedDB(this.address) },
		//set: function indexedDB(data)			{ return CPP_DKWindowDUK_indexedDB(this.address, data) },
    })
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	Object.defineProperty(this, "innerHeight", {
        get: function innerHeight()				{ return CPP_DKWindowDUK_innerHeight(this.address) },
		//set: function innerHeight(data)		{ return CPP_DKWindowDUK_innerHeight(this.address, data) },
    })
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	Object.defineProperty(this, "innerWidth", {
        get: function innerWidth()				{ return CPP_DKWindowDUK_innerWidth(this.address) },
		//set: function innerWidth(data)		{ return CPP_DKWindowDUK_innerWidth(this.address, data) },
    })
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	Object.defineProperty(this, "isSecureContext", {
        get: function isSecureContext()			{ return CPP_DKWindowDUK_isSecureContext(this.address) },
		//set: function isSecureContext(data)	{ return CPP_DKWindowDUK_isSecureContext(this.address, data) },
    })
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	Object.defineProperty(this, "launchQueue", {
        get: function launchQueue()				{ return CPP_DKWindowDUK_launchQueue(this.address) },
		//set: function launchQueue(data)		{ return CPP_DKWindowDUK_launchQueue(this.address, data) },
    })
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	Object.defineProperty(this, "length", {
        get: function length()					{ return CPP_DKWindowDUK_length(this.address) },
		//set: function length(data)			{ return CPP_DKWindowDUK_length(this.address, data) },
    })
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	Object.defineProperty(this, "location", {
        get: function location()				{ return CPP_DKWindowDUK_location(this.address) },
		set: function location(data)			{ return CPP_DKWindowDUK_location(this.address, data) },
    })
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	Object.defineProperty(this, "locationbar", {
        get: function locationbar()				{ return CPP_DKWindowDUK_locationbar(this.address) },
		//set: function locationbar(data)		{ return CPP_DKWindowDUK_locationbar(this.address, data) },
    })
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	Object.defineProperty(this, "localStorage", {
        get: function localStorage()			{ return CPP_DKWindowDUK_localStorage(this.address) },
		//set: function localStorage(data)		{ return CPP_DKWindowDUK_localStorage(this.address, data) },
    })
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	Object.defineProperty(this, "menubar", {
        get: function menubar()					{ return CPP_DKWindowDUK_menubar(this.address) },
		//set: function menubar(data)			{ return CPP_DKWindowDUK_menubar(this.address, data) },
    })
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	Object.defineProperty(this, "mozInnerScreenX", {
        get: function mozInnerScreenX()			{ return CPP_DKWindowDUK_mozInnerScreenX(this.address) },
		//set: function mozInnerScreenX(data)	{ return CPP_DKWindowDUK_mozInnerScreenX(this.address, data) },
    })
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	Object.defineProperty(this, "mozInnerScreenY", {
        get: function mozInnerScreenY()			{ return CPP_DKWindowDUK_mozInnerScreenY(this.address) },
		//set: function mozInnerScreenY(data)	{ return CPP_DKWindowDUK_mozInnerScreenY(this.address, data) },
    })
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	Object.defineProperty(this, "name", {
        get: function name()					{ return CPP_DKWindowDUK_name(this.address) },
		set: function name(data)				{ return CPP_DKWindowDUK_name(this.address, data) },
    })
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	Object.defineProperty(this, "navigation", {
        get: function navigation()				{ return CPP_DKWindowDUK_navigation(this.address) },
		//set: function navigation(data)		{ return CPP_DKWindowDUK_navigation(this.address, data) },
    })
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	Object.defineProperty(this, "navigator", {
        get: function navigator()				{ return CPP_DKWindowDUK_navigator(this.address) },
		//set: function navigator(data)			{ return CPP_DKWindowDUK_navigator(this.address, data) },
    })
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	Object.defineProperty(this, "opener", {
        get: function opener()					{ return CPP_DKWindowDUK_opener(this.address) },
		set: function opener(data)				{ return CPP_DKWindowDUK_opener(this.address, data) },
    })
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	Object.defineProperty(this, "origin", {
        get: function origin()					{ return CPP_DKWindowDUK_origin(this.address) },
		//set: function origin(data)			{ return CPP_DKWindowDUK_origin(this.address, data) },
    })
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	Object.defineProperty(this, "outerHeight", {
        get: function outerHeight()				{ return CPP_DKWindowDUK_outerHeight(this.address) },
		//set: function outerHeight(data)		{ return CPP_DKWindowDUK_outerHeight(this.address, data) },
    })
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	Object.defineProperty(this, "outerWidth", {
        get: function outerWidth()				{ return CPP_DKWindowDUK_outerWidth(this.address) },
		//set: function outerWidth(data)		{ return CPP_DKWindowDUK_outerWidth(this.address, data) },
    })
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	Object.defineProperty(this, "pageXOffset", {
        get: function pageXOffset()				{ return CPP_DKWindowDUK_pageXOffset(this.address) },
		//set: function pageXOffset(data)		{ return CPP_DKWindowDUK_pageXOffset(this.address, data) },
    })
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	Object.defineProperty(this, "pageYOffset", {
        get: function pageYOffset()				{ return CPP_DKWindowDUK_pageYOffset(this.address) },
		//set: function pageYOffset(data)		{ return CPP_DKWindowDUK_pageYOffset(this.address, data) },
    })
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	Object.defineProperty(this, "parent", {
        get: function parent()					{ return CPP_DKWindowDUK_parent(this.address) },
		//set: function parent(data)			{ return CPP_DKWindowDUK_parent(this.address, data) },
    })
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	Object.defineProperty(this, "performance", {
        get: function performance()				{ return CPP_DKWindowDUK_performance(this.address) },
		//set: function performance(data)		{ return CPP_DKWindowDUK_performance(this.address, data) },
    })
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	Object.defineProperty(this, "personalbar", {
        get: function personalbar()				{ return CPP_DKWindowDUK_personalbar(this.address) },
		//set: function personalbar(data)		{ return CPP_DKWindowDUK_personalbar(this.address, data) },
    })
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	Object.defineProperty(this, "scheduler", {
        get: function scheduler()				{ return CPP_DKWindowDUK_scheduler(this.address) },
		//set: function scheduler(data)			{ return CPP_DKWindowDUK_scheduler(this.address, data) },
    })
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	Object.defineProperty(this, "screen", {
        get: function screen()					{ return CPP_DKWindowDUK_screen(this.address) },
		//set: function screen(data)			{ return CPP_DKWindowDUK_screen(this.address, data) },
    })
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	Object.defineProperty(this, "screenX", {
        get: function screenX()					{ return CPP_DKWindowDUK_screenX(this.address) },
		//set: function screenX(data)			{ return CPP_DKWindowDUK_screenX(this.address, data) },
    })
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	Object.defineProperty(this, "screenY", {
        get: function screenY()					{ return CPP_DKWindowDUK_screenY(this.address) },
		//set: function screenY(data)			{ return CPP_DKWindowDUK_screenY(this.address, data) },
    })
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	Object.defineProperty(this, "scrollbars", {
        get: function scrollbars()				{ return CPP_DKWindowDUK_scrollbars(this.address) },
		//set: function scrollbars(data)		{ return CPP_DKWindowDUK_scrollbars(this.address, data) },
    })
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	Object.defineProperty(this, "scrollMaxX", {
        get: function scrollMaxX()				{ return CPP_DKWindowDUK_scrollMaxX(this.address) },
		//set: function scrollMaxX(data)		{ return CPP_DKWindowDUK_scrollMaxX(this.address, data) },
    })
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	Object.defineProperty(this, "scrollMaxY", {
        get: function scrollMaxY()				{ return CPP_DKWindowDUK_scrollMaxY(this.address) },
		//set: function scrollMaxY(data)		{ return CPP_DKWindowDUK_scrollMaxY(this.address, data) },
    })
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	Object.defineProperty(this, "scrollX", {
        get: function scrollX()					{ return CPP_DKWindowDUK_scrollX(this.address) },
		//set: function scrollX(data)			{ return CPP_DKWindowDUK_scrollX(this.address, data) },
    })
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	Object.defineProperty(this, "scrollY", {
        get: function scrollY()					{ return CPP_DKWindowDUK_scrollY(this.address) },
		//set: function scrollY(data)			{ return CPP_DKWindowDUK_scrollY(this.address, data) },
    })
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	Object.defineProperty(this, "self", {
        get: function self()					{ return CPP_DKWindowDUK_self(this.address) },
		//set: function self(data)				{ return CPP_DKWindowDUK_self(this.address, data) },
    })
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	Object.defineProperty(this, "sessionStorage", {
        get: function sessionStorage()			{ return CPP_DKWindowDUK_sessionStorage(this.address) },
		set: function sessionStorage(data)		{ return CPP_DKWindowDUK_sessionStorage(this.address, data) },
    })
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	Object.defineProperty(this, "speechSynthesis", {
        get: function speechSynthesis()			{ return CPP_DKWindowDUK_speechSynthesis(this.address) },
		//set: function speechSynthesis(data)	{ return CPP_DKWindowDUK_speechSynthesis(this.address, data) },
    })
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	Object.defineProperty(this, "statusbar", {
        get: function statusbar()				{ return CPP_DKWindowDUK_statusbar(this.address) },
		//set: function statusbar(data)			{ return CPP_DKWindowDUK_statusbar(this.address, data) },
    })
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	Object.defineProperty(this, "toolbar", {
        get: function toolbar()					{ return CPP_DKWindowDUK_toolbar(this.address) },
		//set: function toolbar(data)			{ return CPP_DKWindowDUK_toolbar(this.address, data) },
    })
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	Object.defineProperty(this, "top", {
        get: function top()						{ return CPP_DKWindowDUK_top(this.address) },
		//set: function top(data)				{ return CPP_DKWindowDUK_top(this.address, data) },
    })
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	Object.defineProperty(this, "visualViewport", {
        get: function visualViewport()			{ return CPP_DKWindowDUK_visualViewport(this.address) },
		//set: function visualViewport(data)	{ return CPP_DKWindowDUK_visualViewport(this.address, data) },
    })
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	Object.defineProperty(this, "window", {
        get: function window()					{ return CPP_DKWindowDUK_window(this.address) },
		//set: function window(data)			{ return CPP_DKWindowDUK_window(this.address, data) },
    })
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	/*
	Object.defineProperty(this, "windows", {
        get: function windows()					{ return CPP_DKWindowDUK_windows(this.address) },
		//set: function windows(data)			{ return CPP_DKWindowDUK_windows(this.address, data) },
    })
	*/
	

	////// Deprecated properties //////
	// [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	Object.defineProperty(this, "content", {
        get: function content()					{ return CPP_DKWindowDUK_content(this.address) },
		//set: function content(data)			{ return CPP_DKWindowDUK_content(this.address, data) },
    })
	// [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	Object.defineProperty(this, "defaultStatus", {
        get: function defaultStatus()			{ return CPP_DKWindowDUK_defaultStatus(this.address) },
		set: function defaultStatus(data)		{ return CPP_DKWindowDUK_defaultStatus(this.address, data) },
    })
	// [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	Object.defineProperty(this, "event", {
        get: function event()					{ return CPP_DKWindowDUK_event(this.address) },
		//set: function event(data)				{ return CPP_DKWindowDUK_event(this.address, data) },
    })
	// [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	Object.defineProperty(this, "external", {
        get: function external()				{ return CPP_DKWindowDUK_external(this.address) },
		//set: function external(data)			{ return CPP_DKWindowDUK_external(this.address, data) },
    })
	// [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	Object.defineProperty(this, "orientation", {
        get: function orientation()				{ return CPP_DKWindowDUK_orientation(this.address) },
		//set: function orientation(data)		{ return CPP_DKWindowDUK_orientation(this.address, data) },
    })
	// [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()				{ return CPP_DKWindowDUK_returnValue(this.address) },
		set: function returnValue(data)			{ return CPP_DKWindowDUK_returnValue(this.address, data) },
    })
	// [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	Object.defineProperty(this, "sidebar", {
        get: function sidebar()					{ return CPP_DKWindowDUK_sidebar(this.address) },
		//set: function sidebar(data)			{ return CPP_DKWindowDUK_sidebar(this.address, data) },
    })
	// [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	Object.defineProperty(this, "status", {
        get: function status()					{ return CPP_DKWindowDUK_status(this.address) },
		set: function status(data)				{ return CPP_DKWindowDUK_status(this.address, data) },
    })
	
	
	////// Instance methods //////
	// [Window.atob()] https://developer.mozilla.org/en-US/docs/Web/API/Window/atob
	Window.prototype.atob = function atob(encodedData) {
		return CPP_DKWindowDUK_atob(this.address, encodedData)
    }
	// [Window.alert()] https://developer.mozilla.org/en-US/docs/Web/API/Window/alert
	Window.prototype.alert = function alert(message) {
		CPP_DKWindowDUK_alert(this.address, message)
    }
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur
	Window.prototype.blur = function blur() {
		CPP_DKWindowDUK_blur(this.address)
    }
	// [Window.btoa()] https://developer.mozilla.org/en-US/docs/Web/API/Window/btoa
	Window.prototype.btob = function btob(stringToEncode) {
		return CPP_DKWindowDUK_btob(this.address, stringToEncode)
    }
	// [Window.cancelAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
	Window.prototype.cancelAnimationFrame = function cancelAnimationFrame(requestID) {
		CPP_DKWindowDUK_cancelAnimationFrame(this.address, requestID)
    }
	// [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
	Window.prototype.cancelIdleCallback = function cancelIdleCallback(handle) {
		CPP_DKWindowDUK_cancelIdleCallback(this.address, handle)
    }
	// [Window.clearImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearImmediate
	Window.prototype.clearImmediate = function clearImmediate(immediateID) {
		CPP_DKWindowDUK_clearImmediate(this.address, immediateID)
    }
	// [Window.clearInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearInterval
	Window.prototype.clearInterval = function clearInterval(intervalID) {
		CPP_DKWindowDUK_clearInterval(this.address, intervalID)
    }
	// [Window.clearTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearTimeout
	Window.prototype.clearTimeout = function clearTimeout(timeoutID) {
		CPP_DKWindowDUK_clearTimeout(this.address, timeoutID)
    }
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/Window/close
	Window.prototype.close = function close() {
		CPP_DKWindowDUK_close(this.address)
    }
	// [Window.confirm()] https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
	Window.prototype.confirm = function confirm(message) {
		return CPP_DKWindowDUK_confirm(this.address, message)
    }
	// [Window.createImageBitmap()] https://developer.mozilla.org/en-US/docs/Web/API/createImageBitmap
	Window.prototype.createImageBitmap = function createImageBitmap() {
		// TODO
    }
	// [Window.dump()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/dump
	Window.prototype.dump = function dump(message) {
		CPP_DKWindowDUK_dump(this.address, message)
    }
	// [Window.fetch()] https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
	Window.prototype.fetch = function fetch() {
		// TODO
    }
	// [Window.find()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/find
	Window.prototype.find = function find() {
		// TODO
    }
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus
	Window.prototype.focus = function focus() {
		CPP_DKWindowDUK_focus(this.address)
    }
	// [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
	Window.prototype.getComputedStyle = function getComputedStyle() {
		// TODO
    }
	// [Window.getDefaultComputedStyle()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/getDefaultComputedStyle
	Window.prototype.getDefaultComputedStyle = function getDefaultComputedStyle() {
		// TODO
    }
	// [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
	Window.prototype.getSelection = function getSelection() {
		// TODO
    }
	// [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
	Window.prototype.matchMedia = function matchMedia() {
		// TODO
    }
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
	Window.prototype.moveBy = function moveBy(deltaX, deltaY) {
		CPP_DKWindowDUK_moveBy(this.address, deltaX, deltaY)
    }
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
	Window.prototype.moveTo = function moveTo(x, y) {
		CPP_DKWindowDUK_moveTo(this.address, x, y)
    }
	// [Window.open()] https://developer.mozilla.org/en-US/docs/Web/API/Window/open
	Window.prototype.open = function open() {
		// TODO
    }
	// [Window.postMessage()] https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage
	Window.prototype.postMessage = function postMessage() {
		// TODO
    }
	// [Window.print()] https://developer.mozilla.org/en-US/docs/Web/API/Window/print
	Window.prototype.print = function print() {
		CPP_DKWindowDUK_print(this.address)
    }
	// [Window.prompt()] https://developer.mozilla.org/en-US/docs/Web/API/Window/prompt
	Window.prototype.prompt = function prompt() {
		// TODO
    }
	// [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
	Window.prototype.queryLocalFonts = function queryLocalFonts() {
		// TODO
    }
	// [Window.reportError()] https://developer.mozilla.org/en-US/docs/Web/API/reportError
	Window.prototype.reportError = function reportError() {
		// TODO
    }
	// [Window.requestAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
	Window.prototype.requestAnimationFrame = function requestAnimationFrame() {
		// TODO
    }
	// [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
	Window.prototype.resizeBy = function resizeBy(xDelta, yDelta) {
		CPP_DKWindowDUK_resizeBy(this.address, xDelta, yDelta)
    }
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
	Window.prototype.resizeTo = function resizeTo(width, height) {
		CPP_DKWindowDUK_resizeTo(this.address, width, height)
    }
	// [Window.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll
	// [Window.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy
	// [Window.scrollByLines()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByLines
	// [Window.scrollByPages()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByPages
	// [Window.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo
	// [Window.setImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setImmediate
	// [Window.setInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setInterval
	// [Window.setResizable()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/setResizable
	// [Window.setTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setTimeout
	// [Window.sizeToContent()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/sizeToContent
	// [Window.showOpenFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker
	// [Window.showSaveFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker
	// [Window.showDirectoryPicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showDirectoryPicker
	// [Window.stop()] https://developer.mozilla.org/en-US/docs/Web/API/Window/stop
	// [Window.updateCommands()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/updateCommands
	
	
	////// Deprecated methods //////
	// [Window.back()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/back
	// [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
	// [Window.forward()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/forward
	// [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
	// [Window.showModalDialog()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/showModalDialog
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	return EventTarget.call(this, this.address)
}
Window.prototype = EventTarget.prototype
