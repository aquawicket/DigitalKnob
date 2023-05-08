// [IDL] file:///C:/Users/Administrator/digitalknob/DK/3rdParty/webref-curated/ed/idlnames/Window.idl
// [SOURCE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
#if HAVE_DKDuktape

#pragma once
#ifndef DKWindowDUK_H
#define DKWindowDUK_H

#include "DKDuktape/DKDuktape.h"


// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
// [Global=Window,
// Exposed=Window,
// LegacyUnenumerableNamedProperties]
// interface Window : EventTarget {
class DKWindowDUK : public DKObjectT<DKWindowDUK>
{
public:
	bool Init(){
		
		DKDuktape::AttachFunction("CPP_DKWindowDUK", DKWindowDUK::constructor);
		
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
		//DKDuktape::AttachFunction("CPP_DKWindowDUK_open", 				DKWindowDUK::open); // TODO
		
		//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
		//object on the prototype chain. Indeed, this does not make the global object an exotic object.
		//Indexed access is taken care of by the WindowProxy exotic object.
		// getter object (DOMString name);
	
		// the user agent
		// readonly attribute Navigator navigator;
		DKDuktape::AttachFunction("CPP_DKWindowDUK_navigator", 			DKWindowDUK::navigator);
	
		// readonly attribute Navigator clientInformation; // legacy alias of .navigator
		DKDuktape::AttachFunction("CPP_DKWindowDUK_clientInformation", 	DKWindowDUK::clientInformation);
		
		// readonly attribute boolean originAgentCluster;
		
		//user prompts
		// undefined alert();
		// undefined alert(DOMString message);
		
		// boolean confirm(optional DOMString message = "");
		
		// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
		
		// undefined print();
		
		// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
		// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	
		// also has obsolete members
		
		// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
		// partial interface Window {
		//		readonly attribute short orientation;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_orientation", 	DKWindowDUK::orientation);
		//		
		//		attribute EventHandler onorientationchange;
		
		// };
		
		// Source: DOM Standard (https://dom.spec.whatwg.org/)
		// partial interface Window {
		//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
				DKDuktape::AttachFunction("CPP_DKWindowDUK_event", 			DKWindowDUK::event);
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
				DKDuktape::AttachFunction("CPP_DKWindowDUK_captureEvents", 		DKWindowDUK::captureEvents);
		//
		//		undefined releaseEvents();
				DKDuktape::AttachFunction("CPP_DKWindowDUK_releaseEvents", 		DKWindowDUK::releaseEvents);
		//
		//		[Replaceable, SameObject] readonly attribute External external;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_external", 			DKWindowDUK::external);
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
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_showOpenFilePicker", 	DKWindowDUK::showOpenFilePicker);  // TODO
		//
		//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_showSaveFilePicker", 	DKWindowDUK::showSaveFilePicker);  // TODO
		//
		//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_showDirectoryPicker", 	DKWindowDUK::showDirectoryPicker);  // TODO
		// };
		
		// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
		// [SecureContext]
		// partial interface Window {
		//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_queryLocalFonts", 		DKWindowDUK::queryLocalFonts); // TODO
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
				DKDuktape::AttachFunction("CPP_DKWindowDUK_speechSynthesis",	DKWindowDUK::speechSynthesis);
		// };
		
		// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
		// partial interface Window {
		//		readonly attribute LaunchQueue launchQueue;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_launchQueue", 		DKWindowDUK::launchQueue);
		// };
	
		// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
		// partial interface Window {
		//		undefined navigate(SpatialNavigationDirection dir);
		// };

		// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
		// partial interface Window {
		//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_getComputedStyle", 	DKWindowDUK::getComputedStyle); 	// TODO
		// };
	
		// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
		// partial interface Window {
		//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
				//DKDuktape::AttachFunction("CPP_DKWindowDUK_matchMedia", 		DKWindowDUK::matchMedia);	 // TODO
		//
		//		[SameObject, Replaceable] readonly attribute Screen screen;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screen",				DKWindowDUK::screen);
		//
		//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_visualViewport",		DKWindowDUK::visualViewport);
		//
		//		// browsing context
		//		undefined moveTo(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_moveTo", 			DKWindowDUK::moveTo);
		//
		//		undefined moveBy(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_moveBy", 			DKWindowDUK::moveBy);
		//
		//		undefined resizeTo(long width, long height);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_resizeTo", 			DKWindowDUK::resizeTo);
		//
		//		undefined resizeBy(long x, long y);
				DKDuktape::AttachFunction("CPP_DKWindowDUK_resizeBy", 			DKWindowDUK::resizeBy);
		//
		//		// viewport
		//		[Replaceable] readonly attribute long innerWidth;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_innerWidth", 		DKWindowDUK::innerWidth);
		//
		//		[Replaceable] readonly attribute long innerHeight;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_innerHeight", 		DKWindowDUK::innerHeight);
		//
		//		// viewport scrolling
		//		[Replaceable] readonly attribute double scrollX;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollX", 			DKWindowDUK::scrollX);
		//
		//		[Replaceable] readonly attribute double pageXOffset;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_pageXOffset", 		DKWindowDUK::pageXOffset);
		//
		//		[Replaceable] readonly attribute double scrollY;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollY", 			DKWindowDUK::scrollY);
		//
		//		[Replaceable] readonly attribute double pageYOffset;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_pageYOffset", 		DKWindowDUK::pageYOffset);
		//
		//		undefined scroll(optional ScrollToOptions options = {});
		//		undefined scroll(unrestricted double x, unrestricted double y);
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_scroll", 			DKWindowDUK::scroll);		// TODO
		//
		//		undefined scrollTo(optional ScrollToOptions options = {});
		//		undefined scrollTo(unrestricted double x, unrestricted double y);
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollTo", 			DKWindowDUK::scrollTo);		// TODO
				
		//		undefined scrollBy(optional ScrollToOptions options = {});
		//		undefined scrollBy(unrestricted double x, unrestricted double y);
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_scrollBy", 			DKWindowDUK::scrollBy);		// TODO
		///
		//		// client
		//		[Replaceable] readonly attribute long screenX;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenX", 			DKWindowDUK::screenX);
		//
		//		[Replaceable] readonly attribute long screenLeft;
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_screenLeft", 		DKWindowDUK::screenLeft);		// TODO
		//
		//		[Replaceable] readonly attribute long screenY;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_screenY", 			DKWindowDUK::screenY);
		//
		//		[Replaceable] readonly attribute long screenTop;
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_screenTop", 			DKWindowDUK::screenTop);	// TODO
		//
		//		[Replaceable] readonly attribute long outerWidth;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_outerWidth", 		DKWindowDUK::outerWidth);
		//
		//		[Replaceable] readonly attribute long outerHeight;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_outerHeight", 		DKWindowDUK::outerHeight);
		//
		//		[Replaceable] readonly attribute double devicePixelRatio;
				DKDuktape::AttachFunction("CPP_DKWindowDUK_devicePixelRatio", 	DKWindowDUK::devicePixelRatio);
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
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_requestIdleCallback", 	DKWindowDUK::requestIdleCallback);		// TODO
		//
		//		undefined cancelIdleCallback(unsigned long handle);
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_cancelIdleCallback", 	DKWindowDUK::cancelIdleCallback);			// TODO
		// };
	
		// Source: Selection API (https://www.w3.org/TR/selection-api/)
		// partial interface Window {
		//		Selection? getSelection();
				// DKDuktape::AttachFunction("CPP_DKWindowDUK_getSelection", 			DKWindowDUK::getSelection);			// TODO
		// };

		// Source: Window Management (https://www.w3.org/TR/window-management/)
		// partial interface Window {
		//		[SecureContext]
		//		Promise<ScreenDetails> getScreenDetails();
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
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		return (DKWindow*)addressToPointer(eventTargetAddress);
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
		DKINFO("CPP_DKWindowDUK()\n");
		DKWindow* _window = new DKWindow();
		DKString eventTargetAddress = pointerToAddress(_window);
		duk_push_string(ctx, eventTargetAddress.c_str());
		return true;
	}
	
	
	// the current browsing context
	// [LegacyUnforgeable] readonly attribute WindowProxy window;
	static int window(duk_context* ctx){ // [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
		DKDEBUGFUNC(ctx);
		DKString _window = GetString(ctx);
		if(!eventTarget(ctx)->window(_window, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _window);
		return true;
	}
	
	// [Replaceable] readonly attribute WindowProxy self;
	static int self(duk_context* ctx){ // [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
		DKDEBUGFUNC(ctx);
		DKString _self = GetString(ctx);
		if(!eventTarget(ctx)->self(_self, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _self);
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute Document document;
	static int document(duk_context* ctx){ // [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
		DKDEBUGFUNC(ctx);
		DKString _document = GetString(ctx);
		if(!eventTarget(ctx)->document(_document, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _document);
		return true;
	}
	
	// attribute DOMString name;
	static int name(duk_context* ctx){ // [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
		DKDEBUGFUNC(ctx);
		DKString _name = GetString(ctx);
		if(!eventTarget(ctx)->name(_name, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _name);
		return true;
	}
	
	// [PutForwards=href, LegacyUnforgeable] readonly attribute Location location;
	static int location(duk_context* ctx){ // [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
		DKDEBUGFUNC(ctx);
		DKString _location = GetString(ctx);
		if(!eventTarget(ctx)->location(_location, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _location);
		return true;
	}
	
	// readonly attribute History history;
	static int history(duk_context* ctx){ // [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
		DKDEBUGFUNC(ctx);
		DKString _history = GetString(ctx);
		if(!eventTarget(ctx)->history(_history, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _history);
		return true;
	}
	
	// readonly attribute CustomElementRegistry customElements;
	static int customElements(duk_context* ctx){ // [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
		DKDEBUGFUNC(ctx);
		DKString _customElements = GetString(ctx);
		if(!eventTarget(ctx)->customElements(_customElements, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _customElements);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp locationbar;
	static int locationbar(duk_context* ctx){ // [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
		DKDEBUGFUNC(ctx);
		DKString _locationbar = GetString(ctx);
		if(!eventTarget(ctx)->locationbar(_locationbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _locationbar);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp menubar;
	static int menubar(duk_context* ctx){ // [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
		DKDEBUGFUNC(ctx);
		DKString _menubar = GetString(ctx);
		if(!eventTarget(ctx)->menubar(_menubar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _menubar);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp personalbar;
	static int personalbar(duk_context* ctx){ // [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
		DKDEBUGFUNC(ctx);
		DKString _personalbar = GetString(ctx);
		if(!eventTarget(ctx)->personalbar(_personalbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _personalbar);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp scrollbars;
	static int scrollbars(duk_context* ctx){ // [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
		DKDEBUGFUNC(ctx);
		DKString _scrollbars = GetString(ctx);
		if(!eventTarget(ctx)->scrollbars(_scrollbars, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollbars);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp statusbar;
	static int statusbar(duk_context* ctx){ // [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
		DKDEBUGFUNC(ctx);
		DKString _statusbar = GetString(ctx);
		if(!eventTarget(ctx)->statusbar(_statusbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _statusbar);
		return true;
	}
	
	// [Replaceable] readonly attribute BarProp toolbar;
	static int toolbar(duk_context* ctx){ // [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
		DKDEBUGFUNC(ctx);
		DKString _toolbar = GetString(ctx);
		if(!eventTarget(ctx)->toolbar(_toolbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _toolbar);
		return true;
	}
	
	// attribute DOMString status;
	static int status(duk_context* ctx){ // [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
		DKDEBUGFUNC(ctx);
		DKString _status = GetString(ctx);
		if(!eventTarget(ctx)->status(_status, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _status);
		return true;
	}
	
	// undefined close();
	static int close(duk_context* ctx){ // [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/close
			DKDEBUGFUNC(ctx);
			if(!eventTarget(ctx)->close())
				return false;
			return true;
	}
	
	// readonly attribute boolean closed;
	static int closed(duk_context* ctx){ // [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
		DKDEBUGFUNC(ctx);
		bool _closed = GetBool(ctx);
		if(!eventTarget(ctx)->closed(_closed, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _closed);
		return true;
	}
	
	// undefined stop();
	static int stop(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->stop())
			return false;
		return true;
	}
	
	// undefined focus();
	static int focus(duk_context* ctx){ // [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/focus
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->focus())
			return false;
		return true;
	}
	
	// undefined blur();
	static int blur(duk_context* ctx){ // [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/blur
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->blur())
			return false;
		return true;
	}
	
	// other browsing contexts
	// [Replaceable] readonly attribute WindowProxy frames;
	static int frames(duk_context* ctx){ // [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
		DKDEBUGFUNC(ctx);
		DKString _frames = GetString(ctx);
		if(!eventTarget(ctx)->frames(_frames, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _frames);
		return true;
	}
	
	// [Replaceable] readonly attribute unsigned long length;
	static int length(duk_context* ctx){ // [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
		DKDEBUGFUNC(ctx);
		unsigned int _length = GetUint(ctx);
		if(!eventTarget(ctx)->length(_length, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _length);
		return true;
	}
	
	// [LegacyUnforgeable] readonly attribute WindowProxy? top;
	static int top(duk_context* ctx){ // [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
		DKDEBUGFUNC(ctx);
		DKString _top = GetString(ctx);
		if(!eventTarget(ctx)->top(_top, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _top);
		return true;
	}
	
	// attribute any opener;
	static int opener(duk_context* ctx){ // [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
		DKDEBUGFUNC(ctx);
		DKString _opener = GetString(ctx);
		if(!eventTarget(ctx)->opener(_opener, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _opener);
		return true;
	}
	
	// [Replaceable] readonly attribute WindowProxy? parent;
	static int parent(duk_context* ctx){ // [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
		DKDEBUGFUNC(ctx);
		DKString _parent = GetString(ctx);
		if(!eventTarget(ctx)->parent(_parent, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _parent);
		return true;
	}
	
	// readonly attribute Element? frameElement;
	static int frameElement(duk_context* ctx){ // [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
		DKDEBUGFUNC(ctx);
		DKString _frameElement = GetString(ctx);
		if(!eventTarget(ctx)->frameElement(_frameElement, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _frameElement);
		return true;
	}
	
	// WindowProxy? open(optional USVString url = "", optional DOMString target = "_blank", optional [LegacyNullToEmptyString] DOMString features = "");
	
	//Since this is the global object, the IDL named getter adds a NamedPropertiesObject exotic
	//object on the prototype chain. Indeed, this does not make the global object an exotic object.
	//Indexed access is taken care of by the WindowProxy exotic object.
	// getter object (DOMString name);
	
	// the user agent
	// readonly attribute Navigator navigator;
	static int navigator(duk_context* ctx){ // [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
		DKDEBUGFUNC(ctx);
		DKString _navigator = GetString(ctx);
		if(!eventTarget(ctx)->navigator(_navigator, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _navigator);
		return true;
	}
	
	// readonly attribute Navigator clientInformation; // legacy alias of .navigator
	static int clientInformation(duk_context* ctx){ // [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
		DKDEBUGFUNC(ctx);
		DKString _clientInformation = GetString(ctx);
		if(!eventTarget(ctx)->clientInformation(_clientInformation, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _clientInformation);
		return true;
	}
	
	// readonly attribute boolean originAgentCluster;
	
	//user prompts
	// undefined alert();
	// undefined alert(DOMString message);
	
	// boolean confirm(optional DOMString message = "");
	
	// DOMString? prompt(optional DOMString message = "", optional DOMString default = "");
	
	// undefined print();
	
	// undefined postMessage(any message, USVString targetOrigin, optional sequence<object> transfer = []);
	// undefined postMessage(any message, optional WindowPostMessageOptions options = {});
	
	// also has obsolete members
	
	// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
	// partial interface Window {
	//		readonly attribute short orientation;
			static int orientation(duk_context* ctx){ // [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
				DKDEBUGFUNC(ctx);
				int _orientation = GetInt(ctx);
				if(!eventTarget(ctx)->orientation(_orientation, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _orientation);
				return true;
			}
	//		
	//		attribute EventHandler onorientationchange;
	
	// };
	
	// Source: DOM Standard (https://dom.spec.whatwg.org/)
	// partial interface Window {
	//		[Replaceable] readonly attribute (Event or undefined) event; // legacy
			static int event(duk_context* ctx){ // [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
				DKDEBUGFUNC(ctx);
				DKString _event = GetString(ctx);
				if(!eventTarget(ctx)->event(_event, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _event);
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
			static int captureEvents(duk_context* ctx){ // [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
				DKDEBUGFUNC(ctx);
				if(!eventTarget(ctx)->captureEvents())
					return false;
				return true;
			}
	//
	//		undefined releaseEvents();
			static int releaseEvents(duk_context* ctx){ // [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
				DKDEBUGFUNC(ctx);
				DKString eventType = duk_require_string(ctx, 1);
				if(!eventTarget(ctx)->releaseEvents(eventType))
					return false;
				return true;
			}
	//
	//		[Replaceable, SameObject] readonly attribute External external;
			static int external(duk_context* ctx){ // [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
				DKDEBUGFUNC(ctx);
				DKString _external = GetString(ctx);
				if(!eventTarget(ctx)->external(_external, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _external);
				return true;
			}
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
			// TODO
	//
	//		Promise<FileSystemFileHandle> showSaveFilePicker(optional SaveFilePickerOptions options = {});
			// TODO
	//
	//		Promise<FileSystemDirectoryHandle> showDirectoryPicker(optional DirectoryPickerOptions options = {});
			// TODO
	// };
	
	// Source: Local Font Access API (https://wicg.github.io/local-font-access/)
	// [SecureContext]
	// partial interface Window {
	//		Promise<sequence<FontData>> queryLocalFonts(optional QueryOptions options = {});
			// TODO
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
			static int speechSynthesis(duk_context* ctx){ // [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
				DKDEBUGFUNC(ctx);
				DKString _speechSynthesis = GetString(ctx);
				if(!eventTarget(ctx)->speechSynthesis(_speechSynthesis, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _speechSynthesis);
				return true;
			}	
	// };
	
	// Source: Web App Launch Handler API (https://wicg.github.io/web-app-launch/)
	// partial interface Window {
	//		readonly attribute LaunchQueue launchQueue;
			static int launchQueue(duk_context* ctx){ // [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
				DKDEBUGFUNC(ctx);
				DKString _launchQueue = GetString(ctx);
				if(!eventTarget(ctx)->launchQueue(_launchQueue, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _launchQueue);
				return true;
			}
	// };
	
	// Source: CSS Spatial Navigation Level 1 (https://www.w3.org/TR/css-nav-1/)
	// partial interface Window {
	//		undefined navigate(SpatialNavigationDirection dir);
	// };
	
	// Source: CSS Object Model (CSSOM) (https://www.w3.org/TR/cssom-1/)
	// partial interface Window {
	//		[NewObject] CSSStyleDeclaration getComputedStyle(Element elt, optional CSSOMString? pseudoElt);
			// TODO
	// };
	
	// Source: CSSOM View Module (https://www.w3.org/TR/cssom-view-1/)
	// partial interface Window {
	//		[NewObject] MediaQueryList matchMedia(CSSOMString query);
			// TODO
	//
	//		[SameObject, Replaceable] readonly attribute Screen screen;
			static int screen(duk_context* ctx){ // [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
				DKDEBUGFUNC(ctx);
				DKString _screen = GetString(ctx);
				if(!eventTarget(ctx)->screen(_screen, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _screen);
				return true;
			}
	//
	//		[SameObject, Replaceable] readonly attribute VisualViewport? visualViewport;
			static int visualViewport(duk_context* ctx){ // [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
				DKDEBUGFUNC(ctx);
				DKString _visualViewport = GetString(ctx);
				if(!eventTarget(ctx)->visualViewport(_visualViewport, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _visualViewport);
				return true;
			}
	//
	//		// browsing context
	//		undefined moveTo(long x, long y);
			static int moveTo(duk_context* ctx){ // [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/moveTo
				DKDEBUGFUNC(ctx);
				int x = duk_require_int(ctx, 1);
				int y = duk_require_int(ctx, 2);
				if(!eventTarget(ctx)->moveTo(x, y))
					return false;
				return true;
			}
	//
	//		undefined moveBy(long x, long y);
			static int moveBy(duk_context* ctx){ // [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
				DKDEBUGFUNC(ctx);
				int deltaX = duk_require_int(ctx, 1);
				int deltaY = duk_require_int(ctx, 2);
				if(!eventTarget(ctx)->moveBy(deltaX, deltaY))
					return false;
				return true;
			}
	//
	//		undefined resizeTo(long width, long height);
			static int resizeTo(duk_context* ctx){ // [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/resizeTo
				DKDEBUGFUNC(ctx);
				int width = duk_require_int(ctx, 1);
				int height = duk_require_int(ctx, 2);
				if(!eventTarget(ctx)->resizeTo(width, height))
					return false;
				return true;
			}
	//
	//		undefined resizeBy(long x, long y);
			static int resizeBy(duk_context* ctx){ // [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/resizeBy
				DKDEBUGFUNC(ctx);
				int xDelta = duk_require_int(ctx, 1);
				int yDelta = duk_require_int(ctx, 2);
				if(!eventTarget(ctx)->resizeBy(xDelta, yDelta))
					return false;
				return true;
			}
	//
	//		// viewport
	//		[Replaceable] readonly attribute long innerWidth;
			static int innerWidth(duk_context* ctx){ // [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
				DKDEBUGFUNC(ctx);
				unsigned int _innerWidth = GetUint(ctx);
				if(!eventTarget(ctx)->innerWidth(_innerWidth, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _innerWidth);
				return true;
			}
	//
	//		[Replaceable] readonly attribute long innerHeight;
			static int innerHeight(duk_context* ctx){ // [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
				DKDEBUGFUNC(ctx);
				unsigned int _innerHeight = GetUint(ctx);
				if(!eventTarget(ctx)->innerHeight(_innerHeight, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _innerHeight);
				return true;
			}
	//
	//		// viewport scrolling
	//		[Replaceable] readonly attribute double scrollX;
			static int scrollX(duk_context* ctx){ // [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
				DKDEBUGFUNC(ctx);
				unsigned int _scrollX = GetUint(ctx);
				if(!eventTarget(ctx)->scrollX(_scrollX, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _scrollX);
				return true;
			}
	//
	//		[Replaceable] readonly attribute double pageXOffset;
			static int pageXOffset(duk_context* ctx){ // [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
				DKDEBUGFUNC(ctx);
				unsigned int _pageXOffset = GetUint(ctx);
				if(!eventTarget(ctx)->pageXOffset(_pageXOffset, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _pageXOffset);
				return true;
			}
	//
	//		[Replaceable] readonly attribute double scrollY;
			static int scrollY(duk_context* ctx){ // [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
				DKDEBUGFUNC(ctx);
				unsigned int _scrollY = GetUint(ctx);
				if(!eventTarget(ctx)->scrollY(_scrollY, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _scrollY);
				return true;
			}
	//
	//		[Replaceable] readonly attribute double pageYOffset;
			static int pageYOffset(duk_context* ctx){ // [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
				DKDEBUGFUNC(ctx);
				unsigned int _pageYOffset = GetUint(ctx);
				if(!eventTarget(ctx)->pageYOffset(_pageYOffset, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _pageYOffset);
				return true;
			}
	//
	//		undefined scroll(optional ScrollToOptions options = {});
	//		undefined scroll(unrestricted double x, unrestricted double y);
			// TODO
	//
	//		undefined scrollTo(optional ScrollToOptions options = {});
	//		undefined scrollTo(unrestricted double x, unrestricted double y);
			// TODO
	//
	//		undefined scrollBy(optional ScrollToOptions options = {});
	//		undefined scrollBy(unrestricted double x, unrestricted double y);
			// TODO
	///
	//		// client
	//		[Replaceable] readonly attribute long screenX;
			static int screenX(duk_context* ctx){ // [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
				DKDEBUGFUNC(ctx);
				int _screenX = GetInt(ctx);
				if(!eventTarget(ctx)->screenX(_screenX, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _screenX);
				return true;
			}
	//
	//		[Replaceable] readonly attribute long screenLeft;
			// TODO
	//
	//		[Replaceable] readonly attribute long screenY;
			static int screenY(duk_context* ctx){ // [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
				DKDEBUGFUNC(ctx);
				int _screenY = GetInt(ctx);
				if(!eventTarget(ctx)->screenY(_screenY, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _screenY);
				return true;
			}
	//
	//		[Replaceable] readonly attribute long screenTop;
	//		// TODO
	//
	//		[Replaceable] readonly attribute long outerWidth;
			static int outerWidth(duk_context* ctx){ // [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
				DKDEBUGFUNC(ctx);
				unsigned int _outerWidth = GetUint(ctx);
				if(!eventTarget(ctx)->outerWidth(_outerWidth, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _outerWidth);
				return true;
			}
	//
	//		[Replaceable] readonly attribute long outerHeight;
			static int outerHeight(duk_context* ctx){ // [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
				DKDEBUGFUNC(ctx);
				unsigned int _outerHeight = GetUint(ctx);
				if(!eventTarget(ctx)->outerHeight(_outerHeight, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _outerHeight);
				return true;
			}
	//
	//		[Replaceable] readonly attribute double devicePixelRatio;
			static int devicePixelRatio(duk_context* ctx){ // [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
				DKDEBUGFUNC(ctx);
				double _devicePixelRatio = GetDouble(ctx);
				if(!eventTarget(ctx)->devicePixelRatio(_devicePixelRatio, duk_is_valid_index(ctx, 1)))
					return false;
				dukglue_push(ctx, _devicePixelRatio);
				return true;
			}
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
			// TODO
	//
	//		undefined cancelIdleCallback(unsigned long handle);
			// TODO
	// };
	
	// Source: Selection API (https://www.w3.org/TR/selection-api/)
	// partial interface Window {
	//		Selection? getSelection();
			// TODO
	// };
	
	// Source: Window Management (https://www.w3.org/TR/window-management/)
	// partial interface Window {
	//		[SecureContext]
	//		Promise<ScreenDetails> getScreenDetails();
	// };
};
REGISTER_OBJECT(DKWindowDUK, true)


#endif //DKWindowDUK_H
#endif //HAVE_DKDuktape