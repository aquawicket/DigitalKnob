// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
var Window = function Window(address) {
	//console.log("Window("+address+")")
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKWindowDUK();

	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	Object.defineProperty(this, "window", {
        get: function window()					{ return CPP_DKWindowDUK_window(this.address) },
		//set: function window(data)			{ return CPP_DKWindowDUK_window(this.address, data) },
    })
	
	// [Replaceable] readonly attribute WindowProxy self;
	Object.defineProperty(this, "self", {
        get: function self()					{ return CPP_DKWindowDUK_self(this.address) },
		//set: function self(data)				{ return CPP_DKWindowDUK_self(this.address, data) },
    })
	
	// [LegacyUnforgeable] readonly attribute Document document;
	Object.defineProperty(this, "document", {
        get: function document()				{ return CPP_DKWindowDUK_document(this.address) },
		//set: function document(data)			{ return CPP_DKWindowDUK_document(this.address, data) },
    })
	
	// attribute DOMString name;
	Object.defineProperty(this, "name", {
        get: function name()					{ return CPP_DKWindowDUK_name(this.address) },
		set: function name(data)				{ return CPP_DKWindowDUK_name(this.address, data) },
    })
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	Object.defineProperty(this, "location", {
        get: function location()				{ return CPP_DKWindowDUK_location(this.address) },
		set: function location(data)			{ return CPP_DKWindowDUK_location(this.address, data) },
    })
	
	// readonly attribute History history;
	Object.defineProperty(this, "history", {
        get: function history()					{ return CPP_DKWindowDUK_history(this.address) },
		//set: function history(data)			{ return CPP_DKWindowDUK_history(this.address, data) },
    })
	
	// readonly attribute CustomElementRegistry customElements;
	Object.defineProperty(this, "customElements", {
        get: function customElements()			{ return CPP_DKWindowDUK_customElements(this.address) },
		//set: function customElements(data)	{ return CPP_DKWindowDUK_customElements(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp locationbar;
	Object.defineProperty(this, "locationbar", {
        get: function locationbar()				{ return CPP_DKWindowDUK_locationbar(this.address) },
		//set: function locationbar(data)		{ return CPP_DKWindowDUK_locationbar(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp menubar;
	Object.defineProperty(this, "menubar", {
        get: function menubar()					{ return CPP_DKWindowDUK_menubar(this.address) },
		//set: function menubar(data)			{ return CPP_DKWindowDUK_menubar(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp personalbar;
	Object.defineProperty(this, "personalbar", {
        get: function personalbar()				{ return CPP_DKWindowDUK_personalbar(this.address) },
		//set: function personalbar(data)		{ return CPP_DKWindowDUK_personalbar(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	Object.defineProperty(this, "scrollbars", {
        get: function scrollbars()				{ return CPP_DKWindowDUK_scrollbars(this.address) },
		//set: function scrollbars(data)		{ return CPP_DKWindowDUK_scrollbars(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp statusbar;
	Object.defineProperty(this, "statusbar", {
        get: function statusbar()				{ return CPP_DKWindowDUK_statusbar(this.address) },
		//set: function statusbar(data)			{ return CPP_DKWindowDUK_statusbar(this.address, data) },
    })
	
	// [Replaceable] readonly attribute BarProp toolbar;
	Object.defineProperty(this, "toolbar", {
        get: function toolbar()					{ return CPP_DKWindowDUK_toolbar(this.address) },
		//set: function toolbar(data)			{ return CPP_DKWindowDUK_toolbar(this.address, data) },
    })
	
	// attribute DOMString status;
	Object.defineProperty(this, "status", {
        get: function status()					{ return CPP_DKWindowDUK_status(this.address) },
		set: function status(data)				{ return CPP_DKWindowDUK_status(this.address, data) },
    })
	
	
	// TODO
	/////////////////////////////////////////////////////////////////////////////////////////////////
	Object.defineProperty(this, "clientInformation", {
        get: function clientInformation()		{ return CPP_DKWindowDUK_clientInformation(this.address) },
		//set: function clientInformation(data)	{ return CPP_DKWindowDUK_clientInformation(this.address, data) },
    })
	Object.defineProperty(this, "closed", {
        get: function closed()					{ return CPP_DKWindowDUK_closed(this.address) },
		//set: function closed(data)			{ return CPP_DKWindowDUK_closed(this.address, data) },
    })
	Object.defineProperty(this, "devicePixelRatio", {
        get: function devicePixelRatio()		{ return CPP_DKWindowDUK_devicePixelRatio(this.address) },
		//set: function devicePixelRatio(data)	{ return CPP_DKWindowDUK_devicePixelRatio(this.address, data) },
    })
	Object.defineProperty(this, "frameElement", {
        get: function frameElement()			{ return CPP_DKWindowDUK_frameElement(this.address) },
		//set: function frameElement(data)		{ return CPP_DKWindowDUK_frameElement(this.address, data) },
    })
	Object.defineProperty(this, "frames", {
        get: function frames()					{ return CPP_DKWindowDUK_frames(this.address) },
		//set: function frames(data)			{ return CPP_DKWindowDUK_frames(this.address, data) },
    })
	Object.defineProperty(this, "innerHeight", {
        get: function innerHeight()				{ return CPP_DKWindowDUK_innerHeight(this.address) },
		//set: function innerHeight(data)		{ return CPP_DKWindowDUK_innerHeight(this.address, data) },
    })
	Object.defineProperty(this, "innerWidth", {
        get: function innerWidth()				{ return CPP_DKWindowDUK_innerWidth(this.address) },
		//set: function innerWidth(data)		{ return CPP_DKWindowDUK_innerWidth(this.address, data) },
    })
	Object.defineProperty(this, "launchQueue", {
        get: function launchQueue()				{ return CPP_DKWindowDUK_launchQueue(this.address) },
		//set: function launchQueue(data)		{ return CPP_DKWindowDUK_launchQueue(this.address, data) },
    })
	Object.defineProperty(this, "length", {
        get: function length()					{ return CPP_DKWindowDUK_length(this.address) },
		//set: function length(data)			{ return CPP_DKWindowDUK_length(this.address, data) },
    })
	Object.defineProperty(this, "navigator", {
        get: function navigator()				{ return CPP_DKWindowDUK_navigator(this.address) },
		//set: function navigator(data)			{ return CPP_DKWindowDUK_navigator(this.address, data) },
    })
	Object.defineProperty(this, "opener", {
        get: function opener()					{ return CPP_DKWindowDUK_opener(this.address) },
		set: function opener(data)				{ return CPP_DKWindowDUK_opener(this.address, data) },
    })
	Object.defineProperty(this, "outerHeight", {
        get: function outerHeight()				{ return CPP_DKWindowDUK_outerHeight(this.address) },
		//set: function outerHeight(data)		{ return CPP_DKWindowDUK_outerHeight(this.address, data) },
    })
	Object.defineProperty(this, "outerWidth", {
        get: function outerWidth()				{ return CPP_DKWindowDUK_outerWidth(this.address) },
		//set: function outerWidth(data)		{ return CPP_DKWindowDUK_outerWidth(this.address, data) },
    })
	Object.defineProperty(this, "pageXOffset", {
        get: function pageXOffset()				{ return CPP_DKWindowDUK_pageXOffset(this.address) },
		//set: function pageXOffset(data)		{ return CPP_DKWindowDUK_pageXOffset(this.address, data) },
    })
	Object.defineProperty(this, "pageYOffset", {
        get: function pageYOffset()				{ return CPP_DKWindowDUK_pageYOffset(this.address) },
		//set: function pageYOffset(data)		{ return CPP_DKWindowDUK_pageYOffset(this.address, data) },
    })
	Object.defineProperty(this, "parent", {
        get: function parent()					{ return CPP_DKWindowDUK_parent(this.address) },
		//set: function parent(data)			{ return CPP_DKWindowDUK_parent(this.address, data) },
    })
	Object.defineProperty(this, "screen", {
        get: function screen()					{ return CPP_DKWindowDUK_screen(this.address) },
		//set: function screen(data)			{ return CPP_DKWindowDUK_screen(this.address, data) },
    })
	Object.defineProperty(this, "scrollX", {
        get: function scrollX()					{ return CPP_DKWindowDUK_scrollX(this.address) },
		//set: function scrollX(data)			{ return CPP_DKWindowDUK_scrollX(this.address, data) },
    })
	Object.defineProperty(this, "scrollY", {
        get: function scrollY()					{ return CPP_DKWindowDUK_scrollY(this.address) },
		//set: function scrollY(data)			{ return CPP_DKWindowDUK_scrollY(this.address, data) },
    })
	Object.defineProperty(this, "speechSynthesis", {
        get: function speechSynthesis()			{ return CPP_DKWindowDUK_speechSynthesis(this.address) },
		//set: function speechSynthesis(data)	{ return CPP_DKWindowDUK_speechSynthesis(this.address, data) },
    })
	Object.defineProperty(this, "top", {
        get: function top()						{ return CPP_DKWindowDUK_top(this.address) },
		//set: function top(data)				{ return CPP_DKWindowDUK_top(this.address, data) },
    })
	Object.defineProperty(this, "visualViewport", {
        get: function visualViewport()			{ return CPP_DKWindowDUK_visualViewport(this.address) },
		//set: function visualViewport(data)	{ return CPP_DKWindowDUK_visualViewport(this.address, data) },
    })
	Object.defineProperty(this, "content", {
        get: function content()					{ return CPP_DKWindowDUK_content(this.address) },
		//set: function content(data)			{ return CPP_DKWindowDUK_content(this.address, data) },
    })
	Object.defineProperty(this, "defaultStatus", {
        get: function defaultStatus()			{ return CPP_DKWindowDUK_defaultStatus(this.address) },
		set: function defaultStatus(data)		{ return CPP_DKWindowDUK_defaultStatus(this.address, data) },
    })
	Object.defineProperty(this, "event", {
        get: function event()					{ return CPP_DKWindowDUK_event(this.address) },
		//set: function event(data)				{ return CPP_DKWindowDUK_event(this.address, data) },
    })
	Object.defineProperty(this, "external", {
        get: function external()				{ return CPP_DKWindowDUK_external(this.address) },
		//set: function external(data)			{ return CPP_DKWindowDUK_external(this.address, data) },
    })
	Object.defineProperty(this, "orientation", {
        get: function orientation()				{ return CPP_DKWindowDUK_orientation(this.address) },
		//set: function orientation(data)		{ return CPP_DKWindowDUK_orientation(this.address, data) },
    })
	Object.defineProperty(this, "returnValue", {
        get: function returnValue()				{ return CPP_DKWindowDUK_returnValue(this.address) },
		set: function returnValue(data)			{ return CPP_DKWindowDUK_returnValue(this.address, data) },
    })
	Object.defineProperty(this, "sidebar", {
        get: function sidebar()					{ return CPP_DKWindowDUK_sidebar(this.address) },
		//set: function sidebar(data)			{ return CPP_DKWindowDUK_sidebar(this.address, data) },
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
