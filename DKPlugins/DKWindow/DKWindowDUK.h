// [IDL] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#if HAVE_DKDuktape

#pragma once
#ifndef DKWindowDUK_H
#define DKWindowDUK_H

#include "DKDuktape/DKDuktape.h"
#include "DKWindow/DKWindow.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
class DKWindowDUK : public DKObjectT<DKWindowDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKWindowDUK_constructor", 		DKWindowDUK::constructor);
		
		// the current browsing context
		// [LegacyUnforgeable] readonly attribute WindowProxy window;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_window", 			DKWindowDUK::window);
	
		// [Replaceable] readonly attribute WindowProxy self;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_self", 				DKWindowDUK::self);
		
		// [LegacyUnforgeable] readonly attribute Document document;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_document", 			DKWindowDUK::document);
		
		// attribute DOMString name;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_name", 				DKWindowDUK::name);
		
		// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_location", 			DKWindowDUK::location);
		
		// readonly attribute History history;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_history", 			DKWindowDUK::history);
		
		// readonly attribute CustomElementRegistry customElements;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_customElements", 	DKWindowDUK::customElements);
		
		// [Replaceable] readonly attribute BarProp locationbar;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_locationbar", 		DKWindowDUK::locationbar);
		
		// [Replaceable] readonly attribute BarProp menubar;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_menubar", 			DKWindowDUK::menubar);
		
		// [Replaceable] readonly attribute BarProp personalbar;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_personalbar", 		DKWindowDUK::personalbar);
		
		// [Replaceable] readonly attribute BarProp scrollbars;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollbars", 		DKWindowDUK::scrollbars);
		
		// [Replaceable] readonly attribute BarProp statusbar;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_statusbar", 			DKWindowDUK::statusbar);
		
		// [Replaceable] readonly attribute BarProp toolbar;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_toolbar", 			DKWindowDUK::toolbar);
		
		// attribute DOMString status;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_status", 			DKWindowDUK::status);
		
		// undefined close();
		DKDuktape::AttachFunction("CPP_DKWindowDUK_close", 				DKWindowDUK::close);
		
		// readonly attribute boolean closed;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_closed", 			DKWindowDUK::closed);
		
		// undefined stop();
		DKDuktape::AttachFunction("CPP_DKWindowDUK_stop", 				DKWindowDUK::stop);
		
		// undefined focus();
		DKDuktape::AttachFunction("CPP_DKWindowDUK_focus", 				DKWindowDUK::focus);
		
		// undefined blur();
		DKDuktape::AttachFunction("CPP_DKWindowDUK_blur", 				DKWindowDUK::blur);
		
		// other browsing contexts
		// [Replaceable] readonly attribute WindowProxy frames;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_frames", 			DKWindowDUK::frames);
		
		// [Replaceable] readonly attribute unsigned long length;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_length", 			DKWindowDUK::length);
		
		// [LegacyUnforgeable] readonly attribute WindowProxy? top;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_top", 				DKWindowDUK::top);
		
		// attribute any opener;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_opener", 			DKWindowDUK::opener);
		
		// [Replaceable] readonly attribute WindowProxy? parent;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_parent", 			DKWindowDUK::parent);
		
		// readonly attribute Element? frameElement;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_frameElement", 		DKWindowDUK::frameElement);
		
		// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
		DKDuktape::AttachFunction("CPP_DKWindowDUK_open", 				DKWindowDUK::open); // TODO
		
		//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
		//object on the prototype chain. Indeed, this does not make the global object an exotic object.
		//Indexed access is taken care of by the WindowProxy exotic object.
		// getter object (DOMString name);
		// TODO
	
		// the user agent
		// readonly attribute Navigator navigator;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_navigator", 			DKWindowDUK::navigator);
	
		// readonly attribute Navigator clientInformation; // legacy alias of .navigator
		DKDuktape::AttachFunction("CPP_DKWindowDUK_clientInformation", 	DKWindowDUK::clientInformation);
		
		// readonly attribute boolean originAgentCluster;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_originAgentCluster", DKWindowDUK::originAgentCluster);
		
		//user prompts
		// undefined alert();
		// undefined alert(DOMString message);
		DKDuktape::AttachFunction("CPP_DKWindowDUK_alert", 				DKWindowDUK::alert);
		
		// boolean confirm(optional DOMString message = "");
		DKDuktape::AttachFunction("CPP_DKWindowDUK_confirm", 			DKWindowDUK::confirm);
		
		// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
		DKDuktape::AttachFunction("CPP_DKWindowDUK_prompt", 			DKWindowDUK::prompt);
		
		// undefined print();
		DKDuktape::AttachFunction("CPP_DKWindowDUK_print", 				DKWindowDUK::print);
		
		// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
		// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
		DKDuktape::AttachFunction("CPP_DKWindowDUK_postMessage", 		DKWindowDUK::postMessage);
	
		// also has obsolete members
		
		// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
		// partial interface Window {
		//		readonly attribute short orientation;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_orientation", 				DKWindowDUK::orientation);
		//		
		//		attribute EventHandler onorientationchange;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_onorientationchange",		DKWindowDUK::onorientationchange);
		// };
		
		// Source: DOM Standard (https://dom.spec.whatwg.org/)
		// partial interface Window {
		//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
				DKDuktape::AttachFunction("CPP_DKWindowDUK_event", 						DKWindowDUK::event);
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
				DKDuktape::AttachFunction("CPP_DKWindowDUK_captureEvents", 				DKWindowDUK::captureEvents);
		//
		//		undefined releaseEvents();
				DKDuktape::AttachFunction("CPP_DKWindowDUK_releaseEvents", 				DKWindowDUK::releaseEvents);
		//
		//		[Replaceable, SameObject] readonly attribute External external;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_external", 					DKWindowDUK::external);
		// };
		
		// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
		// [SecureContext]
		// partial interface Window {
		//		[SameObject] readonly attribute CookieStore cookieStore;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_cookieStore", 				DKWindowDUK::cookieStore);
		// };

		// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
		// partial interface Window {
		//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_getDigitalGoodsService", 	DKWindowDUK::getDigitalGoodsService);
		// };

		// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
		// partial interface Window {
		//		// Collection of fenced frame APIs
		//		readonly attribute Fence? fence;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_fence", 						DKWindowDUK::fence);
		// };
		
		// Source: File System Access (https://wicg.github.io/file-system-access/)
		// [SecureContext]
		// partial interface Window {
		//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
				DKDuktape::AttachFunction("CPP_DKWindowDUK_showOpenFilePicker", 		DKWindowDUK::showOpenFilePicker);
		//
		//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
				DKDuktape::AttachFunction("CPP_DKWindowDUK_showSaveFilePicker", 		DKWindowDUK::showSaveFilePicker);
		//
		//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
				DKDuktape::AttachFunction("CPP_DKWindowDUK_showDirectoryPicker", 		DKWindowDUK::showDirectoryPicker);
		// };
		
		// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
		// [SecureContext]
		// partial interface Window {
		//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
				DKDuktape::AttachFunction("CPP_DKWindowDUK_queryLocalFonts", 			DKWindowDUK::queryLocalFonts);
		// };
		
		// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
		// partial interface Window {
		//		attribute EventHandler onappinstalled;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_onappinstalled", 			DKWindowDUK::onappinstalled);
		//
		//		attribute EventHandler onbeforeinstallprompt;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_onbeforeinstallprompt", 		DKWindowDUK::onbeforeinstallprompt);
		// };

		// Source: Portals (https://wicg.github.io/portals/)
		// partial interface Window {
		//		readonly attribute PortalHost? portalHost;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_portalHost", 				DKWindowDUK::portalHost);
		// };
		
		// Source: Web Speech API (https://wicg.github.io/speech-api/)
		// partial interface Window {
		//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_speechSynthesis",			DKWindowDUK::speechSynthesis);
		// };
		
		// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
		// partial interface Window {
		//		readonly attribute LaunchQueue launchQueue;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_launchQueue", 				DKWindowDUK::launchQueue);
		// };
	
		// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
		// partial interface Window {
		//		undefined navigate(SpatialNavigationDirection dir);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_navigate", 					DKWindowDUK::navigate);
		// };

		// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
		// partial interface Window {
		//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_getComputedStyle", 			DKWindowDUK::getComputedStyle);
		// };
	
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface Window {
		//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_matchMedia", 				DKWindowDUK::matchMedia);
		//
		//		[SameObject, Replaceable] readonly attribute Screen screen;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screen",						DKWindowDUK::screen);
		//
		//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_visualViewport",				DKWindowDUK::visualViewport);
		//
		//		// browsing context
		//		undefined moveTo(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_moveTo", 					DKWindowDUK::moveTo);
		//
		//		undefined moveBy(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_moveBy", 					DKWindowDUK::moveBy);
		//
		//		undefined resizeTo(long width, long height);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_resizeTo", 					DKWindowDUK::resizeTo);
		//
		//		undefined resizeBy(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_resizeBy", 					DKWindowDUK::resizeBy);
		//
		//		// viewport
		//		[Replaceable] readonly attribute long innerWidth;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_innerWidth", 				DKWindowDUK::innerWidth);
		//
		//		[Replaceable] readonly attribute long innerHeight;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_innerHeight", 				DKWindowDUK::innerHeight);
		//
		//		// viewport scrolling
		//		[Replaceable] readonly attribute double scrollX;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollX", 					DKWindowDUK::scrollX);
		//
		//		[Replaceable] readonly attribute double pageXOffset;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_pageXOffset", 				DKWindowDUK::pageXOffset);
		//
		//		[Replaceable] readonly attribute double scrollY;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollY", 					DKWindowDUK::scrollY);
		//
		//		[Replaceable] readonly attribute double pageYOffset;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_pageYOffset", 				DKWindowDUK::pageYOffset);
		//
		//		undefined scroll(optional ScrollToOptions options = {});
		//		undefined scroll(unrestricted double x, unrestricted double y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scroll", 					DKWindowDUK::scroll);
		//
		//		undefined scrollTo(optional ScrollToOptions options = {});
		//		undefined scrollTo(unrestricted double x, unrestricted double y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollTo", 					DKWindowDUK::scrollTo);
				
		//		undefined scrollBy(optional ScrollToOptions options = {});
		//		undefined scrollBy(unrestricted double x, unrestricted double y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollBy", 					DKWindowDUK::scrollBy);
		///
		//		// client
		//		[Replaceable] readonly attribute long screenX;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenX", 					DKWindowDUK::screenX);
		//
		//		[Replaceable] readonly attribute long screenLeft;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenLeft", 				DKWindowDUK::screenLeft);
		//
		//		[Replaceable] readonly attribute long screenY;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenY", 					DKWindowDUK::screenY);
		//
		//		[Replaceable] readonly attribute long screenTop;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenTop", 					DKWindowDUK::screenTop);
		//
		//		[Replaceable] readonly attribute long outerWidth;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_outerWidth", 				DKWindowDUK::outerWidth);
		//
		//		[Replaceable] readonly attribute long outerHeight;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_outerHeight", 				DKWindowDUK::outerHeight);
		//
		//		[Replaceable] readonly attribute double devicePixelRatio;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_devicePixelRatio", 			DKWindowDUK::devicePixelRatio);
		// };
	
		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		// partial interface Window {
		//		[SecureContext] attribute EventHandler ondeviceorientation;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_ondeviceorientation", 		DKWindowDUK::ondeviceorientation);
		// };

		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		// partial interface Window {
		//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_ondeviceorientationabsolute", DKWindowDUK::ondeviceorientationabsolute);
		// };

		// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
		//	partial interface Window {
		//		[SecureContext] attribute EventHandler ondevicemotion;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_ondevicemotion",				 DKWindowDUK::ondevicemotion);
		// };
	
		// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
		// partial interface Window {
		//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
				DKDuktape::AttachFunction("CPP_DKWindowDUK_requestIdleCallback", 		DKWindowDUK::requestIdleCallback);
		//
		//		undefined cancelIdleCallback(unsigned long handle);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_cancelIdleCallback", 		DKWindowDUK::cancelIdleCallback);
		// };
	
		// Source: Selection API (https://www.w3.org/TR/selection-api/)
		// partial interface Window {
		//		Selection? getSelection();
				DKDuktape::AttachFunction("CPP_DKWindowDUK_getSelection", 				DKWindowDUK::getSelection);
		// };

		// Source: Window Management (https://www.w3.org/TR/window-management/)
		// partial interface Window {
		//		[SecureContext]
		//		Promise<ScreenDetails> getScreenDetails();
				DKDuktape::AttachFunction("CPP_DKWindowDUK_getScreenDetails", 			DKWindowDUK::getScreenDetails);
		// };
		
		
		////// Load .js files //////
		DKClass::DKCreate("DKWindow/DKWindowDUK.js");
		
		return true;
	}
	
	
	// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
	// [Global=Window,
	// Exposed=Window,
	// LegacyUnenumerableNamedProperties]
	// interface Window : EventTarget {
	
	
	static DKWindow* eventTarget(duk_context* ctx){
		DKString interfaceAddress = duk_require_string(ctx, 0);
		DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
		DKASSERT(interface);
		
		DKString windowAddress = interface->address["Window"];
		DKWindow* _window = (DKWindow*)addressToPointer(windowAddress);
		DKASSERT(_window);
		
		return _window;
	}
	static bool GetBool(duk_context* ctx){
		if (duk_is_boolean(ctx, 1))
			return duk_to_boolean(ctx, 1);
		return false;
	}
	static double GetDouble(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_number(ctx, 1);
		return 0.0;
	}
	static int GetInt(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_int(ctx, 1);
		return 0;
	}
	static DKString GetString(duk_context* ctx){
		if (duk_is_string(ctx, 1))
			return duk_to_string(ctx, 1);
		return "";
	}
	static unsigned int GetUint(duk_context* ctx){
		if (duk_is_number(ctx, 1))
			return duk_to_uint(ctx, 1);
		return 0;
	}
	
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		
		DKINFO("CPP_DKWindowDUK_constructor()\n");
		DKWindow* _window = new DKWindow();
		dukglue_push(ctx, _window->interfaceAddress);
		return true;
	}
	
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	static int window(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString windowAddress = interface->address["Window"];
			DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
			DKASSERT(window);
			
			eventTarget(ctx)->window(window);
		}
		dukglue_push(ctx, eventTarget(ctx)->window()->interfaceAddress);
		return true;
	}
	
	// [Replaceable] readonly attribute WindowProxy self;
	static int self(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString windowAddress = interface->address["Window"];
			DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
			DKASSERT(window);
			
			eventTarget(ctx)->self(window);
		}
		dukglue_push(ctx, eventTarget(ctx)->self()->interfaceAddress);
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute Document document;
	static int document(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString documentAddress = interface->address["Document"];
			DKDocument* document = (DKDocument*)addressToPointer(documentAddress);
			DKASSERT(document);
			
			eventTarget(ctx)->document(document);
		}
		DKDocument* document = eventTarget(ctx)->document();
		DKASSERT(document);

		dukglue_push(ctx, document->interfaceAddress);
		return true;
	}
	
	// attribute DOMString name;
	static int name(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->name(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->name());
		return true;
	}
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString locationAddress = interface->address["Location"];
			DKLocation* location = (DKLocation*)addressToPointer(locationAddress);
			DKASSERT(location);
			
			eventTarget(ctx)->location(location);
		}
		dukglue_push(ctx, eventTarget(ctx)->location()->interfaceAddress);
		return true;
	}
	
	// readonly attribute History history;
	static int history(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->history(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->history());
		return true;
	}
	
	// readonly attribute CustomElementRegistry customElements;
	static int customElements(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->customElements(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->customElements());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp locationbar;
	static int locationbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->locationbar(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->locationbar());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp menubar;
	static int menubar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->menubar(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->menubar());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp personalbar;
	static int personalbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->personalbar(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->personalbar());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	static int scrollbars(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->scrollbars(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->scrollbars());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp statusbar;
	static int statusbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->statusbar(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->statusbar());
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp toolbar;
	static int toolbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->toolbar(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->toolbar());
		return true;
	}
	
	// attribute DOMString status;
	static int status(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->status(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->status());
		return true;
	}
	
	// undefined close();
	static int close(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		eventTarget(ctx)->close();
		return true;
	}
	
	// readonly attribute boolean closed;
	static int closed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->closed(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->closed());
		return true;
	}
	
	// undefined stop();
	static int stop(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		eventTarget(ctx)->stop();
		return true;
	}
	
	// undefined focus();
	static int focus(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		eventTarget(ctx)->focus();
		return true;
	}
	
	// undefined blur();
	static int blur(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		eventTarget(ctx)->blur();
		return true;
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	static int frames(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString windowAddress = interface->address["Window"];
			DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
			DKASSERT(window);
			
			eventTarget(ctx)->frames(window);
		}
		dukglue_push(ctx, eventTarget(ctx)->frames()->interfaceAddress);
		return true;
	}
	
	// [Replaceable] readonly attribute unsigned long length;
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->length(GetUint(ctx));
		dukglue_push(ctx, eventTarget(ctx)->length());
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	static int top(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString windowAddress = interface->address["Window"];
			DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
			DKASSERT(window);
			
			eventTarget(ctx)->top(window);
		}
		dukglue_push(ctx, eventTarget(ctx)->top()->interfaceAddress);
		return true;
	}
	
	// attribute any opener;
	static int opener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->opener(GetString(ctx));
		dukglue_push(ctx, eventTarget(ctx)->opener());
		return true;
	}
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	static int parent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString windowAddress = interface->address["Window"];
			DKWindow* window = (DKWindow*)addressToPointer(windowAddress);
			DKASSERT(window);
			
			eventTarget(ctx)->parent(window);
		}
		dukglue_push(ctx, eventTarget(ctx)->parent()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Element? frameElement;
	static int frameElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString elementAddress = interface->address["Element"];
			DKElement* element = (DKElement*)addressToPointer(elementAddress);
			DKASSERT(element);
			
			eventTarget(ctx)->frameElement(element);
		}
		dukglue_push(ctx, eventTarget(ctx)->frameElement()->interfaceAddress);
		return true;
	}
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	static int open(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		//dukglue_push(ctx, eventTarget(ctx)->open(url, target, features)->interfaceAddress);
		return DKTODO();
	}
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	
	// the user agent
	// readonly attribute Navigator navigator;
	static int navigator(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString navigatorAddress = interface->address["Navigator"];
			DKNavigator* navigator = (DKNavigator*)addressToPointer(navigatorAddress);
			DKASSERT(navigator);
			
			eventTarget(ctx)->navigator(navigator);
		}
		dukglue_push(ctx, eventTarget(ctx)->navigator()->interfaceAddress);
		return true;
	}
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	static int clientInformation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1)){
			DKString interfaceAddress = GetString(ctx);
			DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
			DKASSERT(interface);
			
			DKString navigatorAddress = interface->address["Navigator"];
			DKNavigator* navigator = (DKNavigator*)addressToPointer(navigatorAddress);
			DKASSERT(navigator);
			
			eventTarget(ctx)->clientInformation(navigator);
		}
		dukglue_push(ctx, eventTarget(ctx)->clientInformation()->interfaceAddress);
		return true;
	}
	
	// readonly attribute boolean originAgentCluster;
	static int originAgentCluster(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(duk_is_valid_index(ctx, 1))
			eventTarget(ctx)->originAgentCluster(GetBool(ctx));
		dukglue_push(ctx, eventTarget(ctx)->originAgentCluster());
		return true;
	}
	
	//user prompts
	// undefined alert();
	// undefined alert(DOMString message);
	static int alert(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// boolean confirm(optional DOMString message = "");
	static int confirm(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	static int prompt(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// undefined print();
	static int print(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	static int postMessage(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		return DKTODO();
	}
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			static int orientation(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->orientation((short)GetUint(ctx));
				dukglue_push(ctx, eventTarget(ctx)->orientation());
				return true;
			}
	//		
	//		attribute EventHandler onorientationchange;
			static int onorientationchange(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->onorientationchange(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->onorientationchange());
				return true;
			}
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			static int event(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1)){
					DKString interfaceAddress = GetString(ctx);
					DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
					DKASSERT(interface);
					
					DKString eventAddress = interface->address["Event"];
					DKEvent* event = (DKEvent*)addressToPointer(eventAddress);
					DKASSERT(event);
					
					eventTarget(ctx)->event(event);
				}
				dukglue_push(ctx, eventTarget(ctx)->event()->interfaceAddress);
				return true;
			}
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
			static int captureEvents(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				eventTarget(ctx)->captureEvents();
				return true;
			}
	//
	//		undefined releaseEvents();
			static int releaseEvents(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				eventTarget(ctx)->releaseEvents();
				return true;
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			static int external(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->external(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->external());
				return true;
			}
	// };
	
	// Source: Cookie Store API (https://wicg.github.io/cookie-store/)
	// [SecureContext]
	// partial interface Window {
	//		[SameObject] readonly attribute CookieStore cookieStore;
			static int cookieStore(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->cookieStore(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->cookieStore());
				return true;
			}
	// };

	// Source: Digital Goods API (https://wicg.github.io/digital-goods/)
	// partial interface Window {
	//		[SecureContext] Promise<DigitalGoodsService> getDigitalGoodsService(DOMString serviceProvider);
			static int getDigitalGoodsService(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };

	// Source: Fenced frame (https://wicg.github.io/fenced-frame/)
	// partial interface Window {
	//		// Collection of fenced frame APIs
	//		readonly attribute Fence? fence;
			static int fence(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->fence(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->fence());
				return true;
			}
	// };
	
	// Source: File System Access (https://wicg.github.io/file-system-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FileSystemFileHandle>> showOpenFilePicker(optional OpenFilePickerOptions options = {});
			static int showOpenFilePicker(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			static int showSaveFilePicker(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			static int showDirectoryPicker(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			static int queryLocalFonts(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
	
	// Source: Manifest Incubations (https://wicg.github.io/manifest-incubations/)
	// partial interface Window {
	//		attribute EventHandler onappinstalled;
			static int onappinstalled(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->onappinstalled(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->onappinstalled());
				return true;
			}
	//
	//		attribute EventHandler onbeforeinstallprompt;
			static int onbeforeinstallprompt(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->onbeforeinstallprompt(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->onbeforeinstallprompt());
				return true;
			}
	// };

	// Source: Portals (https://wicg.github.io/portals/)
	// partial interface Window {
	//		readonly attribute PortalHost? portalHost;
			static int portalHost(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->portalHost(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->portalHost());
				return true;
			}
	// };
	
	// Source: Web Speech API (https://wicg.github.io/speech-api/)
	// partial interface Window {
	//		[SameObject] readonly attribute SpeechSynthesis speechSynthesis;
			static int speechSynthesis(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->speechSynthesis(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->speechSynthesis());
				return true;
			}	
	// };
	
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			static int launchQueue(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->launchQueue(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->launchQueue());
				return true;
			}
	// };
	
	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
			static int navigate(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
	
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			static int getComputedStyle(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				DKString interfaceAddress = GetString(ctx);
				DKInterface* interface = (DKInterface*)addressToPointer(interfaceAddress);
				DKASSERT(interface);
				
				DKString eltAddress = interface->address["Element"];
				DKElement* elt = (DKElement*)addressToPointer(eltAddress);
				DKASSERT(elt);
					
				DKCSSStyleDeclaration* cssStyleDeclaration = eventTarget(ctx)->getComputedStyle(elt/*, TODO */);
				dukglue_push(ctx, cssStyleDeclaration->interfaceAddress);
				return DKTODO();
			}
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			static int matchMedia(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			static int screen(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->screen((DKScreen*)addressToPointer(GetString(ctx)));
				dukglue_push(ctx, eventTarget(ctx)->screen()->interfaceAddress);
				return true;
			}
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			static int visualViewport(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->visualViewport(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->visualViewport());
				return true;
			}
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			static int moveTo(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				int x = duk_require_int(ctx, 1);
				int y = duk_require_int(ctx, 2);
				eventTarget(ctx)->moveTo(x, y);
				return true;
			}
	//
	//		undefined moveBy(long x, long y);
			static int moveBy(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				int deltaX = duk_require_int(ctx, 1);
				int deltaY = duk_require_int(ctx, 2);
				eventTarget(ctx)->moveBy(deltaX, deltaY);
				return true;
			}
	//
	//		undefined resizeTo(long width, long height);
			static int resizeTo(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				int width = duk_require_int(ctx, 1);
				int height = duk_require_int(ctx, 2);
				eventTarget(ctx)->resizeTo(width, height);
				return true;
			}
	//
	//		undefined resizeBy(long x, long y);
			static int resizeBy(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				int xDelta = duk_require_int(ctx, 1);
				int yDelta = duk_require_int(ctx, 2);
				eventTarget(ctx)->resizeBy(xDelta, yDelta);
				return true;
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			static int innerWidth(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->innerWidth(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->innerWidth());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long innerHeight;
			static int innerHeight(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->innerHeight(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->innerHeight());
				return true;
			}
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			static int scrollX(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->scrollX(GetDouble(ctx));
				dukglue_push(ctx, eventTarget(ctx)->scrollX());
				return true;
			}
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			static int pageXOffset(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->pageXOffset(GetDouble(ctx));
				dukglue_push(ctx, eventTarget(ctx)->pageXOffset());
				return true;
			}
	//
	//		[Replaceable] readonly attribute double scrollY;
			static int scrollY(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->scrollY(GetDouble(ctx));
				dukglue_push(ctx, eventTarget(ctx)->scrollY());
				return true;
			}
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			static int pageYOffset(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->pageYOffset(GetDouble(ctx));
				dukglue_push(ctx, eventTarget(ctx)->pageYOffset());
				return true;
			}
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			static int scroll(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			static int scrollTo(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			static int scrollBy(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			static int screenX(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->screenX(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->screenX());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long screenLeft;
			static int screenLeft(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->screenLeft(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->screenLeft());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long screenY;
			static int screenY(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->screenY(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->screenY());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long screenTop;
			static int screenTop(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->screenTop(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->screenTop());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long outerWidth;
			static int outerWidth(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->outerWidth(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->outerWidth());
				return true;
			}
	//
	//		[Replaceable] readonly attribute long outerHeight;
			static int outerHeight(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->outerHeight(GetInt(ctx));
				dukglue_push(ctx, eventTarget(ctx)->outerHeight());
				return true;
			}
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			static int devicePixelRatio(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->devicePixelRatio(GetDouble(ctx));
				dukglue_push(ctx, eventTarget(ctx)->devicePixelRatio());
				return true;
			}
	// };
	
	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientation;
			static int ondeviceorientation(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->ondeviceorientation(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->ondeviceorientation());
				return true;
			}
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	// partial interface Window {
	//		[SecureContext] attribute EventHandler ondeviceorientationabsolute;
			static int ondeviceorientationabsolute(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->ondeviceorientationabsolute(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->ondeviceorientationabsolute());
				return true;
			}
	// };

	// Source: DeviceOrientation Event Specification (https://www.w3.org/TR/orientation-event/)
	//	partial interface Window {
	//		[SecureContext] attribute EventHandler ondevicemotion;
			static int ondevicemotion(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				if(duk_is_valid_index(ctx, 1))
					eventTarget(ctx)->ondevicemotion(GetString(ctx));
				dukglue_push(ctx, eventTarget(ctx)->ondevicemotion());
				return true;
			}
	// };
	
	// Source: requestIdleCallback() (https://www.w3.org/TR/requestidlecallback/)
	// partial interface Window {
	//		unsigned long requestIdleCallback(IdleRequestCallback callback, optional IdleRequestOptions options = {});
			static int requestIdleCallback(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			static int cancelIdleCallback(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
	
	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			static int getSelection(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
	
	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
			static int getScreenDetails(duk_context* ctx){
				DKDEBUGFUNC(ctx);
				return DKTODO();
			}
	// };
};
REGISTER_OBJECT(DKWindowDUK, true)


#endif //DKWindowDUK_H
#endif //HAVE_DKDuktape