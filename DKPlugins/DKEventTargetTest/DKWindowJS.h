#pragma once
#ifndef DKWindowJS_H
#define DKWindowJS_H

#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "dukglue/dukglue.h"
WARNING_ENABLE


// [INTERFACE] https://html.spec.whatwg.org/multipage/nav-history-apis.html#the-window-object
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Window
class DKWindowJS : public DKObjectT<DKWindowJS>
{
public:
	bool Init(){
		
		////// Constructor //////
		DKDuktape::AttachFunction("CPP_DKWindow", DKWindowJS::constructor);
		
		
		////// Instance properties //////
		DKDuktape::AttachFunction("CPP_DKWindow_caches", 			DKWindowJS::caches);
		DKDuktape::AttachFunction("CPP_DKWindow_clientInformation", DKWindowJS::clientInformation);
		DKDuktape::AttachFunction("CPP_DKWindow_closed", 			DKWindowJS::closed);
		DKDuktape::AttachFunction("CPP_DKWindow_console", 			DKWindowJS::console);
		DKDuktape::AttachFunction("CPP_DKWindow_credentialless", 	DKWindowJS::credentialless);
		DKDuktape::AttachFunction("CPP_DKWindow_crypto", 			DKWindowJS::crypto);
		DKDuktape::AttachFunction("CPP_DKWindow_customElements", 	DKWindowJS::customElements);
		DKDuktape::AttachFunction("CPP_DKWindow_devicePixelRatio", 	DKWindowJS::devicePixelRatio);
		DKDuktape::AttachFunction("CPP_DKWindow_document", 			DKWindowJS::document);
		DKDuktape::AttachFunction("CPP_DKWindow_frameElement", 		DKWindowJS::frameElement);
		DKDuktape::AttachFunction("CPP_DKWindow_frames", 			DKWindowJS::frames);
		DKDuktape::AttachFunction("CPP_DKWindow_fullScreen", 		DKWindowJS::fullScreen);
		DKDuktape::AttachFunction("CPP_DKWindow_history", 			DKWindowJS::history);
		DKDuktape::AttachFunction("CPP_DKWindow_indexedDB", 		DKWindowJS::indexedDB);
		DKDuktape::AttachFunction("CPP_DKWindow_innerHeight", 		DKWindowJS::innerHeight);
		DKDuktape::AttachFunction("CPP_DKWindow_innerWidth", 		DKWindowJS::innerWidth);
		DKDuktape::AttachFunction("CPP_DKWindow_isSecureContext", 	DKWindowJS::isSecureContext);
		DKDuktape::AttachFunction("CPP_DKWindow_launchQueue", 		DKWindowJS::launchQueue);
		DKDuktape::AttachFunction("CPP_DKWindow_length", 			DKWindowJS::length);
		DKDuktape::AttachFunction("CPP_DKWindow_location", 			DKWindowJS::location);
		DKDuktape::AttachFunction("CPP_DKWindow_locationbar", 		DKWindowJS::locationbar);
		DKDuktape::AttachFunction("CPP_DKWindow_localStorage", 		DKWindowJS::localStorage);
		DKDuktape::AttachFunction("CPP_DKWindow_menubar", 			DKWindowJS::menubar);
		DKDuktape::AttachFunction("CPP_DKWindow_mozInnerScreenX", 	DKWindowJS::mozInnerScreenX);
		DKDuktape::AttachFunction("CPP_DKWindow_mozInnerScreenY", 	DKWindowJS::mozInnerScreenY);
		DKDuktape::AttachFunction("CPP_DKWindow_name", 				DKWindowJS::name);
		DKDuktape::AttachFunction("CPP_DKWindow_navigation", 		DKWindowJS::navigation);
		DKDuktape::AttachFunction("CPP_DKWindow_navigator", 		DKWindowJS::navigator);
		DKDuktape::AttachFunction("CPP_DKWindow_opener", 			DKWindowJS::opener);
		DKDuktape::AttachFunction("CPP_DKWindow_origin", 			DKWindowJS::origin);
		DKDuktape::AttachFunction("CPP_DKWindow_outerHeight", 		DKWindowJS::outerHeight);
		DKDuktape::AttachFunction("CPP_DKWindow_outerWidth", 		DKWindowJS::outerWidth);
		DKDuktape::AttachFunction("CPP_DKWindow_pageXOffset", 		DKWindowJS::pageXOffset);
		DKDuktape::AttachFunction("CPP_DKWindow_pageYOffset", 		DKWindowJS::pageYOffset);
		DKDuktape::AttachFunction("CPP_DKWindow_parent", 			DKWindowJS::parent);
		DKDuktape::AttachFunction("CPP_DKWindow_performance", 		DKWindowJS::performance);
		DKDuktape::AttachFunction("CPP_DKWindow_personalbar", 		DKWindowJS::personalbar);
		DKDuktape::AttachFunction("CPP_DKWindow_scheduler", 		DKWindowJS::scheduler);
		DKDuktape::AttachFunction("CPP_DKWindow_screen",			DKWindowJS::screen);
		DKDuktape::AttachFunction("CPP_DKWindow_screenX", 			DKWindowJS::screenX);
		DKDuktape::AttachFunction("CPP_DKWindow_screenY", 			DKWindowJS::screenY);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollbars", 		DKWindowJS::scrollbars);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollMaxX", 		DKWindowJS::scrollMaxX);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollMaxY", 		DKWindowJS::scrollMaxY);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollX", 			DKWindowJS::scrollX);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollY", 			DKWindowJS::scrollY);
		DKDuktape::AttachFunction("CPP_DKWindow_self", 				DKWindowJS::self);
		DKDuktape::AttachFunction("CPP_DKWindow_sessionStorage", 	DKWindowJS::sessionStorage);
		DKDuktape::AttachFunction("CPP_DKWindow_speechSynthesis",	DKWindowJS::speechSynthesis);
		DKDuktape::AttachFunction("CPP_DKWindow_statusbar", 		DKWindowJS::statusbar);
		DKDuktape::AttachFunction("CPP_DKWindow_toolbar", 			DKWindowJS::toolbar);
		DKDuktape::AttachFunction("CPP_DKWindow_top", 				DKWindowJS::top);
		DKDuktape::AttachFunction("CPP_DKWindow_visualViewport", 	DKWindowJS::visualViewport);
		DKDuktape::AttachFunction("CPP_DKWindow_window", 			DKWindowJS::window);
		//DKDuktape::AttachFunction("CPP_DKWindow_windows", 		DKWindowJS::windows);
	
		
		////// Deprecated properties //////
		
		
		////// Instance methods //////
		DKDuktape::AttachFunction("CPP_DKWindow_blur", 		DKWindowJS::blur);
		DKDuktape::AttachFunction("CPP_DKWindow_close",		DKWindowJS::close);
		DKDuktape::AttachFunction("CPP_DKWindow_dump", 		DKWindowJS::dump);
		DKDuktape::AttachFunction("CPP_DKWindow_focus", 	DKWindowJS::focus);
		DKDuktape::AttachFunction("CPP_DKWindow_moveBy", 	DKWindowJS::moveBy);
		DKDuktape::AttachFunction("CPP_DKWindow_moveTo", 	DKWindowJS::moveTo);
		DKDuktape::AttachFunction("CPP_DKWindow_resizeBy", 	DKWindowJS::resizeBy);
		DKDuktape::AttachFunction("CPP_DKWindow_resizeTo", 	DKWindowJS::resizeTo);
		
		
		////// Deprecated methods //////
		
		
		////// Load .js files
		DKClass::DKCreate("DKEventTargetTest/DKWindow.js");
		
		return true;
	}
	
	
	////// Constructor //////
	// [Event()] https://developer.mozilla.org/en-US/docs/Web/API/Event/Event
	static int constructor(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKINFO("CPP_DKWindow()\n");
		DKWindow* _window = new DKWindow();
		DKString eventTargetAddress = pointerToAddress(_window);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/caches
	static int caches(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->caches = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->caches.c_str());	
		return true;
	}
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	static int clientInformation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->caches = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->caches.c_str());	
		return true;
	}
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	static int closed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->closed = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->closed);	
		return true;
	}
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	static int console(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->console = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->console.c_str());	
		return true;
	}
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	static int credentialless(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->credentialless = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->credentialless);	
		return true;
	}
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	static int crypto(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->crypto = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->crypto.c_str());	
		return true;
	}
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	static int customElements(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->customElements = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->customElements.c_str());	
		return true;
	}
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	static int devicePixelRatio(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->devicePixelRatio = duk_to_number(ctx, 1);
		duk_push_number(ctx, eventTarget->devicePixelRatio);	
		return true;
	}
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	static int document(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->document = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->document.c_str());	
		return true;
	}
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	static int frameElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->frameElement = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->frameElement.c_str());	
		return true;
	}
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	static int frames(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->frames = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->frames.c_str());	
		return true;
	}
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	static int fullScreen(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->fullScreen = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->fullScreen);	
		return true;
	}
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	static int history(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->history = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->history.c_str());	
		return true;
	}
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	static int indexedDB(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->indexedDB = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->indexedDB.c_str());	
		return true;
	}
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	static int innerHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->innerHeight = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->innerHeight);	
		return true;
	}
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	static int innerWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->innerWidth = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->innerWidth);	
		return true;
	}
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	static int isSecureContext(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->isSecureContext = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->isSecureContext);	
		return true;
	}
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	static int launchQueue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->launchQueue = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->launchQueue.c_str());	
		return true;
	}
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->length = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->length);	
		return true;
	}
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->location = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->location.c_str());	
		return true;
	}
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	static int locationbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->locationbar = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->locationbar.c_str());	
		return true;
	}
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	static int localStorage(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->localStorage = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->localStorage.c_str());	
		return true;
	}
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	static int menubar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->menubar = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->menubar.c_str());	
		return true;
	}
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	static int mozInnerScreenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->mozInnerScreenX = duk_to_number(ctx, 1);
		duk_push_number(ctx, eventTarget->mozInnerScreenX);	
		return true;
	}
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	static int mozInnerScreenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->mozInnerScreenY = duk_to_number(ctx, 1);
		duk_push_number(ctx, eventTarget->mozInnerScreenY);	
		return true;
	}
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	static int name(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->name = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->name.c_str());	
		return true;
	}
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	static int navigation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->navigation = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->navigation.c_str());	
		return true;
	}
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	static int navigator(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->navigator = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->navigator.c_str());	
		return true;
	}
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	static int opener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->opener = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->opener.c_str());	
		return true;
	}
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	static int origin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->origin = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->origin.c_str());	
		return true;
	}
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	static int outerHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->outerHeight = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->outerHeight);	
		return true;
	}
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	static int outerWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->outerWidth = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->outerWidth);	
		return true;
	}
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	static int pageXOffset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->pageXOffset = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->pageXOffset);	
		return true;
	}
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	static int pageYOffset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->pageYOffset = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->pageYOffset);	
		return true;
	}
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	static int parent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->parent = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->parent.c_str());	
		return true;
	}
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	static int performance(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->performance = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->performance.c_str());	
		return true;
	}
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	static int personalbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->personalbar = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->personalbar.c_str());	
		return true;
	}
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	static int scheduler(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->scheduler = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->scheduler.c_str());	
		return true;
	}
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	static int screen(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->screen = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->screen.c_str());	
		return true;
	}
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	static int screenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->screenX = duk_to_int(ctx, 1);
		duk_push_int(ctx, eventTarget->screenX);	
		return true;
	}
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	static int screenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->screenY = duk_to_int(ctx, 1);
		duk_push_int(ctx, eventTarget->screenY);	
		return true;
	}
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	static int scrollbars(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->scrollbars = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->scrollbars.c_str());	
		return true;
	}
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	static int scrollMaxX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->scrollMaxX = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->scrollMaxX);	
		return true;
	}
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	static int scrollMaxY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->scrollMaxY = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->scrollMaxY);	
		return true;
	}
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	static int scrollX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->scrollX = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->scrollX);	
		return true;
	}
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	static int scrollY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->scrollY = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->scrollY);	
		return true;
	}
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	static int self(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->self = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->self.c_str());	
		return true;
	}
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	static int sessionStorage(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->sessionStorage = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->sessionStorage.c_str());	
		return true;
	}
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	static int speechSynthesis(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->speechSynthesis = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->speechSynthesis.c_str());	
		return true;
	}
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	static int statusbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->statusbar = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->statusbar.c_str());	
		return true;
	}
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	static int toolbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->toolbar = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->toolbar.c_str());	
		return true;
	}
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	static int top(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->top = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->top.c_str());	
		return true;
	}
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	static int visualViewport(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->visualViewport = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->visualViewport.c_str());	
		return true;
	}
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	static int window(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->window = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->window.c_str());	
		return true;
	}
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	/*
	static int windows(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->windows = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->windows.c_str());	
		return true;
	}
	*/
	
	
	////// Deprecated properties //////
	
	
	////// Instance methods //////
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int blur(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->blur())
			return DKERROR("blur() failed! \n");
		return true;
	}
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int close(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->close())
			return DKERROR("close() failed! \n");
		return true;
	}
	// [Window.dump()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int dump(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->dump())
			return DKERROR("dump() failed! \n");
		return true;
	}
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int focus(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->focus())
			return DKERROR("focus() failed! \n");
		return true;
	}
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int moveBy(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		int deltaX = duk_require_int(ctx, 1);
		int deltaY = duk_require_int(ctx, 2);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->moveBy(deltaX, deltaY))
			return DKERROR("moveBy() failed! \n");
		return true;
	}
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/moveTo
	static int moveTo(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		int x = duk_require_int(ctx, 1);
		int y = duk_require_int(ctx, 2);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->moveTo(x, y))
			return DKERROR("moveTo() failed! \n");
		return true;
	}
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/resizeBy
	static int resizeBy(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		int xDelta = duk_require_int(ctx, 1);
		int yDelta = duk_require_int(ctx, 2);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->resizeBy(xDelta, yDelta))
			return DKERROR("resizeBy() failed! \n");
		return true;
	}
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/resizeTo
	static int resizeTo(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		int width = duk_require_int(ctx, 1);
		int height = duk_require_int(ctx, 2);
		DKWindow* eventTarget = (DKWindow*)addressToPointer(eventTargetAddress);
		if(!eventTarget->resizeTo(width, height))
			return DKERROR("resizeTo() failed! \n");
		return true;
	}
	
	
	////// Deprecated methods //////
	
};
REGISTER_OBJECT(DKWindowJS, true)


#endif //DKWindowJS_H