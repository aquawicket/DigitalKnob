// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef DKWindow_H
#define DKWindow_H

#include "DKEventTarget/DKEventTarget.h"
#include "DKScreen/DKScreen.h"

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
	DKString _window = "";
	virtual const DKString& window()							{ return _window; }						// getter
	virtual void window(const DKString& window)					{ _window = window; }					// setter
	
	// [Replaceable] readonly attribute WindowProxy self;
	DKString _self = "";
	virtual const DKString& self()								{ return _self; }						// getter
	virtual void self(const DKString& self)						{ _self = _elf; } 						// setter
	
	// [LegacyUnforgeable] readonly attribute Document document;
	DKString _document = "";
	virtual const DKString& document()							{ return _document; }					// getter
	virtual void document(const DKString& document)				{ _document = document; } 				// setter
	
	// attribute DOMString name;
	DOMString _name = "";
	virtual const DOMString& name()								{ return _name; }						// getter
	virtual void name(const DOMString& name)					{ _name = name; } 						// setter
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	DKString _location = "";
	virtual const DKString& location()							{ return _location; }					// getter
	virtual void location(const DKString& location)				{ _location = location; } 				// setter
	
	// readonly attribute History history;
	DKString _history = "";
	virtual const DKString& history()							{ return _history; }					// getter
	virtual void history(const DKString& history)				{ _history = history} 					// setter
	
	// readonly attribute CustomElementRegistry customElements;
	DKString _customElements = "";
	virtual const DKString& customElements()					{ return _customElements; }				// getter
	virtual void customElements(const DKString& customElements)	{ _customElements = customElements; } 	// setter
	
	// [Replaceable] readonly attribute BarProp locationbar;
	DKString _locationbar = "";
	virtual const DKString locationbar()						{ return _locationbar; }				// getter
	virtual void locationbar(const DKString& locationbar)		{ _locationbar = locationbar; } 		// setter
	
	// [Replaceable] readonly attribute BarProp menubar;
	DKString _menubar = "";
	virtual const DKString& menubar()							{ return _menubar; }					// getter
	virtual void menubar(const DKString& menubar)				{ _menubar = menubar; } 				// setter
	
	// [Replaceable] readonly attribute BarProp personalbar;
	DKString _personalbar = "";
	virtual const DKString& personalbar()						{ return _personalbar; }				// getter
	virtual void personalbar(const DKString& personalbar)		{ _personalbar = personalbar; } 		// setter
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	DKString _scrollbars = "";
	virtual const DKString& scrollbars()						{ return _scrollbars; }					// getter
	virtual void scrollbars(const DKString& scrollbars)			{ _scrollbars = scrollbars; } 			// setter
	
	// [Replaceable] readonly attribute BarProp statusbar;
	DKString _statusbar = "";
	virtual const DKString& statusbar()							{ return _statusbar; }					// getter
	virtual void statusbar(const DKString& statusbar)			{ _statusbar = statusbar; } 			// setter
	
	// [Replaceable] readonly attribute BarProp toolbar;
	DKString _toolbar = "";
	virtual const DKString& toolbar()							{ return _toolbar; }					// getter
	virtual void toolbar(const DKString& toolbar)				{ _toolbar = toolbar; } 				// setter
	
	// attribute DOMString status;
	DOMString _status = "";
	virtual const DOMString& status()							{ return _status; }						// getter
	virtual void status(const DOMString& status)				{ _status = status; } 					// setter
	
	// undefined close();
	virtual void close() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// readonly attribute boolean closed;
	bool _closed = false;
	virtual const bool& closed()								{ return _closed; }						// getter
	virtual void closed(const bool&)							{ _closed = closed; } 					// setter
	
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
	virtual DKString frames()						{ return ""; }	// getter
	virtual void frames(const DKString&)			{ } 			// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	virtual unsigned int length()					{ return 0; }	// getter
	virtual void length(const unsigned int&)		{ } 			// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	virtual DKString top()							{ return ""; }	// getter
	virtual void top(const DKString&)				{ } 			// setter
	
	// attribute any opener;
	virtual DKString opener()						{ return ""; }	// getter
	virtual void opener(const DKString&)			{ } 			// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	virtual DKString parent()						{ return ""; }	// getter
	virtual void parent(const DKString&)			{ } 			// setter
	
	// readonly attribute Element? frameElement;
	virtual DKString frameElement()					{ return ""; }	// getter
	virtual void frameElement(const DKString&)		{ } 			// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	virtual bool open(USVString& url, DOMString& target, DOMString& features) {
		DKDEBUGFUNC(url, target, features);
		return DKTODO();
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	virtual DKString navigator()					{ return ""; }	// getter
	virtual void navigator(const DKString&)			{ } 			// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	virtual DKString clientInformation()			{ return ""; }	// getter
	virtual void clientInformation(const DKString&)	{ } 			// setter
	
	// readonly attribute boolean originAgentCluster;
	virtual bool originAgentCluster()				{ return false; }// getter
	virtual void originAgentCluster(const bool&)	{ } 			// setter
	
	//user prompts
	// undefined alert();
	virtual bool alert() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined alert(DOMString message);
	virtual bool alert(DOMString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	
	// boolean confirm(optional DOMString message = "");
	virtual bool confirm(DOMString& message) {
		DKDEBUGFUNC(message);
		return DKTODO();
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	virtual bool prompt(DOMString& message, DOMString _default) {
		DKDEBUGFUNC(message, _default);
		return DKTODO();
	}
	
	// undefined print();
	virtual bool print() {
		DKDEBUGFUNC();
		return DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	virtual bool postMessage(DKString& message, USVString& targetOrigin, DKString& transfer) {
		DKDEBUGFUNC(message, targetOrigin, transfer);
		return DKTODO();
	}
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual bool postMessage(DKString& message, DKString& options) {
		DKDEBUGFUNC(message, options);
		return DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			virtual short orientation()						{ return 0; }	// getter
			virtual void orientation(const short&)				{ } 			// setter
	//		
	//		attribute EventHandler onorientationchange;
			virtual DKString onorientationchange()				{ return ""; }	// getter
			virtual void onorientationchange(const DKString&)	{ } 			// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			virtual DKString event()							{ return ""; }	// getter
			virtual void event(const DKString&)					{ } 			// setter
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
			virtual bool releaseEvents() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			virtual DKString external()						{ return ""; }	// getter
			virtual void external(const DKString&)				{ } 			// setter
	// };

	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			virtual DKString cookieStore()						{ return ""; }	// getter
			virtual void cookieStore(const DKString&)			{ } 			// setter
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			virtual bool getDigitalGoodsService(DKString& serviceProvider) {
				DKDEBUGFUNC(serviceProvider);
				return DKTODO();
			}
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			virtual DKString fence()							{ return ""; }	// getter
			virtual void fence(const DKString&)					{ } 			// setter
	// };

	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			virtual bool showOpenFilePicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			virtual bool showSaveFilePicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			virtual bool showDirectoryPicker(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	// };

	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			virtual bool queryLocalFonts(DKString& options) {
				DKDEBUGFUNC(options);
				return DKTODO();
			}
	// };

	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			virtual DKString onappinstalled()							{ return ""; }	// getter
			virtual void onappinstalled(const DKString&)				{ } 			// setter
	//
	//		attribute EventHandler onbeforeinstallprompt;
			virtual DKString onbeforeinstallprompt()					{ return ""; }	// getter
			virtual void onbeforeinstallprompt(const DKString&)			{ } 			// setter
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			virtual DKString portalHost()								{ return ""; }	// getter
			virtual void portalHost(const DKString&)					{ } 			// setter
	// };

	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			virtual DKString speechSynthesis()							{ return ""; }	// getter
			virtual void speechSynthesis(const DKString&)				{ } 			// setter
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			virtual DKString launchQueue()								{ return ""; }	// getter
			virtual void launchQueue(const DKString&)					{ } 			// setter
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			virtual bool navigate(DKString& dir) {
				DKDEBUGFUNC(dir);
				return DKTODO();
			}
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			virtual bool getComputedStyle(DKString& elt, DKString& pseudoElt) {
				DKDEBUGFUNC(elt, pseudoElt);
				return DKTODO();
			}
	// };

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			virtual bool matchMedia(DKString& mediaQueryString) {
				DKDEBUGFUNC(mediaQueryString);
				return DKTODO();
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			DKScreen* _screen = NULL;
			virtual DKScreen& screen()								{ return *_screen; }	// getter
			virtual void screen(DKScreen& screen)					{ _screen = &screen; } 	// setter
			
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			virtual DKString visualViewport()						{ return ""; }			// getter
			virtual void visualViewport(const DKString&)			{ } 					// setter
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual bool moveTo(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		undefined moveBy(long x, long y);
			virtual bool moveBy(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		undefined resizeTo(long width, long height);
			virtual bool resizeTo(int& width, int& height) {
				DKDEBUGFUNC(width, height);
				return DKTODO();
			}
	//
	//		undefined resizeBy(long x, long y);
			virtual bool resizeBy(int& x, int& y) {
				DKDEBUGFUNC(x, y);
				return DKTODO();
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			virtual int innerWidth()						{ return 0; }	// getter
			virtual void innerWidth(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long innerHeight;
			virtual int innerHeight()						{ return 0; }	// getter
			virtual void innerHeight(const int&)			{ } 			// setter
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			virtual double scrollX()						{ return 0.0; }	// getter
			virtual void scrollX(const double&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			virtual double pageXOffset()					{ return 0.0; }	// getter
			virtual void pageXOffset(const double&)			{ } 			// setter
	//
	//		[Replaceable] readonly attribute double scrollY;
			virtual double scrollY()						{ return 0.0; }	// getter
			virtual void scrollY(const double&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			virtual double pageYOffset()					{ return 0.0; }	// getter
			virtual void pageYOffset(const double&)			{ } 			// setter
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
			virtual int screenX()							{ return 0; }	// getter
			virtual void screenX(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long screenLeft;
			virtual int screenLeft()						{ return 0; }	// getter
			virtual void screenLeft(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long screenY;
			virtual int screenY()							{ return 0; }	// getter
			virtual void screenY(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long screenTop;
			virtual int screenTop()							{ return 0; }	// getter
			virtual void screenTop(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long outerWidth;
			virtual int outerWidth()						{ return 0; }	// getter
			virtual void outerWidth(const int&)				{ } 			// setter
	//
	//		[Replaceable] readonly attribute long outerHeight;
			virtual int outerHeight()						{ return 0; }	// getter
			virtual void outerHeight(const int&)			{ } 			// setter
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			virtual double devicePixelRatio()				{ return 0; }	// getter
			virtual void devicePixelRatio(const double&)	{ } 			// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			virtual DKString ondeviceorientation()						{ return ""; }	// getter
			virtual void ondeviceorientation(const DKString&)			{ } 			// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			virtual DKString ondeviceorientationabsolute()				{ return ""; }	// getter
			virtual void ondeviceorientationabsolute(const DKString&)	{ } 			// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			virtual DKString ondevicemotion()							{ return ""; }	// getter
			virtual void ondevicemotion(const DKString&)				{ } 			// setter
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
			virtual bool getScreenDetails() {
				DKDEBUGFUNC();
				return DKTODO();
			}
	// };
};


#endif //DKWindow_H