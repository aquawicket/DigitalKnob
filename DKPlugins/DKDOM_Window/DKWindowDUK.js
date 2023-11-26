// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
var Window = function Window(address) {
	console.log("Window("+address+")");
	
	if(address)
		this.address = address;
	if(!this.address)
		this.address = CPP_DKWindowDUK_constructor();

	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	Object.defineProperty(this, "window", {
        get: function window()					{ return new Window(CPP_DKWindowDUK_window(this.address)) },
		//set: function window(data)			{ return CPP_DKWindowDUK_window(this.address, data) },
    })
	
	// [Replaceable] readonly attribute WindowProxy self;
	Object.defineProperty(this, "self", {
        get: function self()					{ return new Window(CPP_DKWindowDUK_self(this.address)) },
		//set: function self(data)				{ return CPP_DKWindowDUK_self(this.address, data) },
    })
	
	// [LegacyUnforgeable] readonly attribute Document document;
	Object.defineProperty(this, "document", {
        get: function document()				{ return new Document(CPP_DKWindowDUK_document(this.address)) },
		//set: function document(data)			{ return CPP_DKWindowDUK_document(this.address, data) },
    })
	
	// attribute DOMString name;
	Object.defineProperty(this, "name", {
        get: function name()					{ return CPP_DKWindowDUK_name(this.address) },
		set: function name(data)				{ return CPP_DKWindowDUK_name(this.address, data) },
    })
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	Object.defineProperty(this, "location", {
        get: function location()				{ return new Location(CPP_DKWindowDUK_location(this.address)) },
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
	
	// undefined close();
	Window.prototype.close = function close() {
		CPP_DKWindowDUK_close(this.address)
    }
	
	// readonly attribute boolean closed;
	Object.defineProperty(this, "closed", {
        get: function closed()					{ return CPP_DKWindowDUK_closed(this.address) },
		//set: function closed(data)			{ return CPP_DKWindowDUK_closed(this.address, data) },
    })
	
	// undefined stop();
	Window.prototype.stop = function stop() {
		CPP_DKWindowDUK_stop(this.address)
    }
	
	// undefined focus();
	Window.prototype.focus = function focus() {
		CPP_DKWindowDUK_focus(this.address)
    }
	
	// undefined blur();
	Window.prototype.blur = function blur() {
		CPP_DKWindowDUK_blur(this.address)
    }
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	Object.defineProperty(this, "frames", {
        get: function frames()					{ return new Window(CPP_DKWindowDUK_frames(this.address)) },
		//set: function frames(data)			{ return CPP_DKWindowDUK_frames(this.address, data) },
    })
	
	// [Replaceable] readonly attribute unsigned long length;
	Object.defineProperty(this, "length", {
        get: function length()					{ return CPP_DKWindowDUK_length(this.address) },
		//set: function length(data)			{ return CPP_DKWindowDUK_length(this.address, data) },
    })
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	Object.defineProperty(this, "top", {
        get: function top()						{ return new Window(CPP_DKWindowDUK_top(this.address)) },
		//set: function top(data)				{ return CPP_DKWindowDUK_top(this.address, data) },
    })
	
	// attribute any opener;
	Object.defineProperty(this, "opener", {
        get: function opener()					{ return CPP_DKWindowDUK_opener(this.address) },
		set: function opener(data)				{ return CPP_DKWindowDUK_opener(this.address, data) },
    })
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	Object.defineProperty(this, "parent", {
        get: function parent()					{ return new Window(CPP_DKWindowDUK_parent(this.address)) },
		//set: function parent(data)			{ return CPP_DKWindowDUK_parent(this.address, data) },
    })
	
	// readonly attribute Element? frameElement;
	Object.defineProperty(this, "frameElement", {
        get: function frameElement()			{ return new Element(CPP_DKWindowDUK_frameElement(this.address)) },
		//set: function frameElement(data)		{ return CPP_DKWindowDUK_frameElement(this.address, data) },
    })
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	Window.prototype.open = function open(url, target, features) {
		return new Window(CPP_DKWindowDUK_open(this.address, url, target, features));
    }
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	Object.defineProperty(this, "navigator", {
        get: function navigator()				{ return new Navigator(CPP_DKWindowDUK_navigator(this.address)) },
		//set: function navigator(data)			{ return CPP_DKWindowDUK_navigator(this.address, data) },
    })
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	Object.defineProperty(this, "clientInformation", {
        get: function clientInformation()		{ return new Navigator(CPP_DKWindowDUK_clientInformation(this.address)) },
		//set: function clientInformation(data)	{ return CPP_DKWindowDUK_clientInformation(this.address, data) },
    })
	
	// readonly attribute boolean originAgentCluster;
	Object.defineProperty(this, "originAgentCluster", {
        get: function originAgentCluster()		{ return CPP_DKWindowDUK_originAgentCluster(this.address) },
		//set: function originAgentCluster(data){ return CPP_DKWindowDUK_originAgentCluster(this.address, data) },
    })
	
	//user prompts
	// undefined alert();
	Window.prototype.alert = function alert() {
		CPP_DKWindowDUK_alert(this.address);
    }
	
	// undefined alert(DOMString message);
	Window.prototype.alert = function alert(message) {
		CPP_DKWindowDUK_alert(this.address, message);
    }
		
	// boolean confirm(optional DOMString message = "");
	Window.prototype.confirm = function confirm(message) {
		return CPP_DKWindowDUK_confirm(this.address, message);
    }
		
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	Window.prototype.prompt = function prompt(message, _default) {
		return CPP_DKWindowDUK_prompt(this.address, message, _default);
    }
		
	// undefined print();
	Window.prototype.print = function print() {
		CPP_DKWindowDUK_print(this.address);
    }
		
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	Window.prototype.postMessage = function postMessage(message, targetOrigin, transfer) {
		CPP_DKWindowDUK_print(this.address, message, targetOrigin, transfer);
    }
	
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	Window.prototype.postMessage = function postMessage(message, options) {
		CPP_DKWindowDUK_print(this.address, message, options);
    }
	
	// also has obsolete members
		
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			Object.defineProperty(this, "orientation", {
				get: function orientation()					{ return CPP_DKWindowDUK_orientation(this.address) },
				//set: function orientation(data)			{ return CPP_DKWindowDUK_orientation(this.address, data) },
			})
	//		
	//		attribute EventHandler onorientationchange;
			Object.defineProperty(this, "onorientationchange", {
				get: function onorientationchange()			{ return CPP_DKWindowDUK_onorientationchange(this.address) },
				set: function onorientationchange(data)		{ return CPP_DKWindowDUK_onorientationchange(this.address, data) },
			})
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			Object.defineProperty(this, "event", {
				get: function event()					{ return new Event("", "", CPP_DKWindowDUK_event(this.address)) },
				//set: function event(data)				{ return CPP_DKWindowDUK_event(this.address, data) },
			})
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
			Window.prototype.captureEvents = function captureEvents() {
				CPP_DKWindowDUK_captureEvents(this.address);
			}
	//
	//		undefined releaseEvents();
			Window.prototype.releaseEvents = function releaseEvents() {
				CPP_DKWindowDUK_releaseEvents(this.address);
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			Object.defineProperty(this, "external", {
				get: function external()				{ return CPP_DKWindowDUK_external(this.address) },
				//set: function external(data)			{ return CPP_DKWindowDUK_external(this.address, data) },
			})
	// };
		
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			Object.defineProperty(this, "cookieStore", {
				get: function cookieStore()				{ return CPP_DKWindowDUK_cookieStore(this.address) },
				//set: function cookieStore(data)		{ return CPP_DKWindowDUK_cookieStore(this.address, data) },
			})
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			Window.prototype.getDigitalGoodsService = function getDigitalGoodsService(serviceProvider) {
				return CPP_DKWindowDUK_getDigitalGoodsService(this.address, serviceProvider);
			}
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			Object.defineProperty(this, "fence", {
				get: function fence()					{ return CPP_DKWindowDUK_fence(this.address) },
				//set: function fence(data)				{ return CPP_DKWindowDUK_fence(this.address, data) },
			})
	// };	
		
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			Window.prototype.showOpenFilePicker = function showOpenFilePicker(options) {
				return CPP_DKWindowDUK_showOpenFilePicker(this.address, options);
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			Window.prototype.showSaveFilePicker = function showSaveFilePicker(options) {
				return CPP_DKWindowDUK_showSaveFilePicker(this.address, options);
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			Window.prototype.showDirectoryPicker = function showDirectoryPicker(options) {
				return CPP_DKWindowDUK_showDirectoryPicker(this.address, options);
			}
	// };
		
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			Window.prototype.queryLocalFonts = function queryLocalFonts(options) {
				return CPP_DKWindowDUK_queryLocalFonts(this.address, options);
			}
	// };	
		
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			Object.defineProperty(this, "onappinstalled", {
				get: function onappinstalled()				{ return CPP_DKWindowDUK_onappinstalled(this.address) },
				set: function onappinstalled(data)			{ return CPP_DKWindowDUK_onappinstalled(this.address, data) },
			})
	//
	//		attribute EventHandler onbeforeinstallprompt;
			Object.defineProperty(this, "onbeforeinstallprompt", {
				get: function onbeforeinstallprompt()		{ return CPP_DKWindowDUK_onbeforeinstallprompt(this.address) },
				set: function onbeforeinstallprompt(data)	{ return CPP_DKWindowDUK_onbeforeinstallprompt(this.address, data) },
			})
	// };
		
	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			Object.defineProperty(this, "portalHost", {
				get: function portalHost()					{ return CPP_DKWindowDUK_portalHost(this.address) },
				//set: function portalHost(data)			{ return CPP_DKWindowDUK_portalHost(this.address, data) },
			})
	// };	
		
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			Object.defineProperty(this, "speechSynthesis", {
				get: function speechSynthesis()			{ return CPP_DKWindowDUK_speechSynthesis(this.address) },
				//set: function speechSynthesis(data)	{ return CPP_DKWindowDUK_speechSynthesis(this.address, data) },
			})
	// };
		
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			Object.defineProperty(this, "launchQueue", {
				get: function launchQueue()				{ return CPP_DKWindowDUK_launchQueue(this.address) },
				//set: function launchQueue(data)		{ return CPP_DKWindowDUK_launchQueue(this.address, data) },
			})
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			Window.prototype.navigate = function navigate(dir) {
				return CPP_DKWindowDUK_navigate(this.address, dir);
			}
	// };

	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			Window.prototype.getComputedStyle = function getComputedStyle(elt, pseudoElt) {
				return new CSSStyleDeclaration(CPP_DKWindowDUK_getComputedStyle(this.address, elt, pseudoElt));
			}
	// };
		
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			Window.prototype.matchMedia = function matchMedia(query) {
				return CPP_DKWindowDUK_matchMedia(this.address, query);
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			Object.defineProperty(this, "screen", {
				get: function screen()					{ return new Screen(CPP_DKWindowDUK_screen(this.address)) },
				//set: function screen(data)			{ return CPP_DKWindowDUK_screen(this.address, data) },
			})
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			Object.defineProperty(this, "visualViewport", {
				get: function visualViewport()			{ return CPP_DKWindowDUK_visualViewport(this.address) },
				//set: function visualViewport(data)	{ return CPP_DKWindowDUK_visualViewport(this.address, data) },
			})
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			Window.prototype.moveTo = function moveTo(x, y) {
				CPP_DKWindowDUK_moveTo(this.address, x, y);
			}
	//
	//		undefined moveBy(long x, long y);
			Window.prototype.moveBy = function moveBy(deltaX, deltaY) {
				CPP_DKWindowDUK_moveBy(this.address, deltaX, deltaY);
			}
	//
	//		undefined resizeTo(long width, long height);
			Window.prototype.resizeTo = function resizeTo(width, height) {
				CPP_DKWindowDUK_resizeTo(this.address, width, height);
			}
	//
	//		undefined resizeBy(long x, long y);
			Window.prototype.resizeBy = function resizeBy(x, y) {
				CPP_DKWindowDUK_resizeBy(this.address, x, y);
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			Object.defineProperty(this, "innerWidth", {
				get: function innerWidth()				{ return CPP_DKWindowDUK_innerWidth(this.address) },
				//set: function innerWidth(data)		{ return CPP_DKWindowDUK_innerWidth(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long innerHeight;
			Object.defineProperty(this, "innerHeight", {
				get: function innerHeight()				{ return CPP_DKWindowDUK_innerHeight(this.address) },
				//set: function innerHeight(data)		{ return CPP_DKWindowDUK_innerHeight(this.address, data) },
			})
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			Object.defineProperty(this, "scrollX", {
				get: function scrollX()					{ return CPP_DKWindowDUK_scrollX(this.address) },
				//set: function scrollX(data)			{ return CPP_DKWindowDUK_scrollX(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			Object.defineProperty(this, "pageXOffset", {
				get: function pageXOffset()				{ return CPP_DKWindowDUK_pageXOffset(this.address) },
				//set: function pageXOffset(data)		{ return CPP_DKWindowDUK_pageXOffset(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute double scrollY;
			Object.defineProperty(this, "scrollY", {
				get: function scrollY()					{ return CPP_DKWindowDUK_scrollY(this.address) },
				//set: function scrollY(data)			{ return CPP_DKWindowDUK_scrollY(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			Object.defineProperty(this, "pageYOffset", {
				get: function pageYOffset()				{ return CPP_DKWindowDUK_pageYOffset(this.address) },
				//set: function pageYOffset(data)		{ return CPP_DKWindowDUK_pageYOffset(this.address, data) },
			})
	//
	//		undefined scroll(optional ScrollToOptions options = {});
			Window.prototype.scroll = function scroll(options) {
				CPP_DKWindowDUK_scroll(this.address, options);
			}
	//		
	//		undefined scroll(unrestricted double x, unrestricted double y);
			Window.prototype.scroll = function scroll(x, y) {
				CPP_DKWindowDUK_scroll(this.address, x, y);
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
			Window.prototype.scrollTo = function scrollTo(options) {
				CPP_DKWindowDUK_scrollTo(this.address, options);
			}
	//
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			Window.prototype.scrollTo = function scrollTo(x, y) {
				CPP_DKWindowDUK_scrollTo(this.address, x, y);
			}
			
	//		undefined scrollBy(optional ScrollToOptions options = {});
			Window.prototype.scrollBy = function scrollBy(options) {
				CPP_DKWindowDUK_scrollBy(this.address, options);
			}
	//
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			Window.prototype.scrollBy = function scrollBy(x, y) {
				CPP_DKWindowDUK_scrollBy(this.address, x, y);
			}
	//
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			Object.defineProperty(this, "screenX", {
				get: function screenX()							{ return CPP_DKWindowDUK_screenX(this.address) },
				//set: function screenX(data)					{ return CPP_DKWindowDUK_screenX(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long screenLeft;
			Object.defineProperty(this, "screenLeft", {
				get: function screenLeft()						{ return CPP_DKWindowDUK_screenLeft(this.address) },
				//set: function screenLeft(data)				{ return CPP_DKWindowDUK_screenLeft(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long screenY;
			Object.defineProperty(this, "screenY", {
				get: function screenY()							{ return CPP_DKWindowDUK_screenY(this.address) },
				//set: function screenY(data)					{ return CPP_DKWindowDUK_screenY(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long screenTop;
			Object.defineProperty(this, "screenTop", {
				get: function screenTop()						{ return CPP_DKWindowDUK_screenTop(this.address) },
				//set: function screenTop(data)					{ return CPP_DKWindowDUK_screenTop(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long outerWidth;
			Object.defineProperty(this, "outerWidth", {
				get: function outerWidth()						{ return CPP_DKWindowDUK_outerWidth(this.address) },
				//set: function outerWidth(data)				{ return CPP_DKWindowDUK_outerWidth(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute long outerHeight;
			Object.defineProperty(this, "outerHeight", {
				get: function outerHeight()						{ return CPP_DKWindowDUK_outerHeight(this.address) },
				//set: function outerHeight(data)				{ return CPP_DKWindowDUK_outerHeight(this.address, data) },
			})
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			Object.defineProperty(this, "devicePixelRatio", {
				get: function devicePixelRatio()				{ return CPP_DKWindowDUK_devicePixelRatio(this.address) },
				//set: function devicePixelRatio(data)			{ return CPP_DKWindowDUK_devicePixelRatio(this.address, data) },
			})
	// };
		
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			Object.defineProperty(this, "ondeviceorientation", {
				get: function ondeviceorientation()				{ return CPP_DKWindowDUK_ondeviceorientation(this.address) },
				set: function ondeviceorientation(data)			{ return CPP_DKWindowDUK_ondeviceorientation(this.address, data) },
			})
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			Object.defineProperty(this, "ondeviceorientationabsolute", {
				get: function ondeviceorientationabsolute()		{ return CPP_DKWindowDUK_ondeviceorientationabsolute(this.address) },
				set: function ondeviceorientationabsolute(data)	{ return CPP_DKWindowDUK_ondeviceorientationabsolute(this.address, data) },
			})
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			Object.defineProperty(this, "ondevicemotion", {
				get: function ondevicemotion()					{ return CPP_DKWindowDUK_ondevicemotion(this.address) },
				set: function ondevicemotion(data)				{ return CPP_DKWindowDUK_ondevicemotion(this.address, data) },
			})
	// };

	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			Window.prototype.requestIdleCallback = function requestIdleCallback(callback, options) {
				return CPP_DKWindowDUK_requestIdleCallback(this.address, callback, options);
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			Window.prototype.cancelIdleCallback = function cancelIdleCallback(handle) {
				CPP_DKWindowDUK_cancelIdleCallback(this.address, handle);
			}
	// };
	
	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			Window.prototype.getSelection = function getSelection() {
				return CPP_DKWindowDUK_getSelection(this.address);
			}
	// };

	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			Window.prototype.getScreenDetails = function getScreenDetails() {
				return CPP_DKWindowDUK_getScreenDetails(this.address);
			}
	// };
	
	
	////// toString //////
	if(this.toString() === "[object Object]")
		this.toString = function(){	return "[object Window]" }
	
	
	return EventTarget.call(this, this.address)
}
Window.prototype = EventTarget.prototype
