#pragma once
#ifndef DKWindow_H
#define DKWindow_H

#include "DKEventTarget/DKEventTarget.h"

//#define GET false
//#define SET true

// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
class DKWindow : public DKEventTarget
{
public:
	DKWindow() : DKEventTarget() {
		DKDEBUGFUNC();
		eventTargetClass = "Window";
		eventTargetAddress = pointerToAddress(this);
		
		////// Instance properties //////
		//caches = "";
		//clientInformation = "";
		//closed = false;
		//console = "";
		//credentialless = false;
		//crypto = "";
		//customElements = "";
		//document = "";
		//frameElement = "";
		//frames = "";
		//fullScreen = false;
		//history = "";
		//indexedDB = "";
		//innerHeight = 0;
		//innerWidth = 0;
		//isSecureContext = false;
		//launchQueue = "";
		//length = 0;
		//location = "";
		//locationbar = "";
		//localStorage = "";
		//mozInnerScreenX = 0.0;
		//mozInnerScreenY = 0.0;
		//name = "";
		//navigation = "";
		//navigator = "";
		//opener = "";
		//origin = "";
		//outerHeight = 0;
		//outerWidth = 0;
		//pageXOffset = 0;
		//pageYOffset = 0;
		//parent = "";
		//performance = "";
		//personalbar = "";
		//scheduler = "";
		//screen = "";
		//screenX = 0;
		//screenY = 0;
		//scrollbars = "";
		//scrollMaxX = 0;
		//scrollMaxY = 0;
		//scrollX = 0;
		//scrollY = 0;
		//self = "";
		//sessionStorage = "";
		//speechSynthesis = "";
		//statusbar = "";
		//toolbar = "";
		//top = "";
		//visualViewport = "";
		//window = "";
		//windows = "";
		
		
		////// Deprecated properties //////
		//content = "";
		//defaultStatus = "";
		//event = "";
		//external = "";
		//orientation = 0;
		//returnValue = "";
		//sidebar = "";
		//status = "";
	}
	
	
	////// Instance properties //////
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/caches
	virtual bool caches(DKString&, bool) { return false; }
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	virtual bool clientInformation(DKString&, bool) { return false; }
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	virtual bool closed(bool&, bool) { return false; }
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	virtual bool console(DKString&, bool) { return false; }
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	virtual bool credentialless(bool&, bool) { return false; }
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	virtual bool crypto(DKString&, bool) { return false; }
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	virtual bool customElements(DKString&, bool) { return false; }
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	virtual bool devicePixelRatio(double&, bool) { return false; }
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	virtual bool document(DKString&, bool) { return false; }
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	virtual bool frameElement(DKString&, bool) { return false; }
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	virtual bool frames(DKString&, bool) { return false; }
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	virtual bool fullScreen(bool&, bool) { return false; }
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	virtual bool history(DKString&, bool) { return false; }
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	virtual bool indexedDB(DKString&, bool) { return false; }
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	virtual bool innerHeight(unsigned int&, bool) { return false; }
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	virtual bool innerWidth(unsigned int&, bool) { return false; }
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	virtual bool isSecureContext(bool&, bool) { return false; }
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	virtual bool launchQueue(DKString&, bool) { return false; }
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	virtual bool length(unsigned int&, bool) { return false; }
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	virtual bool location(DKString&, bool) { return false; }
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	virtual bool locationbar(DKString&, bool) { return false; }
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	virtual bool localStorage(DKString&, bool) { return false; }
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	virtual bool menubar(DKString&, bool) { return false; }
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	virtual bool mozInnerScreenX(double&, bool) { return false; }
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	virtual bool mozInnerScreenY(double&, bool) { return false; }
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	virtual bool name(DKString&, bool) { return false; }
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	virtual bool navigation(DKString&, bool) { return false; }
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	virtual bool navigator(DKString&, bool) { return false; }
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	virtual bool opener(DKString&, bool) { return false; }
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	virtual bool origin(DKString&, bool) { return false; }
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	virtual bool outerHeight(unsigned int&, bool) { return false; }
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	virtual bool outerWidth(unsigned int&, bool) { return false; }
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	virtual bool pageXOffset(unsigned int&, bool) { return false; }
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	virtual bool pageYOffset(unsigned int&, bool) { return false; }
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	virtual bool parent(DKString&, bool) { return false; }
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	virtual bool performance(DKString&, bool) { return false; }
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	virtual bool personalbar(DKString&, bool) { return false; }
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	virtual bool scheduler(DKString&, bool) { return false; }
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	virtual bool screen(DKString&, bool) { return false; }
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	virtual bool screenX(int&, bool) { return false; }
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	virtual bool screenY(int&, bool) { return false; }
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	virtual bool scrollbars(DKString&, bool) { return false; }
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	virtual bool scrollMaxX(unsigned int&, bool) { return false; }
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	virtual bool scrollMaxY(unsigned int&, bool) { return false; }
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	virtual bool scrollX(unsigned int&, bool) { return false; }
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	virtual bool scrollY(unsigned int&, bool) { return false; }
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	virtual bool self(DKString&, bool) { return false; }
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	virtual bool sessionStorage(DKString&, bool) { return false; }
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	virtual bool speechSynthesis(DKString&, bool) { return false; }
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	virtual bool statusbar(DKString&, bool) { return false; }
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	virtual bool toolbar(DKString&, bool) { return false; }
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	virtual bool top(DKString&, bool) { return false; }
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	virtual bool visualViewport(DKString&, bool) { return false; }
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	virtual bool window(DKString&, bool) { return false; }
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool windows(DKString&, bool) { return false; }

	
	////// Deprecated properties //////
	// [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool content(DKString&, bool) { return false; }
	// [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	virtual bool defaultStatus(DKString&, bool) { return false; }
	// [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	virtual bool event(DKString&, bool) { return false; }
	// [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	virtual bool external(DKString&, bool) { return false; }
	// [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	virtual bool orientation(int&, bool) { return false; }
	// [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool returnValue(DKString&, bool) { return false; }
	// [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	virtual bool sidebar(DKString&, bool) { return false; }
	// [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	virtual bool status(DKString&, bool) { return false; }
	
	
	////// Instance methods //////
	// [Window.atob()] https://developer.mozilla.org/en-US/docs/Web/API/Window/atob
	virtual bool atob(DKString& encodedData) {
		DKDEBUGFUNC(encodedData);
		return DKTODO();
	}
	// [Window.alert()] https://developer.mozilla.org/en-US/docs/Web/API/Window/alert
	virtual bool alert(DKString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur
	virtual bool blur() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.btoa()] https://developer.mozilla.org/en-US/docs/Web/API/Window/btoa
	virtual bool btoa(DKString& stringToEncode) {
		DKDEBUGFUNC(stringToEncode);
		return DKTODO();
	}
	// [Window.cancelAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
	virtual bool cancelAnimationFrame(DKString& requestID) {
		DKDEBUGFUNC(requestID);
		return DKTODO();
	}
	// [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
	virtual bool cancelIdleCallback(DKString& handle) {
		DKDEBUGFUNC(handle);
		return DKTODO();
	}
	// [Window.clearImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearImmediate
	virtual bool clearImmediate(DKString& immediateID) {
		DKDEBUGFUNC(immediateID);
		return DKTODO();
	}
	// [Window.clearInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearInterval
	virtual bool clearInterval(DKString& intervalID) {
		DKDEBUGFUNC(intervalID);
		return DKTODO();
	}
	// [Window.clearTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearTimeout
	virtual bool clearTimeout(DKString& timeoutID) {
		DKDEBUGFUNC(timeoutID);
		return DKTODO();
	}
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/Window/close
	virtual bool close() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.confirm()] https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
	virtual bool confirm(DKString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	// [Window.createImageBitmap()] https://developer.mozilla.org/en-US/docs/Web/API/createImageBitmap
	virtual bool createImageBitmap() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.dump()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/dump
	virtual bool dump(DKString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	// [Window.fetch()] https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
	virtual bool fetch() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.find()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/find
	virtual bool find() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus
	virtual bool focus() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
	virtual bool getComputedStyle() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.getDefaultComputedStyle()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/getDefaultComputedStyle
	virtual bool getDefaultComputedStyle() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
	virtual bool getSelection() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
	virtual bool matchMedia(DKString& mediaQueryString) {
		DKDEBUGFUNC(mediaQueryString);
		return DKTODO();
	}
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
	virtual bool moveBy(int& deltaX, int& deltaY) {
		DKDEBUGFUNC(deltaX, deltaY);
		return DKTODO();
	}
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
	virtual bool moveTo(int& x, int& y) {
		DKDEBUGFUNC(x, y);
		return DKTODO();
	}
	// [Window.open()] https://developer.mozilla.org/en-US/docs/Web/API/Window/open
	virtual bool open() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.postMessage()] https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage
	virtual bool postMessage() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.print()] https://developer.mozilla.org/en-US/docs/Web/API/Window/print
	virtual bool print() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.prompt()] https://developer.mozilla.org/en-US/docs/Web/API/Window/prompt
	virtual bool prompt() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
	virtual bool queryLocalFonts() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.reportError()] https://developer.mozilla.org/en-US/docs/Web/API/reportError
	virtual bool reportError() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.requestAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
	virtual bool requestAnimationFrame() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
	virtual bool requestIdleCallback() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
	virtual bool resizeBy(int& xDelta, int& yDelta) {
		DKDEBUGFUNC(xDelta, yDelta);
		return DKTODO();
	}
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
	virtual bool resizeTo(int& width, int& height) {
		DKDEBUGFUNC(width, height);
		return DKTODO();
	}
	// [Window.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll
	virtual bool scroll() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy
	virtual bool scrollBy() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.scrollByLines()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByLines
	virtual bool scrollByLines() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.scrollByPages()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByPages
	virtual bool scrollByPages() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo
	virtual bool scrollTo() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.setImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setImmediate
	virtual bool setImmediate() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.setInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setInterval
	virtual bool setInterval() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.setResizable()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool setResizable() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.setTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setTimeout
	virtual bool setTimeout() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.sizeToContent()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/sizeToContent
	virtual bool sizeToContent() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.showOpenFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker
	virtual bool showOpenFilePicker() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.showSaveFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker
	virtual bool showSaveFilePicker() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.showDirectoryPicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showDirectoryPicker
	virtual bool showDirectoryPicker() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.stop()] https://developer.mozilla.org/en-US/docs/Web/API/Window/stop
	virtual bool stop() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.updateCommands()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/updateCommands
	virtual bool updateCommands(DKString& sCommandName) {
		DKDEBUGFUNC(sCommandName);
		return DKTODO();
	}
	
	
	////// Deprecated methods //////
	// [Window.back()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/back
	virtual bool back() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
	virtual bool captureEvents() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.forward()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/forward
	virtual bool forward() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	// [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
	virtual bool releaseEvents(DKString& eventType) {
		DKDEBUGFUNC(eventType);
		return DKTODO();
	}
	// [Window.showModalDialog()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/showModalDialog
	virtual bool showModalDialog() {
		DKDEBUGFUNC();
		return DKTODO();
	}


	////// Events //////
	// [error] https://developer.mozilla.org/en-US/docs/Web/API/Window/error_event
	// [languagechange] https://developer.mozilla.org/en-US/docs/Web/API/Window/languagechange_event
	// [devicemotion] https://developer.mozilla.org/en-US/docs/Web/API/Window/devicemotion_event
	// [deviceorientation] https://developer.mozilla.org/en-US/docs/Web/API/Window/deviceorientation_event
	// [resize] https://developer.mozilla.org/en-US/docs/Web/API/Window/resize_event
	// [storage] https://developer.mozilla.org/en-US/docs/Web/API/Window/storage_event
	
	
	////// Animation events //////
	// [animationcancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationcancel_event
	// [animationend] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationend_event
	// [animationiteration] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationiteration_event
	// [animationstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/animationstart_event
	
	
	////// Clipboard events //////
	// [copy] https://developer.mozilla.org/en-US/docs/Web/API/Window/copy_event
	// [cut] https://developer.mozilla.org/en-US/docs/Web/API/Window/cut_event
	// [paste] https://developer.mozilla.org/en-US/docs/Web/API/Window/paste_event
	
	
	////// Connection events //////
	// [offline] https://developer.mozilla.org/en-US/docs/Web/API/Window/offline_event
	// [online] https://developer.mozilla.org/en-US/docs/Web/API/Window/online_event
	
	
	////// Focus events //////
	// [blur] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur_event
	// [focus] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus_event
	
	
	////// Gamepad events //////
	// [gamepadconnected] https://developer.mozilla.org/en-US/docs/Web/API/Window/gamepadconnected_event
	// [gamepaddisconnected] https://developer.mozilla.org/en-US/docs/Web/API/Window/gamepaddisconnected_event
	
	
	////// History events //////
	// [hashchange] https://developer.mozilla.org/en-US/docs/Web/API/Window/hashchange_event
	// [pagehide] https://developer.mozilla.org/en-US/docs/Web/API/Window/pagehide_event
	// [pageshow] https://developer.mozilla.org/en-US/docs/Web/API/Window/pageshow_event
	// [popstate] https://developer.mozilla.org/en-US/docs/Web/API/Window/popstate_event
	
	
	////// Load & unload events //////
	// [beforeunload] https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event
	// [DOMContentLoaded] https://developer.mozilla.org/en-US/docs/Web/API/Window/DOMContentLoaded_event
	// [load] https://developer.mozilla.org/en-US/docs/Web/API/Window/load_event
	// [unload] https://developer.mozilla.org/en-US/docs/Web/API/Window/unload_event
	
	
	////// Manifest events //////
	// [appinstalled] https://developer.mozilla.org/en-US/docs/Web/API/Window/appinstalled_event
	// [beforeinstallprompt] https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeinstallprompt_event
	
	
	////// Messaging events //////
	// [message] https://developer.mozilla.org/en-US/docs/Web/API/Window/message_event
	// [messageerror] https://developer.mozilla.org/en-US/docs/Web/API/Window/messageerror_event
	
	
	////// Print events //////
	// [afterprint] https://developer.mozilla.org/en-US/docs/Web/API/Window/afterprint_event
	// [beforeprint] https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeprint_event
	
	
	////// Promise rejection events //////
	// [rejectionhandled] https://developer.mozilla.org/en-US/docs/Web/API/Window/rejectionhandled_event
	// [unhandledrejection] https://developer.mozilla.org/en-US/docs/Web/API/Window/unhandledrejection_event
	
	
	////// Transition events //////
	// [transitioncancel] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitioncancel_event
	// [transitionend] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionend_event
	// [transitionrun] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionrun_event
	// [transitionstart] https://developer.mozilla.org/en-US/docs/Web/API/Element/transitionstart_event
	
	
	////// Deprecated events //////
	// [orientationchange](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientationchange_event
	// [vrdisplayactivate](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/vrdisplayactivate_event
	// [vrdisplayconnect](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/vrdisplayconnect_event
	// [vrdisplaydisconnect](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/vrdisplaydisconnect_event
	// [vrdisplaydeactivate](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/vrdisplaydeactivate_event
	// [vrdisplaypresentchange](Deprecated)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/vrdisplaypresentchange_event
};


#endif //DKWindow_H