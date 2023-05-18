// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
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
	virtual bool window(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute WindowProxy self;
	virtual bool self(DKString&, bool) { return false; }
	
	// [LegacyUnforgeable] readonly attribute Document document;
	virtual bool document(DKString&, bool) { return false; }
	
	// attribute DOMString name;
	virtual bool name(DOMString&, bool) { return false; }
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	virtual bool location(DKString&, bool) { return false; }
	
	// readonly attribute History history;
	virtual bool history(DKString&, bool) { return false; }
	
	// readonly attribute CustomElementRegistry customElements;
	virtual bool customElements(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp locationbar;
	virtual bool locationbar(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp menubar;
	virtual bool menubar(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp personalbar;
	virtual bool personalbar(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	virtual bool scrollbars(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp statusbar;
	virtual bool statusbar(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute BarProp toolbar;
	virtual bool toolbar(DKString&, bool) { return false; }
	
	// attribute DOMString status;
	virtual bool status(DOMString&, bool) { return false; }
	
	// undefined close();
	virtual bool close() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// readonly attribute boolean closed;
	virtual bool closed(bool&, bool) { return false; }
	
	// undefined stop();
	virtual bool stop() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined focus();
	virtual bool focus() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined blur();
	virtual bool blur() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	virtual bool frames(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual bool length(unsigned int&, bool) { return false; }
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual bool top(DKString&, bool) { return false; }
	
	// attribute any opener;
	virtual bool opener(DKString&, bool) { return false; }
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual bool parent(DKString&, bool) { return false; }
	
	// readonly attribute Element? frameElement;
	virtual bool frameElement(DKString&, bool) { return false; }
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual bool open(USVString& _url, DOMString& _target, DOMString& _features) {
		DKDEBUGFUNC(_url, _target, _features);
		return DKTODO();
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	
	// the user agent
	// readonly attribute Navigator navigator;
	virtual bool navigator(DKString&, bool) { return false; }
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual bool clientInformation(DKString&, bool) { return false; }
	
	// readonly attribute boolean originAgentCluster;
	
	//user prompts
	// undefined alert();
	// undefined alert(DOMString message);
	virtual bool alert(DOMString& _message) {
		DKDEBUGFUNC(_message);
		return DKTODO();
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual bool confirm(DOMString& _message) {
		DKDEBUGFUNC(_message);
		return DKTODO();
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual bool prompt(DOMString& _message, DOMString _default) {
		DKDEBUGFUNC(_message, _default);
		return DKTODO();
	}
	
	// undefined print();
	virtual bool print() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual bool postMessage(DKString& _message, USVString& _targetOrigin) {
		DKDEBUGFUNC(_message, _targetOrigin);
		return DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual bool orientation(short&, bool) { return false; }
	//		
	//		attribute EventHandler onorientationchange;
			// TODO
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual bool event(DKString&, bool) { return false; }
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
			virtual bool captureEvents() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual bool releaseEvents(DKString& _eventType) {
				DKDEBUGFUNC(_eventType);
				return DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual bool external(DKString&, bool) { return false; }
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
			virtual bool showOpenFilePicker() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual bool showSaveFilePicker() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual bool showDirectoryPicker() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual bool queryLocalFonts() {
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
			virtual bool speechSynthesis(DKString&, bool) { return false; }
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual bool launchQueue(DKString&, bool) { return false; }
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual bool getComputedStyle() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual bool matchMedia(DKString& _mediaQueryString) {
				DKDEBUGFUNC(_mediaQueryString);
				return DKTODO();
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			virtual bool screen(DKString&, bool) { return false; }
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual bool visualViewport(DKString&, bool) { return false; }
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual bool moveTo(int& _x, int& _y) {
				DKDEBUGFUNC(_x, _y);
				return DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual bool moveBy(int& _deltaX, int& _deltaY) {
				DKDEBUGFUNC(_deltaX, _deltaY);
				return DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual bool resizeTo(int& _width, int& _height) {
				DKDEBUGFUNC(_width, _height);
				return DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual bool resizeBy(int& _xDelta, int& _yDelta) {
				DKDEBUGFUNC(_xDelta, _yDelta);
				return DKTODO();
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual bool innerWidth(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute long innerHeight;
			virtual bool innerHeight(unsigned int&, bool) { return false; }
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual bool scrollX(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			virtual bool pageXOffset(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute double scrollY;
			virtual bool scrollY(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			virtual bool pageYOffset(unsigned int&, bool) { return false; }
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual bool scroll() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual bool scrollTo() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual bool scrollBy() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			virtual bool screenX(int&, bool) { return false; }
	//		[Replaceable] readonly attribute long screenLeft;
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual bool screenY(int&, bool) { return false; }
	//		[Replaceable] readonly attribute long screenTop;
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual bool outerWidth(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual bool outerHeight(unsigned int&, bool) { return false; }
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual bool devicePixelRatio(double&, bool) { return false; }
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
			virtual bool requestIdleCallback() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			virtual bool cancelIdleCallback(DKString& handle) {
				DKDEBUGFUNC(handle);
				return DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			virtual bool getSelection() {
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