// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
console.log("\n////// TEST_Window.js //////")


function printWindowProperties(window){
	
	console.log("window = "						+window);
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	console.log("window.window = "				+window.window);
	
	// [Replaceable] readonly attribute WindowProxy self;
	console.log("window.self = "				+window.self);

	// [LegacyUnforgeable] readonly attribute Document document;
	console.log("window.document = "			+window.document);
	
	// attribute DOMString name;
	console.log("window.name = "				+window.name);
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	console.log("window.location = "			+window.location);
	
	// readonly attribute History history;
	console.log("window.history = "				+window.history);
	
	// readonly attribute CustomElementRegistry customElements;
	console.log("window.customElements = "		+window.customElements);
	
	// [Replaceable] readonly attribute BarProp locationbar;
	console.log("window.locationbar = "			+window.locationbar);
	
	// [Replaceable] readonly attribute BarProp menubar;
	console.log("window.menubar = "				+window.menubar);
	
	// [Replaceable] readonly attribute BarProp personalbar;
	console.log("window.personalbar = "			+window.personalbar);
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	console.log("window.scrollbars = "			+window.scrollbars);
	
	// [Replaceable] readonly attribute BarProp statusbar;
	console.log("window.statusbar = "			+window.statusbar);
	
	// [Replaceable] readonly attribute BarProp toolbar;
	console.log("window.toolbar = "				+window.toolbar);
	
	// attribute DOMString status;
	console.log("window.status = "				+window.status);
	
	// undefined close();
	console.log("window.close = "				+window.close);
		
	// readonly attribute boolean closed;
	console.log("window.closed = "				+window.closed);
	
	// undefined stop();
	console.log("window.stop = "				+window.stop);
		
	// undefined focus();
	console.log("window.focus = "				+window.focus);
		
	// undefined blur();
	console.log("window.blur = "				+window.blur);
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	console.log("window.frames = "				+window.frames);
	
	// [Replaceable] readonly attribute unsigned long length;
	console.log("window.length = "				+window.length);
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	console.log("window.top = "					+window.top);
	
	// attribute any opener;
	console.log("window.opener = "				+window.opener);
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	console.log("window.parent = "				+window.parent);
	
	// readonly attribute Element? frameElement;
	console.log("window.frameElement = "		+window.frameElement);
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	console.log("window.open = "				+window.open);
		
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	// TODO
	
	// the user agent
	// readonly attribute Navigator navigator;
	console.log("window.navigator = "			+window.navigator);
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	console.log("window.clientInformation = "	+window.clientInformation);
	
	// readonly attribute boolean originAgentCluster;
	console.log("window.originAgentCluster = "	+window.originAgentCluster)

	//user prompts
	// undefined alert();
	// undefined alert(DOMString message);
	console.log("window.alert = "				+window.alert);
		
	// boolean confirm(optional DOMString message = "");
	console.log("window.confirm = "				+window.confirm);
		
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	console.log("window.prompt = "				+window.prompt);
	
	// undefined print();
	console.log("window.print = "				+window.print);
		
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	console.log("window.postMessage = "			+window.postMessage);
		
	// also has obsolete members
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			console.log("window.orientation = "				+window.orientation);
	//		
	//		attribute EventHandler onorientationchange;
			console.log("window.onorientationchange = "		+window.onorientationchange);
	// };
		
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			console.log("window.event = "					+window.event);
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
			console.log("window.captureEvents = "			+window.captureEvents);
	//
	//		undefined releaseEvents();
			console.log("window.releaseEvents = "			+window.releaseEvents);
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			console.log("window.external = "				+window.external); 
	// };
		
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			console.log("window.cookieStore = "				+window.cookieStore); 
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			console.log("window.getDigitalGoodsService = "	+window.getDigitalGoodsService); 
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			console.log("window.fence = "					+window.fence); 
	// };

	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			console.log("window.showOpenFilePicker = "		+window.showOpenFilePicker); 
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			console.log("window.showSaveFilePicker = "		+window.showSaveFilePicker); 
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			console.log("window.showDirectoryPicker = "		+window.showDirectoryPicker); 
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			console.log("window.queryLocalFonts = "			+window.queryLocalFonts); 
	// };

	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			console.log("window.onappinstalled = "			+window.onappinstalled);
	//
	//		attribute EventHandler onbeforeinstallprompt;
			console.log("window.onbeforeinstallprompt = "	+window.onbeforeinstallprompt);
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			console.log("window.portalHost = "				+window.portalHost);
	// };
	
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			console.log("window.speechSynthesis = "			+window.speechSynthesis);
	// };
		
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			console.log("window.launchQueue = "				+window.launchQueue);
	// };

	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			console.log("window.navigate = "				+window.navigate);
	// };
		
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			console.log("window.getComputedStyle = "		+window.getComputedStyle);
	// };
		
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			console.log("window.matchMedia = "				+window.matchMedia);
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			console.log("window.screen = "					+window.screen);
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			console.log("window.visualViewport = "			+window.visualViewport);
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			console.log("window.moveTo = "					+window.moveTo);
	//
	//		undefined moveBy(long x, long y);
			console.log("window.moveBy = "					+window.moveBy);
	//
	//		undefined resizeTo(long width, long height);
			console.log("window.resizeTo = "				+window.resizeTo);
	//
	//		undefined resizeBy(long x, long y);
			console.log("window.resizeBy = "				+window.resizeBy);
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			console.log("window.innerWidth = "				+window.innerWidth);
	//
	//		[Replaceable] readonly attribute long innerHeight;
			console.log("window.innerHeight = "				+window.innerHeight);
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			console.log("window.scrollX = "					+window.scrollX);
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			console.log("window.pageXOffset = "				+window.pageXOffset);
	//
	//		[Replaceable] readonly attribute double scrollY;
			console.log("window.scrollY = "					+window.scrollY);
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			console.log("window.pageYOffset = "				+window.pageYOffset);
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			console.log("window.scroll = "					+window.scroll);
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			console.log("window.scrollTo = "				+window.scrollTo);
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			console.log("window.scrollBy = "				+window.scrollBy);
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			console.log("window.screenX = "					+window.screenX);
	//
	//		[Replaceable] readonly attribute long screenLeft;
			console.log("window.screenLeft = "				+window.screenLeft);
	//
	//		[Replaceable] readonly attribute long screenY;
			console.log("window.screenY = "					+window.screenY);
	//
	//		[Replaceable] readonly attribute long screenTop;
			console.log("window.screenTop = "				+window.screenTop);
	//
	//		[Replaceable] readonly attribute long outerWidth;
			console.log("window.outerWidth = "				+window.outerWidth);
	//
	//		[Replaceable] readonly attribute long outerHeight;
			console.log("window.outerHeight = "				+window.outerHeight);
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			console.log("window.devicePixelRatio = "		+window.devicePixelRatio)
	// };
		
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			console.log("window.ondeviceorientation = "		+window.ondeviceorientation);
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			console.log("window.ondeviceorientationabsolute = "	+window.ondeviceorientationabsolute);
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			console.log("window.ondevicemotion = "			+window.ondevicemotion);
	// };
	
	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			console.log("window.requestIdleCallback = "		+window.requestIdleCallback);
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			console.log("window.cancelIdleCallback = "		+window.cancelIdleCallback);
	// };
	
	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			console.log("window.getSelection = "			+window.getSelection);
	// };
		
	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			console.log("window.getScreenDetails = "		+window.getScreenDetails);
	// };
		
	
	printEventTargetProperties(window);
}


var window = new Window();
printWindowProperties(window);