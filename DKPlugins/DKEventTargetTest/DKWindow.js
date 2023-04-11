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
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/caches
	Object.defineProperty(this, "caches", {
        get: function caches()		{ return CPP_DKWindow_caches(this.address) },
		//set: function caches(str)	{ return CPP_DKWindow_caches(this.address, str) },
    })
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/clientInformation
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
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	Object.defineProperty(this, "navigator", {
        get: function navigator()		{ return CPP_DKWindow_navigator(this.address) },
		//set: function navigator(str)	{ return CPP_DKWindow_navigator(this.address, str) },
    })
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	Object.defineProperty(this, "opener", {
        get: function opener()		{ return CPP_DKWindow_opener(this.address) },
		set: function opener(str)	{ return CPP_DKWindow_opener(this.address, str) },
    })
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	Object.defineProperty(this, "origin", {
        get: function origin()		{ return CPP_DKWindow_origin(this.address) },
		set: function origin(str)	{ return CPP_DKWindow_origin(this.address, str) },
    })
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	Object.defineProperty(this, "outerHeight", {
        get: function outerHeight()		{ return CPP_DKWindow_outerHeight(this.address) },
		//set: function outerHeight(num){ return CPP_DKWindow_outerHeight(this.address, num) },
    })
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	Object.defineProperty(this, "outerWidth", {
        get: function outerWidth()		{ return CPP_DKWindow_outerWidth(this.address) },
		//set: function outerWidth(num){ return CPP_DKWindow_outerWidth(this.address, num) },
    })
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	Object.defineProperty(this, "pageXOffset", {
        get: function pageXOffset()		{ return CPP_DKWindow_pageXOffset(this.address) },
		//set: function pageXOffset(num){ return CPP_DKWindow_pageXOffset(this.address, num) },
    })
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	Object.defineProperty(this, "pageYOffset", {
        get: function pageYOffset()		{ return CPP_DKWindow_pageYOffset(this.address) },
		//set: function pageYOffset(num){ return CPP_DKWindow_pageYOffset(this.address, num) },
    })
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	Object.defineProperty(this, "parent", {
        get: function parent()		{ return CPP_DKWindow_parent(this.address) },
		//set: function parent(str)	{ return CPP_DKWindow_parent(this.address, str) },
    })
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	Object.defineProperty(this, "performance", {
        get: function performance()		{ return CPP_DKWindow_performance(this.address) },
		//set: function performance(str){ return CPP_DKWindow_performance(this.address, str) },
    })
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	Object.defineProperty(this, "personalbar", {
        get: function personalbar()		{ return CPP_DKWindow_personalbar(this.address) },
		//set: function personalbar(str){ return CPP_DKWindow_personalbar(this.address, str) },
    })
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	Object.defineProperty(this, "scheduler", {
        get: function scheduler()		{ return CPP_DKWindow_scheduler(this.address) },
		//set: function scheduler(str)	{ return CPP_DKWindow_scheduler(this.address, str) },
    })
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	Object.defineProperty(this, "screen", {
        get: function screen()		{ return CPP_DKWindow_screen(this.address) },
		//set: function screen(str)	{ return CPP_DKWindow_screen(this.address, str) },
    })
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	Object.defineProperty(this, "screenX", {
        get: function screenX()		{ return CPP_DKWindow_screenX(this.address) },
		//set: function screenX(num){ return CPP_DKWindow_screenX(this.address, num) },
    })
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	Object.defineProperty(this, "screenY", {
        get: function screenY()		{ return CPP_DKWindow_screenY(this.address) },
		//set: function screenY(num){ return CPP_DKWindow_screenY(this.address, num) },
    })
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	Object.defineProperty(this, "scrollbars", {
        get: function scrollbars()		{ return CPP_DKWindow_scrollbars(this.address) },
		//set: function scrollbars(str)	{ return CPP_DKWindow_scrollbars(this.address, str) },
    })
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	Object.defineProperty(this, "scrollMaxX", {
        get: function scrollMaxX()		{ return CPP_DKWindow_scrollMaxX(this.address) },
		//set: function scrollMaxX(num)	{ return CPP_DKWindow_scrollMaxX(this.address, num) },
    })
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	Object.defineProperty(this, "scrollMaxY", {
        get: function scrollMaxY()		{ return CPP_DKWindow_scrollMaxY(this.address) },
		//set: function scrollMaxY(num)	{ return CPP_DKWindow_scrollMaxY(this.address, num) },
    })
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	Object.defineProperty(this, "scrollX", {
        get: function scrollX()		{ return CPP_DKWindow_scrollX(this.address) },
		//set: function scrollX(num){ return CPP_DKWindow_scrollX(this.address, num) },
    })
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	Object.defineProperty(this, "scrollY", {
        get: function scrollY()		{ return CPP_DKWindow_scrollY(this.address) },
		//set: function scrollY(num){ return CPP_DKWindow_scrollY(this.address, num) },
    })
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	Object.defineProperty(this, "self", {
        get: function self()		{ return CPP_DKWindow_self(this.address) },
		//set: function self(str)	{ return CPP_DKWindow_self(this.address, str) },
    })
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	Object.defineProperty(this, "sessionStorage", {
        get: function sessionStorage()		{ return CPP_DKWindow_sessionStorage(this.address) },
		set: function sessionStorage(str)	{ return CPP_DKWindow_sessionStorage(this.address, str) },
    })
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	Object.defineProperty(this, "speechSynthesis", {
        get: function speechSynthesis()		{ return CPP_DKWindow_speechSynthesis(this.address) },
		//set: function speechSynthesis(str){ return CPP_DKWindow_speechSynthesis(this.address, str) },
    })
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	Object.defineProperty(this, "statusbar", {
        get: function statusbar()		{ return CPP_DKWindow_statusbar(this.address) },
		//set: function statusbar(str)	{ return CPP_DKWindow_statusbar(this.address, str) },
    })
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	Object.defineProperty(this, "toolbar", {
        get: function toolbar()		{ return CPP_DKWindow_toolbar(this.address) },
		//set: function toolbar(str){ return CPP_DKWindow_toolbar(this.address, str) },
    })
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	Object.defineProperty(this, "top", {
        get: function top()		{ return CPP_DKWindow_top(this.address) },
		//set: function top(str){ return CPP_DKWindow_top(this.address, str) },
    })
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	Object.defineProperty(this, "visualViewport", {
        get: function visualViewport()		{ return CPP_DKWindow_visualViewport(this.address) },
		//set: function visualViewport(str){ return CPP_DKWindow_visualViewport(this.address, str) },
    })
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	Object.defineProperty(this, "window", {
        get: function window()		{ return CPP_DKWindow_window(this.address) },
		//set: function window(str){ return CPP_DKWindow_window(this.address, str) },
    })
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	/*
	Object.defineProperty(this, "windows", {
        get: function windows()		{ return CPP_DKWindow_windows(this.address) },
		//set: function windows(str){ return CPP_DKWindow_windows(this.address, str) },
    })
	*/
	

	////// Deprecated properties //////
	// [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	Object.defineProperty(this, "content", {
        get: function content()		{ return CPP_DKWindow_content(this.address) },
		//set: function content(str){ return CPP_DKWindow_content(this.address, str) },
    })
	// [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	Object.defineProperty(this, "defaultStatus", {
        get: function defaultStatus()		{ return CPP_DKWindow_defaultStatus(this.address) },
		set: function defaultStatus(str)	{ return CPP_DKWindow_defaultStatus(this.address, str) },
    })
	// [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	Object.defineProperty(this, "event", {
        get: function event()		{ return CPP_DKWindow_event(this.address) },
		//set: function event(str)	{ return CPP_DKWindow_event(this.address, str) },
    })
	// [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	Object.defineProperty(this, "external", {
        get: function external()		{ return CPP_DKWindow_external(this.address) },
		//set: function external(str)	{ return CPP_DKWindow_external(this.address, str) },
    })
	// [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	Object.defineProperty(this, "orientation", {
        get: function orientation()		{ return CPP_DKWindow_orientation(this.address) },
		//set: function orientation(num){ return CPP_DKWindow_orientation(this.address, num) },
    })
	// [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()		{ return CPP_DKWindow_returnValue(this.address) },
		set: function returnValue(str){ return CPP_DKWindow_returnValue(this.address, str) },
    })
	// [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	Object.defineProperty(this, "sidebar", {
        get: function sidebar()		{ return CPP_DKWindow_sidebar(this.address) },
		//set: function sidebar(str){ return CPP_DKWindow_sidebar(this.address, str) },
    })
	// [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	Object.defineProperty(this, "status", {
        get: function status()		{ return CPP_DKWindow_status(this.address) },
		set: function status(str)	{ return CPP_DKWindow_status(this.address, str) },
    })
	
	
	////// Instance methods //////
	// [Window.atob()] https://developer.mozilla.org/en-US/docs/Web/API/Window/atob
	Window.prototype.atob = function atob(encodedData) {
		return CPP_DKWindow_atob(this.address, encodedData)
    }
	// [Window.alert()] https://developer.mozilla.org/en-US/docs/Web/API/Window/alert
	Window.prototype.alert = function alert(message) {
		CPP_DKWindow_alert(this.address, message)
    }
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur
	Window.prototype.blur = function blur() {
		CPP_DKWindow_blur(this.address)
    }
	// [Window.btoa()] https://developer.mozilla.org/en-US/docs/Web/API/Window/btoa
	Window.prototype.btob = function btob(stringToEncode) {
		return CPP_DKWindow_btob(this.address, stringToEncode)
    }
	// [Window.cancelAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
	Window.prototype.cancelAnimationFrame = function cancelAnimationFrame(requestID) {
		CPP_DKWindow_cancelAnimationFrame(this.address, requestID)
    }
	// [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
	Window.prototype.cancelIdleCallback = function cancelIdleCallback(handle) {
		CPP_DKWindow_cancelIdleCallback(this.address, handle)
    }
	// [Window.clearImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearImmediate
	Window.prototype.clearImmediate = function clearImmediate(immediateID) {
		CPP_DKWindow_clearImmediate(this.address, immediateID)
    }
	// [Window.clearInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearInterval
	Window.prototype.clearInterval = function clearInterval(intervalID) {
		CPP_DKWindow_clearInterval(this.address, intervalID)
    }
	// [Window.clearTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearTimeout
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/Window/close
	// [Window.confirm()] https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
	// [Window.createImageBitmap()] https://developer.mozilla.org/en-US/docs/Web/API/Window/createImageBitmap
	// [Window.dump()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/dump
	// [Window.fetch()] https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
	// [Window.find()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/find
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus
	// [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
	// [Window.getDefaultComputedStyle()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/getDefaultComputedStyle
	// [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
	// [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
	Window.prototype.moveTo = function moveTo(x, y) {
		CPP_DKWindow_moveTo(this.address, x, y)
    }
	// [Window.open()] https://developer.mozilla.org/en-US/docs/Web/API/Window/open
	// [Window.postMessage()] https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage
	// [Window.print()] https://developer.mozilla.org/en-US/docs/Web/API/Window/print
	// [Window.prompt()] https://developer.mozilla.org/en-US/docs/Web/API/Window/prompt
	// [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
	// [Window.reportError()] https://developer.mozilla.org/en-US/docs/Web/API/Window/reportError
	// [Window.requestAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
	// [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
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
	
	
	return EventTarget.call(this)
};
Window.prototype = EventTarget.prototype;
