// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#pragma once
#ifndef TEST_Window_H
#define TEST_Window_H

#include "DKWindow/DKWindow.h"


class TEST_Window : public DKObjectT<TEST_Window>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Window.h //////\n");
		
		DKWindow window;
		printWindowProperties(window);
		return true;
	}
	
	static void printWindowProperties(DKWindow& window){
		DKDEBUGFUNC(window);
		
		// the current browsing context
		// [LegacyUnforgeable] readonly attribute WindowProxy window;
		DKINFO("window.window() = "				+toString(window.window())				+"\n");
	
		// [Replaceable] readonly attribute WindowProxy self;
		DKINFO("window.self() = "				+toString(window.self())				+"\n");
		
		// [LegacyUnforgeable] readonly attribute Document document;
		DKINFO("window.document() = "			+toString(window.document())			+"\n");
		
		// attribute DOMString name;
		DKINFO("window.name() = "				+toString(window.name())				+"\n");
		
		// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
		DKINFO("window.location() = "			+toString(window.location())			+"\n");

		// readonly attribute History history;
		DKINFO("window.history() = "			+toString(window.history())				+"\n");
		
		// readonly attribute CustomElementRegistry customElements;
		DKINFO("window.customElements() = "		+toString(window.customElements())		+"\n");
		
		// [Replaceable] readonly attribute BarProp locationbar;
		DKINFO("window.locationbar() = "		+toString(window.locationbar())			+"\n");
		
		// [Replaceable] readonly attribute BarProp menubar;
		DKINFO("window.menubar() = "			+toString(window.menubar())				+"\n");
		
		// [Replaceable] readonly attribute BarProp personalbar;
		DKINFO("window.personalbar() = "		+toString(window.personalbar())			+"\n");
		
		// [Replaceable] readonly attribute BarProp scrollbars;
		DKINFO("window.scrollbars() = "			+toString(window.scrollbars())			+"\n");
		
		// [Replaceable] readonly attribute BarProp statusbar;
		DKINFO("window.statusbar() = "			+toString(window.statusbar())			+"\n");
		
		// [Replaceable] readonly attribute BarProp toolbar;
		DKINFO("window.toolbar() = "			+toString(window.toolbar())				+"\n");
		
		// attribute DOMString status;
		DKINFO("window.status() = "				+toString(window.status())				+"\n");
		
		// undefined close();
		// function
		
		// readonly attribute boolean closed;
		DKINFO("window.closed() = "				+toString(window.closed())				+"\n");
		
		// undefined stop();
		// function
		
		// undefined focus();
		// function
		
		// undefined blur();
		// function
		
		// other browsing contexts
		// [Replaceable] readonly attribute WindowProxy frames;
		DKINFO("window.frames() = "				+toString(window.frames())				+"\n");
		
		// [Replaceable] readonly attribute unsigned long length;
		DKINFO("window.length() = "				+toString(window.length())				+"\n");
		
		// [LegacyUnforgeable] readonly attribute WindowProxy? top;
		DKINFO("window.top() = "				+toString(window.top())					+"\n");
		
		// attribute any opener;
		DKINFO("window.opener() = "				+toString(window.opener())				+"\n");
		
		// [Replaceable] readonly attribute WindowProxy? parent;
		DKINFO("window.parent() = "				+toString(window.parent())				+"\n");
		
		// readonly attribute Element? frameElement;
		DKINFO("window.frameElement() = "		+toString(window.frameElement())		+"\n");
		
		// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
		// function
		
		//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
		//object on the prototype chain. Indeed, this does not make the global object an exotic object.
		//Indexed access is taken care of by the WindowProxy exotic object.
		// getter object (DOMString name);
		
		// the user agent
		// readonly attribute Navigator navigator;
		DKINFO("window.navigator() = "			+toString(window.navigator())			+"\n");
		
		// readonly attribute Navigator clientInformation; // legacy alias of .navigator
		DKINFO("window.clientInformation() = "	+toString(window.clientInformation())	+"\n");
		
		// readonly attribute boolean originAgentCluster;
		DKINFO("window.originAgentCluster() = "	+toString(window.originAgentCluster())	+"\n");
		
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
				DKINFO("window.orientation() = "			+toString(window.orientation())			+"\n");
		//		
		//		attribute EventHandler onorientationchange;
				DKINFO("window.onorientationchange() = "	+toString(window.onorientationchange())	+"\n");
		// };
		
		// Source: DOM Standard (https://dom.spec.whatwg.org/)
		// partial interface Window {
		//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
				DKINFO("window.event() = "					+toString(window.event())				+"\n");
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
		//		attribute EventHandler onbeforeinstallprompt;
		// };

		// Source: Portals (https://wicg.github.io/portals/)
		// partial interface Window {
		//		readonly attribute PortalHost? portalHost;
		// };
	
		// Source: Web Speech API (https://wicg.github.io/speech-api/)
		// partial interface Window {
		//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
				DKINFO("window.speechSynthesis() = "	+toString(window.speechSynthesis())		+"\n");
		// };
		
		// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
		// partial interface Window {
		//		readonly attribute LaunchQueue launchQueue;
				DKINFO("window.launchQueue() = "		+toString(window.launchQueue())			+"\n");
		// };
		
		// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
		// partial interface Window {
		//		undefined navigate(SpatialNavigationDirection dir);
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
				DKINFO("window.screen() = "				+toString(window.screen())				+"\n");
		//
		//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
				DKINFO("window.visualViewport() = "		+toString(window.visualViewport())		+"\n");
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
				DKINFO("window.innerWidth() = "			+toString(window.innerWidth())			+"\n");
		//
		//		[Replaceable] readonly attribute long innerHeight;
				DKINFO("window.innerHeight() = "		+toString(window.innerHeight())			+"\n");
		//
		//		// viewport scrolling
		//		[Replaceable] readonly attribute double scrollX;
				DKINFO("window.scrollX() = "			+toString(window.scrollX())				+"\n");
		//
		//		[Replaceable] readonly attribute double pageXOffset;
				DKINFO("window.pageXOffset() = "		+toString(window.pageXOffset())			+"\n");
		//
		//		[Replaceable] readonly attribute double scrollY;
				DKINFO("window.scrollY() = "			+toString(window.scrollY())				+"\n");
		//
		//		[Replaceable] readonly attribute double pageYOffset;
				DKINFO("window.pageYOffset() = "		+toString(window.pageYOffset())			+"\n");
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
				DKINFO("window.screenX() = "			+toString(window.screenX())				+"\n");
		//
		//		[Replaceable] readonly attribute long screenLeft;
				DKINFO("window.screenLeft() = "			+toString(window.screenLeft())			+"\n");
		//
		//		[Replaceable] readonly attribute long screenY;
				DKINFO("window.screenY() = "			+toString(window.screenY())				+"\n");
		//
		//		[Replaceable] readonly attribute long screenTop;
				DKINFO("window.screenTop() = "			+toString(window.screenTop())			+"\n");
		//
		//		[Replaceable] readonly attribute long outerWidth;
				DKINFO("window.outerWidth() = "			+toString(window.outerWidth())			+"\n");
		//
		//		[Replaceable] readonly attribute long outerHeight;
				DKINFO("window.outerHeight() = "		+toString(window.outerHeight())			+"\n");
		//
		//		[Replaceable] readonly attribute double devicePixelRatio;
				DKINFO("window.devicePixelRatio() = "	+toString(window.devicePixelRatio())	+"\n");
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
		
		TEST_EventTarget::printEventTargetProperties(dynamic_cast<DKEventTarget&>(window));	//TODO: try to remove the need for dynamic_cast
	}

};
REGISTER_OBJECT(TEST_Window, true);


#endif //TEST_Window_H