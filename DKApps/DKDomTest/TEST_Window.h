// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef TEST_Window_H
#define TEST_Window_H

#include "DKWindow/DKWindow.h"


class TEST_Window //: public DKObjectT<TEST_Window>
{
public:
	TEST_Window(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_Window.h //////");
		
		DKWindow* window = new DKWindow();
		window->screen(TEST_Screen::_screen);
		printWindowProperties(window);
	}
	
	static void printWindowProperties(DKWindow* window){
		DKDEBUGFUNC(window);
		
		console.log("window = "						+toString(window));
		
		// the current browsing context
		// [LegacyUnforgeable] readonly attribute WindowProxy window;
		console.log("window->window() = "			+toString(window->window()));
	
		// [Replaceable] readonly attribute WindowProxy self;
		console.log("window->self() = "				+toString(window->self()));
		
		// [LegacyUnforgeable] readonly attribute Document document;
		console.log("window->document() = "			+toString(window->document()));
		
		// attribute DOMString name;
		console.log("window->name() = "				+toString(window->name()));
		
		// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
		console.log("window->location() = "			+toString(window->location()));

		// readonly attribute History history;
		console.log("window->history() = "			+toString(window->history()));
		
		// readonly attribute CustomElementRegistry customElements;
		console.log("window->customElements() = "	+toString(window->customElements()));
		
		// [Replaceable] readonly attribute BarProp locationbar;
		console.log("window->locationbar() = "		+toString(window->locationbar()));
		
		// [Replaceable] readonly attribute BarProp menubar;
		console.log("window->menubar() = "			+toString(window->menubar()));
		
		// [Replaceable] readonly attribute BarProp personalbar;
		console.log("window->personalbar() = "		+toString(window->personalbar()));
		
		// [Replaceable] readonly attribute BarProp scrollbars;
		console.log("window->scrollbars() = "		+toString(window->scrollbars()));
		
		// [Replaceable] readonly attribute BarProp statusbar;
		console.log("window->statusbar() = "		+toString(window->statusbar()));
		
		// [Replaceable] readonly attribute BarProp toolbar;
		console.log("window->toolbar() = "			+toString(window->toolbar()));
		
		// attribute DOMString status;
		console.log("window->status() = "			+toString(window->status()));
		
		// undefined close();
		// function
		
		// readonly attribute boolean closed;
		console.log("window->closed() = "			+toString(window->closed()));
		
		// undefined stop();
		// function
		
		// undefined focus();
		// function
		
		// undefined blur();
		// function
		
		// other browsing contexts
		// [Replaceable] readonly attribute WindowProxy frames;
		console.log("window->frames() = "			+toString(window->frames()));
	
		// [Replaceable] readonly attribute unsigned long length;
		console.log("window->length() = "			+toString(window->length()));
		
		// [LegacyUnforgeable] readonly attribute WindowProxy? top;
		console.log("window->top() = "				+toString(window->top()));
		
		// attribute any opener;
		console.log("window->opener() = "			+toString(window->opener()));
		
		// [Replaceable] readonly attribute WindowProxy? parent;
		console.log("window->parent() = "			+toString(window->parent()));
		
		// readonly attribute Element? frameElement;
		console.log("window->frameElement() = "		+toString(window->frameElement()));
		
		// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
		// function
		
		//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
		//object on the prototype chain. Indeed, this does not make the global object an exotic object.
		//Indexed access is taken care of by the WindowProxy exotic object.
		// getter object (DOMString name);
		// TODO
		
		// the user agent
		// readonly attribute Navigator navigator;
		console.log("window->navigator() = "		+toString(window->navigator()));
		
		// readonly attribute Navigator clientInformation; // legacy alias of .navigator
		console.log("window->clientInformation() = "+toString(window->clientInformation()));
		
		// readonly attribute boolean originAgentCluster;
		console.log("window->originAgentCluster() = "+toString(window->originAgentCluster()));
		
		//user prompts
		// undefined alert();
		// function
		
		// undefined alert(DOMString message);
		// function
		
		// boolean confirm(optional DOMString message = "");
		// function
		
		// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
		// function
		
		// undefined print();
		// function
		
		// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
		// function
		
		// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
		// function
		
		// also has obsolete members
		// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
		// partial interface Window {
		//		readonly attribute short orientation;
				console.log("window->orientation() = "			+toString(window->orientation()));
		//		
		//		attribute EventHandler onorientationchange;
				console.log("window->onorientationchange() = "	+toString(window->onorientationchange()));
		// };
		
		// Source: DOM Standard (https://dom.spec.whatwg.org/)
		// partial interface Window {
		//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
				console.log("window->event() = "				+toString(window->event()));
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
				// function
		//
		//		undefined releaseEvents();
				// function
		//
		//		[Replaceable, SameObject] readonly attribute External external;
				// function 
		// };
		
		// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
		// [SecureContext]
		// partial interface Window {
		//		[SameObject] readonly attribute CookieStore cookieStore;
				console.log("window->cookieStore() = "		+toString(window->cookieStore()));
		// };

		// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
		// partial interface Window {
		//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
				// function
		// };

		// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
		// partial interface Window {
		//		// Collection of fenced frame APIs
		//		readonly attribute Fence? fence;
				console.log("window->fence() = "			+toString(window->fence()));
		// };
	
		// Source: File System Access (https://wicg.github.io/file-system-access/)
		// [SecureContext]
		// partial interface Window {
		//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
				// function
		//
		//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
				// function
		//
		//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
				// function
		// };
		
		// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
		// [SecureContext]
		// partial interface Window {
		//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
				// function
		// };
	
		// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
		// partial interface Window {
		//		attribute EventHandler onappinstalled;
				console.log("window->onappinstalled() = "		+toString(window->onappinstalled()));
		
		//		attribute EventHandler onbeforeinstallprompt;
				console.log("window->onbeforeinstallprompt() = "+toString(window->onbeforeinstallprompt()));
		// };

		// Source: Portals (https://wicg.github.io/portals/)
		// partial interface Window {
		//		readonly attribute PortalHost? portalHost;
				console.log("window->portalHost() = "			+toString(window->portalHost()));
		// };
	
		// Source: Web Speech API (https://wicg.github.io/speech-api/)
		// partial interface Window {
		//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
				console.log("window->speechSynthesis() = "		+toString(window->speechSynthesis()));
		// };
		
		// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
		// partial interface Window {
		//		readonly attribute LaunchQueue launchQueue;
				console.log("window->launchQueue() = "			+toString(window->launchQueue()));
		// };
		
		// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
		// partial interface Window {
		//		undefined navigate(SpatialNavigationDirection dir);
				// function
		// };
		
		// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
		// partial interface Window {
		//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
				// function
		// };
		
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface Window {
		//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
				// function
		//
		//		[SameObject, Replaceable] readonly attribute Screen screen;
				console.log("window->screen() = "				+toString(window->screen()));
				//if(*window->screen())
				//	TEST_Screen::printScreenProperties(*window->screen());
				
		//
		//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
				console.log("window->visualViewport() = "		+toString(window->visualViewport()));
		//
		//		// browsing context
		//		undefined moveTo(long x, long y);
				// function
		//
		//		undefined moveBy(long x, long y);
				// function
		//
		//		undefined resizeTo(long width, long height);
				// function
		//
		//		undefined resizeBy(long x, long y);
				// function
		//
		//		// viewport
		//		[Replaceable] readonly attribute long innerWidth;
				console.log("window->innerWidth() = "			+toString(window->innerWidth()));
		//
		//		[Replaceable] readonly attribute long innerHeight;
				console.log("window->innerHeight() = "			+toString(window->innerHeight()));
		//
		//		// viewport scrolling
		//		[Replaceable] readonly attribute double scrollX;
				console.log("window->scrollX() = "				+toString(window->scrollX()));
		//
		//		[Replaceable] readonly attribute double pageXOffset;
				console.log("window->pageXOffset() = "			+toString(window->pageXOffset()));
		//
		//		[Replaceable] readonly attribute double scrollY;
				console.log("window->scrollY() = "				+toString(window->scrollY()));
		//
		//		[Replaceable] readonly attribute double pageYOffset;
				console.log("window->pageYOffset() = "			+toString(window->pageYOffset()));
		//
		//		undefined scroll(optional ScrollToOptions options = {});
		//		undefined scroll(unrestricted double x, unrestricted double y);
				// function
		//
		//		undefined scrollTo(optional ScrollToOptions options = {});
		//		undefined scrollTo(unrestricted double x, unrestricted double y);
				// function
		//
		//		undefined scrollBy(optional ScrollToOptions options = {});
		//		undefined scrollBy(unrestricted double x, unrestricted double y);
				// function
		///
		//		// client
		//		[Replaceable] readonly attribute long screenX;
				console.log("window->screenX() = "				+toString(window->screenX()));
		//
		//		[Replaceable] readonly attribute long screenLeft;
				console.log("window->screenLeft() = "			+toString(window->screenLeft()));
		//
		//		[Replaceable] readonly attribute long screenY;
				console.log("window->screenY() = "				+toString(window->screenY()));
		//
		//		[Replaceable] readonly attribute long screenTop;
				console.log("window->screenTop() = "			+toString(window->screenTop()));
		//
		//		[Replaceable] readonly attribute long outerWidth;
				console.log("window->outerWidth() = "			+toString(window->outerWidth()));
		//
		//		[Replaceable] readonly attribute long outerHeight;
				console.log("window->outerHeight() = "			+toString(window->outerHeight()));
		//
		//		[Replaceable] readonly attribute double devicePixelRatio;
				console.log("window->devicePixelRatio() = "		+toString(window->devicePixelRatio()));
		// };
		
		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		// partial interface Window {
		//		[SecureContext] attribute EventHandler ondeviceorientation;
				console.log("window->ondeviceorientation() = "	+toString(window->ondeviceorientation()));
		// };

		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		// partial interface Window {
		//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
				console.log("window->ondeviceorientationabsolute() = "+toString(window->ondeviceorientationabsolute()));
		// };

		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		//	partial interface Window {
		//		[SecureContext] attribute EventHandler ondevicemotion;
				console.log("window->ondevicemotion() = "		+toString(window->ondevicemotion()));
		// };
	
		// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
		// partial interface Window {
		//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
				// function
		//
		//		undefined cancelIdleCallback(unsigned long handle);
				// function
		// };
	
		// Source: Selection API (https://www.w3.org/TR/selection-api/)
		// partial interface Window {
		//		Selection? getSelection();
				// function
		// };
		
		// Source: Window Management (https://www.w3.org/TR/window-management/)
		// partial interface Window {
		//		[SecureContext]
		//		Promise<ScreenDetails> getScreenDetails();
				// function
		// };
		
		TEST_EventTarget::printEventTargetProperties(window);
	}

};
//REGISTER_OBJECT(TEST_Window, true);


#endif //TEST_Window_H