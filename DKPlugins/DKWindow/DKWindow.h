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
		interfaceName = "Window";
		interfaceAddress = pointerToAddress(this);
		DKINFO("DKWindow("+interfaceAddress+") \n");
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
			virtual bool captureEvents() { // [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual bool releaseEvents(DKString& eventType) { // [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
				DKDEBUGFUNC(eventType);
				return DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual bool external(DKString&, bool) { return false; } // [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
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
			virtual bool showOpenFilePicker() { // [Window.showOpenFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual bool showSaveFilePicker() { // [Window.showSaveFilePicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual bool showDirectoryPicker() { // [Window.showDirectoryPicker()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/showDirectoryPicker
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual bool queryLocalFonts() { // [Window.queryLocalFonts()](Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/queryLocalFonts
				DKDEBUGFUNC();
				return DKTODO();
			}
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
			virtual bool speechSynthesis(DKString&, bool) { return false; } // [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual bool launchQueue(DKString&, bool) { return false; } // [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual bool getComputedStyle() { // [Window.getComputedStyle()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual bool matchMedia(DKString& mediaQueryString) { // [Window.matchMedia()] https://developer.mozilla.org/en-US/docs/Web/API/Window/matchMedia
				DKDEBUGFUNC(mediaQueryString);
				return DKTODO();
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			virtual bool screen(DKString&, bool) { return false; } // [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual bool visualViewport(DKString&, bool) { return false; } // [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual bool moveTo(int& x, int& y) { // [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveTo
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual bool moveBy(int& deltaX, int& deltaY) { // [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/moveBy
				DKDEBUGFUNC(deltaX, deltaY);
				return DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual bool resizeTo(int& width, int& height) { // [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeTo
				DKDEBUGFUNC(width, height);
				return DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual bool resizeBy(int& xDelta, int& yDelta) { // [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/resizeBy
				DKDEBUGFUNC(xDelta, yDelta);
				return DKTODO();
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual bool innerWidth(unsigned int&, bool) { return false; } // [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	//
	//		[Replaceable] readonly attribute long innerHeight;
			virtual bool innerHeight(unsigned int&, bool) { return false; } // [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual bool scrollX(unsigned int&, bool) { return false; } // [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX	
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			virtual bool pageXOffset(unsigned int&, bool) { return false; } // [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	//
	//		[Replaceable] readonly attribute double scrollY;
			virtual bool scrollY(unsigned int&, bool) { return false; } // [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			virtual bool pageYOffset(unsigned int&, bool) { return false; } // [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual bool scroll() { // [Window.scroll()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scroll
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual bool scrollTo() { // [Window.scrollTo()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollTo
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual bool scrollBy() { // [Window.scrollBy()] https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollBy
				DKDEBUGFUNC();
				return DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			virtual bool screenX(int&, bool) { return false; } // [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	//		[Replaceable] readonly attribute long screenLeft;
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual bool screenY(int&, bool) { return false; } // [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	//		[Replaceable] readonly attribute long screenTop;
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual bool outerWidth(unsigned int&, bool) { return false; } // [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual bool outerHeight(unsigned int&, bool) { return false; } // [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual bool devicePixelRatio(double&, bool) { return false; } // [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
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
			virtual bool requestIdleCallback() { // [Window.requestIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/requestIdleCallback
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			virtual bool cancelIdleCallback(DKString& handle) { // [Window.cancelIdleCallback()] https://developer.mozilla.org/en-US/docs/Web/API/Window/cancelIdleCallback
				DKDEBUGFUNC(handle);
				return DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			virtual bool getSelection() { // [Window.getSelection()] https://developer.mozilla.org/en-US/docs/Web/API/Window/getSelection
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
	// };
};


#endif //DKWindow_H