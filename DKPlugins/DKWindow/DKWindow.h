// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef DKWindow_H
#define DKWindow_H

#include "DKEvent/DKEvent.h"
#include "DKEventTarget/DKEventTarget.h"
#include "DKScreen/DKScreen.h"
#include "DKDocument/DKDocument.h"
#include "DKLocation/DKLocation.h"
#include "DKElement/DKElement.h"
#include "DKNavigator/DKNavigator.h"
#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


////// WindowProxy //////
class DKWindow;
typedef DKWindow DKWindowProxy;

// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
class DKWindow : virtual public DKEventTarget
{
public:
	DKWindow() : DKEventTarget() {
		DKDEBUGFUNC();
		interfaceName = "Window";
		address[interfaceName] = pointerToAddress(this);
		DKINFO("DK"+interfaceName+"("+interfaceAddress+","+address[interfaceName]+") \n");
	}
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	DKWindowProxy* _window = NULL;
	virtual DKWindowProxy* window();																	// getter
	virtual void window(DKWindowProxy* window);															// setter
	
	// [Replaceable] readonly attribute WindowProxy self;
	DKWindowProxy* _self = NULL;
	virtual DKWindowProxy* self();																		// getter
	virtual void self(DKWindowProxy* self);										 						// setter
	
	// [LegacyUnforgeable] readonly attribute Document document;
	DKDocument* _document = NULL;
	virtual DKDocument* document()								{ return _document; }					// getter
	virtual void document(DKDocument* document)					{ _document = document; } 				// setter
	
	// attribute DOMString name;
	DOMString _name = "";
	virtual const DOMString& name()								{ return _name; }						// getter
	virtual void name(const DOMString& name)					{ _name = name; } 						// setter
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	DKLocation* _location = NULL;
	virtual DKLocation* location()								{ return _location; }					// getter
	virtual void location(DKLocation* location)					{ _location = location; } 				// setter
	
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
	virtual const DKString& locationbar()						{ return _locationbar; }				// getter
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
	virtual void closed(const bool& closed)						{ _closed = closed; } 					// setter
	
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
	DKWindowProxy* _frames = NULL;
	virtual DKWindowProxy* frames();																	// getter
	virtual void frames(DKWindowProxy* frames); 														// setter
	
	// [Replaceable] readonly attribute unsigned long length;
	unsigned int _length = 0;
	virtual const unsigned int& length()						{ return _length; }						// getter
	virtual void length(const unsigned int& length)				{ _length = length; } 					// setter
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	DKWindowProxy* _top = NULL;
	virtual DKWindowProxy* top();																		// getter
	virtual void top(DKWindowProxy* top);																// setter
	
	// attribute any opener;
	DKString _opener = "";
	virtual const DKString& opener()							{ return _opener; }						// getter
	virtual void opener(const DKString& opener)					{ _opener = opener; } 					// setter
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	DKWindowProxy* _parent = NULL;
	virtual DKWindowProxy* parent();																	// getter
	virtual void parent(DKWindowProxy* parent);															// setter
	
	// readonly attribute Element? frameElement;
	DKElement* _frameElement = NULL;
	virtual DKElement* frameElement()							{ return _frameElement; }				// getter
	virtual void frameElement(DKElement* frameElement)			{ _frameElement = frameElement; } 		// setter
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	DKWindowProxy* _open = NULL;
	virtual DKWindowProxy* open(const USVString& url, const DOMString& target, const DOMString& features) {
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
	DKNavigator* _navigator = NULL;
	virtual DKNavigator* navigator()									{ return _navigator; }							// getter
	virtual void navigator(DKNavigator* navigator)						{ _navigator = navigator; } 					// setter
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	DKNavigator* _clientInformation = NULL;
	virtual DKNavigator* clientInformation()							{ return _clientInformation; }					// getter
	virtual void clientInformation(DKNavigator* clientInformation)		{ _clientInformation = clientInformation; } 	// setter
	
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
			virtual const short& orientation()										{ return _orientation; }							// getter
			virtual void orientation(const short& orientation)						{ _orientation = orientation; } 					// setter

	//		attribute EventHandler onorientationchange;
			DKString _onorientationchange = "";
			virtual const DKString& onorientationchange()							{ return _onorientationchange; }					// getter
			virtual void onorientationchange(const DKString& onorientationchange)	{ _onorientationchange = onorientationchange; } 	// setter
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			DKEvent* _event = NULL;
			virtual DKEvent* event()												{ return _event; }									// getter
			virtual void event(DKEvent* event)										{ _event = event; } 								// setter
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

	//		undefined releaseEvents();
			virtual void releaseEvents() {
				DKDEBUGFUNC();
				DKTODO();
			}

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

	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			DKString _showSaveFilePicker = "";
			virtual const DKString& showSaveFilePicker(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
				return _showSaveFilePicker;
			}

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

	//		attribute EventHandler onbeforeinstallprompt;
			DKString _onbeforeinstallprompt = "";
			virtual const DKString& onbeforeinstallprompt()								{ return _onbeforeinstallprompt; }						// getter
			virtual void onbeforeinstallprompt(const DKString& onbeforeinstallprompt)	{ _onbeforeinstallprompt = onbeforeinstallprompt; } 	// setter
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			DKString _portalHost = "";
			virtual const DKString& portalHost()										{ return _portalHost; }									// getter
			virtual void portalHost(const DKString& portalHost)							{ _portalHost = portalHost; } 							// setter
	// };

	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			DKString _speechSynthesis = "";
			virtual const DKString& speechSynthesis()									{ return _speechSynthesis; }							// getter
			virtual void speechSynthesis(const DKString& speechSynthesis)				{ _speechSynthesis = speechSynthesis; } 				// setter
	// };

	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			DKString _launchQueue = "";
			virtual const DKString& launchQueue()										{ return _launchQueue; }								// getter
			virtual void launchQueue(const DKString& launchQueue)						{ _launchQueue = launchQueue; } 						// setter
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			virtual void navigate(const DKString& dir) {
				DKDEBUGFUNC(dir);
				DKTODO();
			}
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			DKCSSStyleDeclaration* _getComputedStyle = NULL;
			virtual DKCSSStyleDeclaration* getComputedStyle(DKElement* elt, const CSSOMString& pseudoElt = "") {
				DKDEBUGFUNC(elt, pseudoElt);
				DKTODO();
				return _getComputedStyle;
			}
	// };

	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			DKString _matchMedia = "";
			virtual const DKString& matchMedia(const CSSOMString& mediaQueryString) {
				DKDEBUGFUNC(mediaQueryString);
				DKTODO();
				return _matchMedia;
			}
			
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			DKScreen* _screen = NULL;
			virtual DKScreen* screen()									{ return _screen; }							// getter
			virtual void screen(DKScreen* screen)						{ _screen = screen; } 						// setter
			
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			DKString _visualViewport = "";
			virtual const DKString& visualViewport()					{ return _visualViewport; }					// getter
			virtual void visualViewport(const DKString& visualViewport)	{ _visualViewport = visualViewport; } 		// setter

	//		// browsing context
	//		undefined moveTo(long x, long y);
			virtual void moveTo(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		undefined moveBy(long x, long y);
			virtual void moveBy(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		undefined resizeTo(long width, long height);
			virtual void resizeTo(const int& width, const int& height) {
				DKDEBUGFUNC(width, height);
				DKTODO();
			}

	//		undefined resizeBy(long x, long y);
			virtual void resizeBy(const int& x, const int& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			int _innerWidth = 0;
			virtual const int& innerWidth()						{ return _innerWidth; }				// getter
			virtual void innerWidth(const int& innerWidth)		{ _innerWidth = innerWidth; } 		// setter

	//		[Replaceable] readonly attribute long innerHeight;
			int _innerHeight = 0;
			virtual const int& innerHeight()					{ return _innerHeight; }			// getter
			virtual void innerHeight(const int& innerHeight)	{ _innerHeight = innerHeight; } 	// setter

	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			double _scrollX = 0.0;
			virtual const double& scrollX()						{ return _scrollX; }				// getter
			virtual void scrollX(const double& scrollX)			{ _scrollX = scrollX; } 			// setter

	//		[Replaceable] readonly attribute double pageXOffset;
			double _pageXOffset = 0.0;
			virtual const double& pageXOffset()					{ return _pageXOffset; }			// getter
			virtual void pageXOffset(const double& pageXOffset)	{ _pageXOffset = pageXOffset; } 	// setter

	//		[Replaceable] readonly attribute double scrollY;
			double _scrollY = 0.0;
			virtual const double& scrollY()						{ return _scrollY; }				// getter
			virtual void scrollY(const double& scrollY)			{ _scrollY = scrollY; } 			// setter

	//		[Replaceable] readonly attribute double pageYOffset;
			double _pageYOffset = 0.0;
			virtual const double& pageYOffset()					{ return _pageYOffset; }			// getter
			virtual void pageYOffset(const double& pageYOffset)	{ _pageYOffset = pageYOffset; } 	// setter

	//		undefined scroll(optional ScrollToOptions options = {});
			virtual void scroll(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scroll(unrestricted double x, unrestricted double y);
			virtual void scroll(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}
			
	//		undefined scrollTo(optional ScrollToOptions options = {});
			virtual void scrollTo(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			virtual void scrollTo(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		undefined scrollBy(optional ScrollToOptions options = {});
			virtual void scrollBy(const DKString& options = "{}") {
				DKDEBUGFUNC(options);
				DKTODO();
			}
			
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			virtual void scrollBy(const double& x, const double& y) {
				DKDEBUGFUNC(x, y);
				DKTODO();
			}

	//		// client
	//		[Replaceable] readonly attribute long screenX;
			int _screenX = 0;
			virtual const int& screenX()					{ return _screenX; }			// getter
			virtual void screenX(const int& screenX)		{ _screenX = screenX; } 		// setter

	//		[Replaceable] readonly attribute long screenLeft;
			int _screenLeft = 0;
			virtual const int& screenLeft()					{ return _screenLeft; }			// getter
			virtual void screenLeft(const int& screenLeft)	{ _screenLeft = screenLeft; } 	// setter
	//
	//		[Replaceable] readonly attribute long screenY;
			int _screenY = 0;
			virtual const int& screenY()					{ return _screenY; }			// getter
			virtual void screenY(const int& screenY)		{ _screenY = screenY; } 		// setter
	//
	//		[Replaceable] readonly attribute long screenTop;
			int _screenTop = 0;
			virtual const int& screenTop()					{ return _screenTop; }			// getter
			virtual void screenTop(const int& screenTop)	{ _screenTop = screenTop; } 	// setter
	//
	//		[Replaceable] readonly attribute long outerWidth;
			int _outerWidth = 0;
			virtual const int& outerWidth()					{ return _outerWidth; }			// getter
			virtual void outerWidth(const int& outerWidth)	{ _outerWidth = outerWidth; } 	// setter
	//
	//		[Replaceable] readonly attribute long outerHeight;
			int _outerHeight = 0;
			virtual const int& outerHeight()				{ return _outerHeight; }		// getter
			virtual void outerHeight(const int& outerHeight){ _outerHeight = outerHeight; } // setter
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			double _devicePixelRatio = 0.0;
			virtual const double& devicePixelRatio()												{ return _devicePixelRatio; }									// getter
			virtual void devicePixelRatio(const double& devicePixelRatio)							{ _devicePixelRatio = devicePixelRatio; } 						// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			DKString _ondeviceorientation = "";
			virtual const DKString& ondeviceorientation()											{ return _ondeviceorientation; }								// getter
			virtual void ondeviceorientation(const DKString& ondeviceorientation)					{ _ondeviceorientation = ondeviceorientation; }					// setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			DKString _ondeviceorientationabsolute = "";
			virtual const DKString& ondeviceorientationabsolute()									{ return _ondeviceorientationabsolute; }						// getter
			virtual void ondeviceorientationabsolute(const DKString& ondeviceorientationabsolute)	{ _ondeviceorientationabsolute = ondeviceorientationabsolute; } // setter
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			DKString _ondevicemotion = "";
			virtual const DKString& ondevicemotion()												{ return _ondevicemotion; }										// getter
			virtual void ondevicemotion(const DKString& ondevicemotion)								{ _ondevicemotion = ondevicemotion; } 							// setter
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			unsigned int _requestIdleCallback = 0;
			virtual const unsigned int& requestIdleCallback(const DKString& callback, const DKString& options = "{}") {
				DKDEBUGFUNC(callback, options);
				DKTODO();
				return _requestIdleCallback;
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			virtual void cancelIdleCallback(const unsigned int& handle) {
				DKDEBUGFUNC(handle);
				DKTODO();
			}
	// };

	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			DKString _getSelection = "";
			virtual const DKString& getSelection() {
				DKDEBUGFUNC();
				DKTODO();
				return _getSelection;
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			DKString _getScreenDetails = "";
			virtual const DKString& getScreenDetails() {
				DKDEBUGFUNC();
				DKTODO();
				return _getScreenDetails;
			}
	// };
};


#endif //DKWindow_H