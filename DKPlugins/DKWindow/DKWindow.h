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
	virtual void self(const DKString& self)						{ _self = self; } 						// setter
	
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
	virtual void history(const DKString& history)				{ _history = history; } 				// setter
	
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
	virtual void stop() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined focus();
	virtual void focus() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined blur();
	virtual void blur() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	DKString _frames = "";
	virtual const DKString& frames()					{ return _frames; }					// getter
	virtual void frames(const DKString& frames)			{ _frames = frames; } 				// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	unsigned int _length = 0;
	virtual const unsigned int& length()				{ return _length; }					// getter
	virtual void length(const unsigned int& length)		{ _length = length; } 				// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	DKString _top = "";
	virtual const DKString& top()						{ return _top; }					// getter
	virtual void top(const DKString& top)				{ _top = top; } 					// setter
	
	// attribute any opener;
	DKString _opener = "";
	virtual const DKString& opener()					{ return _opener; }					// getter
	virtual void opener(const DKString& opener)			{ _opener = opener; } 				// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	DKString _parent = "";
	virtual const DKString& parent()					{ return _parent; }					// getter
	virtual void parent(const DKString& parent)			{ _parent = parent; } 				// setter
	
	// readonly attribute Element? frameElement;
	DKString _frameElement = "";
	virtual const DKString& frameElement()				{ return _frameElement; }			// getter
	virtual void frameElement(const DKString&)			{ _frameElement = frameElement; } 	// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	DKString _open = "";
	virtual const DKString& open(const USVString& url, const DOMString& target, const DOMString& features) {
		DKDEBUGFUNC(url, target, features);
		DKTODO();
		return _open;
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	DKString _navigator = "";
	virtual const DKString& navigator()									{ return _navigator; }							// getter
	virtual void navigator(const DKString& navigator)					{ _navigator = navigator; } 					// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	DKString _clientInformation = "";
	virtual const DKString& clientInformation()							{ return _clientInformation; }					// getter
	virtual void clientInformation(const DKString& clientInformation)	{ _clientInformation = _clientInformation; } 	// setter
	
	// readonly attribute boolean originAgentCluster;
	bool _originAgentCluster = false;
	virtual const bool& originAgentCluster()							{ return _originAgentCluster; }					// getter
	virtual void originAgentCluster(const bool& originAgentCluster)		{ _originAgentCluster = originAgentCluster; } 	// setter
	
	//user prompts
	// undefined alert();
	virtual void alert() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined alert(DOMString message);
	virtual void alert(const DOMString& message) {
		DKDEBUGFUNC(message);
		DKTODO();
	}
	
	// boolean confirm(optional DOMString message = "");
	bool _confirm = false;
	virtual const bool& confirm(const DOMString& message = "") {
		DKDEBUGFUNC(message);
		DKTODO();
		return _confirm;
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	DOMString _prompt = "";
	virtual const DOMString& prompt(const DOMString& message = "", const DOMString _default = "") {
		DKDEBUGFUNC(message, _default);
		DKTODO();
		return _prompt;
	}
	
	// undefined print();
	virtual void print() {
		DKDEBUGFUNC();
		DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	virtual void postMessage(const DKString& message, const USVString& targetOrigin, const DKString& transfer = "[]") {
		DKDEBUGFUNC(message, targetOrigin, transfer);
		DKTODO();
	}
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	virtual void postMessage(const DKString& message, const DKString& options = "{}") {
		DKDEBUGFUNC(message, options);
		DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			short _orientation = 0;
			virtual short orientation()												{ return _orientation; }							// getter
			virtual void orientation(const short& orientation)						{ _orientation = orientation; } 					// setter
	//		
	//		attribute EventHandler onorientationchange;
			DKString _onorientationchange = "";
			virtual const DKString& onorientationchange()							{ return _onorientationchange; }					// getter
			virtual void onorientationchange(const DKString& onorientationchange)	{ _onorientationchange = onorientationchange; } 	// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			DKString _event = "";
			virtual const DKString& event()											{ return _event; }									// getter
			virtual void event(const DKString&)										{ _event = event; } 								// setter
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
			virtual void captureEvents() {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		undefined releaseEvents();
			virtual void releaseEvents() {
				DKDEBUGFUNC();
				DKTODO();
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			DKString _external = "";
			virtual const DKString& external()							{ return _external; }				// getter
			virtual void external(const DKString& external)				{ _external = external; } 			// setter
	// };

	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			DKString _cookieStore = "";
			virtual const DKString& cookieStore()						{ return _cookieStore; }			// getter
			virtual void cookieStore(const DKString& cookieStore)		{ _cookieStore = cookieStore; } 	// setter
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			DKString _getDigitalGoodsService = "";
			virtual const DKString& getDigitalGoodsService(const DOMString& serviceProvider) {
				DKDEBUGFUNC(serviceProvider);
				DKTODO();
				return _getDigitalGoodsService;
			}
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			DKString _fence = "";
			virtual const DKString& fence()								{ return _fence; }				// getter
			virtual void fence(const DKString& fence)					{ _fence = fence; } 			// setter
	// };

	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			DKString _showOpenFilePicker = "";
			virtual const DKString& showOpenFilePicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return _showOpenFilePicker;
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			DKString _showSaveFilePicker = "";
			virtual const DKString& showSaveFilePicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return _showSaveFilePicker;
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			DKString _showDirectoryPicker = "";
			virtual const DKString& showDirectoryPicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return _showDirectoryPicker;
			}
	// };

	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			DKString _queryLocalFonts = "";
			virtual const DKString& queryLocalFonts(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return _queryLocalFonts;
			}
	// };

	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			DKString _onappinstalled = "";
			virtual const DKString& onappinstalled()									{ return _onappinstalled; }								// getter
			virtual void onappinstalled(const DKString& onappinstalled)					{ _onappinstalled = onappinstalled; } 					// setter
	//
	//		attribute EventHandler onbeforeinstallprompt;
			DKString _onbeforeinstallprompt = "";
			virtual const DKString& onbeforeinstallprompt()								{ return _onbeforeinstallprompt; }						// getter
			virtual void onbeforeinstallprompt(const DKString& onbeforeinstallprompt)	{ _onbeforeinstallprompt = onbeforeinstallprompt; } 	// setter
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