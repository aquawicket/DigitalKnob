// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Window.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef DKWindow_H
#define DKWindow_H

#include "DKEventTarget/DKEventTarget.h"

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
class DKWindow : public DKEventTarget
{
public:
	DKWindow() : DKEventTarget() {
		DKDEBUGFUNC();
		eventTargetClass = "Window";
		eventTargetAddress = pointerToAddress(this);
	}
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	virtual bool window(DKString&, bool) { return false; } // [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	
	// [Replaceable] readonly attribute WindowProxy self;
	virtual bool self(DKString&, bool) { return false; } // [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	
	// [LegacyUnforgeable] readonly attribute Document document;
	virtual bool document(DKString&, bool) { return false; } // [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	
	// attribute DOMString name;
	virtual bool name(DKString&, bool) { return false; } // [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	virtual bool location(DKString&, bool) { return false; } // [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	
	// readonly attribute History history;
	virtual bool history(DKString&, bool) { return false; } // [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	
	// readonly attribute CustomElementRegistry customElements;
	virtual bool customElements(DKString&, bool) { return false; } // [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	
	// [Replaceable] readonly attribute BarProp locationbar;
	virtual bool locationbar(DKString&, bool) { return false; } // [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	
	// [Replaceable] readonly attribute BarProp menubar;
	virtual bool menubar(DKString&, bool) { return false; } // [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	
	// [Replaceable] readonly attribute BarProp personalbar;
	virtual bool personalbar(DKString&, bool) { return false; } // [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	virtual bool scrollbars(DKString&, bool) { return false; } // [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	
	// [Replaceable] readonly attribute BarProp statusbar;
	virtual bool statusbar(DKString&, bool) { return false; } // [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	
	// [Replaceable] readonly attribute BarProp toolbar;
	virtual bool toolbar(DKString&, bool) { return false; } // [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	
	// attribute DOMString status;
	virtual bool status(DKString&, bool) { return false; } // [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	
	// undefined close();
	virtual bool close() { // [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/Window/close
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// readonly attribute boolean closed;
	virtual bool closed(bool&, bool) { return false; } // [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	
	// undefined stop();
	virtual bool stop() { // [Window.stop()] https://developer.mozilla.org/en-US/docs/Web/API/Window/stop
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined focus();
	virtual bool focus() { // [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/Window/focus
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined blur();
	virtual bool blur() { // [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/Window/blur
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	virtual bool frames(DKString&, bool) { return false; } // [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual bool length(unsigned int&, bool) { return false; } // [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual bool top(DKString&, bool) { return false; } // [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	
	// attribute any opener;
	virtual bool opener(DKString&, bool) { return false; } // [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual bool parent(DKString&, bool) { return false; } // [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	
	// readonly attribute Element? frameElement;
	virtual bool frameElement(DKString&, bool) { return false; } // [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual bool open() { // [Window.open()] https://developer.mozilla.org/en-US/docs/Web/API/Window/open
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	
	// the user agent
	// readonly attribute Navigator navigator;
	virtual bool navigator(DKString&, bool) { return false; } // [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual bool clientInformation(DKString&, bool) { return false; } // [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	
	// readonly attribute boolean originAgentCluster;
	
	//user prompts
	// undefined alert();
	// undefined alert(DOMString message);
	virtual bool alert(DKString& message) { // [Window.alert()] https://developer.mozilla.org/en-US/docs/Web/API/Window/alert
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual bool confirm(DKString& message) { // [Window.confirm()] https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual bool prompt() { // [Window.prompt()] https://developer.mozilla.org/en-US/docs/Web/API/Window/prompt
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined print();
	virtual bool print() { // [Window.print()] https://developer.mozilla.org/en-US/docs/Web/API/Window/print
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual bool postMessage() { // [Window.postMessage()] https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual bool orientation(int&, bool) { return false; } // [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	//		
	//		attribute EventHandler onorientationchange;
	
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual bool event(DKString&, bool) { return false; } // [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	// };
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes GlobalEventHandlers;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowEventHandlers;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowOrWorkerGlobalScope;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes AnimationFrameProvider;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowSessionStorage;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// Window includes WindowLocalStorage;

	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// partial interface Window {
	//		undefined captureEvents();
	//		undefined releaseEvents();
	//
	//		[Replaceable, SameObject] readonly attribute External external;
	// };

	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
	// };

	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
	// };

	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
	// };

	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
	//		attribute EventHandler onbeforeinstallprompt;
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
	// };

	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
	// };

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
	//		[SameObject, Replaceable] readonly attribute Screen screen;
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
	//		undefined moveBy(long x, long y);
	//		undefined resizeTo(long width, long height);
	//		undefined resizeBy(long x, long y);
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
	//		[Replaceable] readonly attribute long innerHeight;
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
	//		[Replaceable] readonly attribute double pageXOffset;
	//		[Replaceable] readonly attribute double scrollY;
	//		[Replaceable] readonly attribute double pageYOffset;
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
	//		[Replaceable] readonly attribute long screenLeft;
	//		[Replaceable] readonly attribute long screenY;
	//		[Replaceable] readonly attribute long screenTop;
	//		[Replaceable] readonly attribute long outerWidth;
	//		[Replaceable] readonly attribute long outerHeight;
	//		[Replaceable] readonly attribute double devicePixelRatio;
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
	//		undefined cancelIdleCallback(unsigned long handle);
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
	// };

	////////////////////////////////////////////////////////
	virtual bool caches(DKString&, bool) { return false; } // [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/caches
	virtual bool console(DKString&, bool) { return false; } // [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	virtual bool credentialless(bool&, bool) { return false; } // [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	virtual bool crypto(DKString&, bool) { return false; } // [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	virtual bool devicePixelRatio(double&, bool) { return false; } // [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	virtual bool fullScreen(bool&, bool) { return false; } // [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	virtual bool indexedDB(DKString&, bool) { return false; } // [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	virtual bool innerHeight(unsigned int&, bool) { return false; } // [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	virtual bool innerWidth(unsigned int&, bool) { return false; } // [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	virtual bool isSecureContext(bool&, bool) { return false; } // [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	virtual bool launchQueue(DKString&, bool) { return false; } // [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	virtual bool localStorage(DKString&, bool) { return false; } // [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	virtual bool mozInnerScreenX(double&, bool) { return false; } // [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	virtual bool mozInnerScreenY(double&, bool) { return false; } // [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	virtual bool navigation(DKString&, bool) { return false; } // [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	virtual bool origin(DKString&, bool) { return false; } // [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	virtual bool outerHeight(unsigned int&, bool) { return false; } // [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	virtual bool outerWidth(unsigned int&, bool) { return false; } // [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	virtual bool pageXOffset(unsigned int&, bool) { return false; } // [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	virtual bool pageYOffset(unsigned int&, bool) { return false; } // [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	virtual bool performance(DKString&, bool) { return false; } // [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	virtual bool scheduler(DKString&, bool) { return false; } // [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	virtual bool screen(DKString&, bool) { return false; } // [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	virtual bool screenX(int&, bool) { return false; } // [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	virtual bool screenY(int&, bool) { return false; } // [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	virtual bool scrollMaxX(unsigned int&, bool) { return false; } // [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	virtual bool scrollMaxY(unsigned int&, bool) { return false; } // [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	virtual bool scrollX(unsigned int&, bool) { return false; } // [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX	
	virtual bool scrollY(unsigned int&, bool) { return false; } // [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	virtual bool sessionStorage(DKString&, bool) { return false; } // [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	virtual bool speechSynthesis(DKString&, bool) { return false; } // [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	virtual bool visualViewport(DKString&, bool) { return false; } // [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	virtual bool windows(DKString&, bool) { return false; } // [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool content(DKString&, bool) { return false; } // [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool defaultStatus(DKString&, bool) { return false; } // [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	
	virtual bool external(DKString&, bool) { return false; } // [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	virtual bool returnValue(DKString&, bool) { return false; } // [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	virtual bool sidebar(DKString&, bool) { return false; } // [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	virtual bool atob(DKString& encodedData) { // [Window.atob()] https://developer.mozilla.org/en-US/docs/Web/API/Window/atob
		DKDEBUGFUNC(encodedData);
		return DKTODO();
	}
	virtual bool btoa(DKString& stringToEncode) { // [Window.btoa()] https://developer.mozilla.org/en-US/docs/Web/API/Window/btoa
		DKDEBUGFUNC(stringToEncode);
		return DKTODO();
	}
	virtual bool cancelAnimationFrame(DKString& requestID) { // [Window.cancelAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelAnimationFrame
		DKDEBUGFUNC(requestID);
		return DKTODO();
	}
	virtual bool cancelIdleCallback(DKString& handle) { // [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
		DKDEBUGFUNC(handle);
		return DKTODO();
	}
	virtual bool clearImmediate(DKString& immediateID) { // [Window.clearImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearImmediate
		DKDEBUGFUNC(immediateID);
		return DKTODO();
	}
	virtual bool clearInterval(DKString& intervalID) { // [Window.clearInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearInterval
		DKDEBUGFUNC(intervalID);
		return DKTODO();
	}
	virtual bool clearTimeout(DKString& timeoutID) { // [Window.clearTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/clearTimeout
		DKDEBUGFUNC(timeoutID);
		return DKTODO();
	}
	virtual bool createImageBitmap() { // [Window.createImageBitmap()] https://developer.mozilla.org/en-US/docs/Web/API/createImageBitmap
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool dump(DKString& message) { // [Window.dump()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/dump
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	virtual bool fetch() { // [Window.fetch()] https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool find() { // [Window.find()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/find
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool getComputedStyle() { // [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool getDefaultComputedStyle() { // [Window.getDefaultComputedStyle()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/getDefaultComputedStyle
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool getSelection() { // [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool matchMedia(DKString& mediaQueryString) { // [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
		DKDEBUGFUNC(mediaQueryString);
		return DKTODO();
	}
	virtual bool moveBy(int& deltaX, int& deltaY) { // [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
		DKDEBUGFUNC(deltaX, deltaY);
		return DKTODO();
	}
	virtual bool moveTo(int& x, int& y) { // [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
		DKDEBUGFUNC(x, y);
		return DKTODO();
	}
	virtual bool queryLocalFonts() { // [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool reportError() { // [Window.reportError()] https://developer.mozilla.org/en-US/docs/Web/API/reportError
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool requestAnimationFrame() { // [Window.requestAnimationFrame()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestAnimationFrame
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool requestIdleCallback() { // [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool resizeBy(int& xDelta, int& yDelta) { // [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
		DKDEBUGFUNC(xDelta, yDelta);
		return DKTODO();
	}
	virtual bool resizeTo(int& width, int& height) { // [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
		DKDEBUGFUNC(width, height);
		return DKTODO();
	}
	virtual bool scroll() { // [Window.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool scrollBy() { // [Window.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool scrollByLines() { // [Window.scrollByLines()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByLines
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool scrollByPages() { // [Window.scrollByPages()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollByPages
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool scrollTo() { // [Window.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool setImmediate() { // [Window.setImmediate()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setImmediate
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool setInterval() { // [Window.setInterval()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setInterval
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool setResizable() { // [Window.setResizable()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool setTimeout() { // [Window.setTimeout()] https://developer.mozilla.org/en-US/docs/Web/API/Window/setTimeout
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool sizeToContent() { // [Window.sizeToContent()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/sizeToContent
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool showOpenFilePicker() { // [Window.showOpenFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool showSaveFilePicker() { // [Window.showSaveFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool showDirectoryPicker() { // [Window.showDirectoryPicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showDirectoryPicker
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool updateCommands(DKString& sCommandName) { // [Window.updateCommands()](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/updateCommands
		DKDEBUGFUNC(sCommandName);
		return DKTODO();
	}
	virtual bool back() { // [Window.back()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/back
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool captureEvents() { // [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool forward() { // [Window.forward()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/forward
		DKDEBUGFUNC();
		return DKTODO();
	}
	virtual bool releaseEvents(DKString& eventType) { // [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
		DKDEBUGFUNC(eventType);
		return DKTODO();
	}
	virtual bool showModalDialog() { // [Window.showModalDialog()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/showModalDialog
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