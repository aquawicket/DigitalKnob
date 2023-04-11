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
		DKDuktape::AttachFunction("CPP_DKWindow_caches", DKWindowJS::caches);
		DKDuktape::AttachFunction("CPP_DKWindow_clientInformation", DKWindowJS::clientInformation);
		DKDuktape::AttachFunction("CPP_DKWindow_closed", DKWindowJS::closed);
		DKDuktape::AttachFunction("CPP_DKWindow_console", DKWindowJS::console);
		DKDuktape::AttachFunction("CPP_DKWindow_credentialless", DKWindowJS::credentialless);
		DKDuktape::AttachFunction("CPP_DKWindow_crypto", DKWindowJS::crypto);
		DKDuktape::AttachFunction("CPP_DKWindow_customElements", DKWindowJS::customElements);
		DKDuktape::AttachFunction("CPP_DKWindow_devicePixelRatio", DKWindowJS::devicePixelRatio);
		DKDuktape::AttachFunction("CPP_DKWindow_document", DKWindowJS::document);
		DKDuktape::AttachFunction("CPP_DKWindow_frameElement", DKWindowJS::frameElement);
		DKDuktape::AttachFunction("CPP_DKWindow_frames", DKWindowJS::frames);
		DKDuktape::AttachFunction("CPP_DKWindow_fullScreen", DKWindowJS::fullScreen);
		DKDuktape::AttachFunction("CPP_DKWindow_history", DKWindowJS::history);
		DKDuktape::AttachFunction("CPP_DKWindow_indexedDB", DKWindowJS::indexedDB);
		DKDuktape::AttachFunction("CPP_DKWindow_innerHeight", DKWindowJS::innerHeight);
		DKDuktape::AttachFunction("CPP_DKWindow_innerWidth", DKWindowJS::innerWidth);
		DKDuktape::AttachFunction("CPP_DKWindow_isSecureContext", DKWindowJS::isSecureContext);
		/*
		DKDuktape::AttachFunction("CPP_DKWindow_launchQueue", DKWindowJS::launchQueue);
		DKDuktape::AttachFunction("CPP_DKWindow_length", DKWindowJS::length);
		DKDuktape::AttachFunction("CPP_DKWindow_location", DKWindowJS::location);
		DKDuktape::AttachFunction("CPP_DKWindow_locationbar", DKWindowJS::locationbar);
		DKDuktape::AttachFunction("CPP_DKWindow_localStorage", DKWindowJS::localStorage);
		DKDuktape::AttachFunction("CPP_DKWindow_menubar", DKWindowJS::menubar);
		DKDuktape::AttachFunction("CPP_DKWindow_mozInnerScreenX", DKWindowJS::mozInnerScreenX);
		DKDuktape::AttachFunction("CPP_DKWindow_mozInnerScreenY", DKWindowJS::mozInnerScreenY);
		DKDuktape::AttachFunction("CPP_DKWindow_name", DKWindowJS::name);
		DKDuktape::AttachFunction("CPP_DKWindow_navigation", DKWindowJS::navigation);
		DKDuktape::AttachFunction("CPP_DKWindow_navigator", DKWindowJS::navigator);
		DKDuktape::AttachFunction("CPP_DKWindow_opener", DKWindowJS::opener);
		DKDuktape::AttachFunction("CPP_DKWindow_origin", DKWindowJS::origin);
		DKDuktape::AttachFunction("CPP_DKWindow_outerHeight", DKWindowJS::outerHeight);
		DKDuktape::AttachFunction("CPP_DKWindow_outerWidth", DKWindowJS::outerWidth);
		DKDuktape::AttachFunction("CPP_DKWindow_pageXOffset", DKWindowJS::pageXOffset);
		DKDuktape::AttachFunction("CPP_DKWindow_pageYOffset", DKWindowJS::pageYOffset);
		DKDuktape::AttachFunction("CPP_DKWindow_parent", DKWindowJS::parent);
		DKDuktape::AttachFunction("CPP_DKWindow_performance", DKWindowJS::performance);
		DKDuktape::AttachFunction("CPP_DKWindow_personalbar", DKWindowJS::personalbar);
		DKDuktape::AttachFunction("CPP_DKWindow_scheduler", DKWindowJS::scheduler);
		DKDuktape::AttachFunction("CPP_DKWindow_screen", DKWindowJS::screen);
		DKDuktape::AttachFunction("CPP_DKWindow_screenX", DKWindowJS::screenX);
		DKDuktape::AttachFunction("CPP_DKWindow_screenY", DKWindowJS::screenY);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollbars", DKWindowJS::scrollbars);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollMaxX", DKWindowJS::scrollMaxX);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollMaxY", DKWindowJS::scrollMaxY);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollX", DKWindowJS::scrollX);
		DKDuktape::AttachFunction("CPP_DKWindow_scrollY", DKWindowJS::scrollY);
		DKDuktape::AttachFunction("CPP_DKWindow_self", DKWindowJS::self);
		DKDuktape::AttachFunction("CPP_DKWindow_sessionStorage", DKWindowJS::sessionStorage);
		DKDuktape::AttachFunction("CPP_DKWindow_speechSynthesis", DKWindowJS::speechSynthesis);
		DKDuktape::AttachFunction("CPP_DKWindow_statusbar", DKWindowJS::statusbar);
		DKDuktape::AttachFunction("CPP_DKWindow_toolbar", DKWindowJS::toolbar);
		DKDuktape::AttachFunction("CPP_DKWindow_top", DKWindowJS::top);
		DKDuktape::AttachFunction("CPP_DKWindow_visualViewport", DKWindowJS::visualViewport);
		DKDuktape::AttachFunction("CPP_DKWindow_window", DKWindowJS::window);
		DKDuktape::AttachFunction("CPP_DKWindow_windows", DKWindowJS::windows);
		*/
	
		
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
		DKString eventTargetAddress = DKDuktape::pointerToAddress(_window);
		duk_push_string(ctx, eventTargetAddress.c_str());	
		return true;
	}
	
	
	////// Instance properties //////
	// [Window.caches](Read only) https://developer.mozilla.org/en-US/docs/Web/API/caches
	static int caches(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->caches = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->caches.c_str());	
		return true;
	}
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	static int clientInformation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->caches = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->caches.c_str());	
		return true;
	}
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	static int closed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->closed = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->closed);	
		return true;
	}
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	static int console(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->console = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->console.c_str());	
		return true;
	}
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	static int credentialless(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->credentialless = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->credentialless);	
		return true;
	}
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	static int crypto(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->crypto = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->crypto.c_str());	
		return true;
	}
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	static int customElements(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->customElements = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->customElements.c_str());	
		return true;
	}
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	static int devicePixelRatio(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->devicePixelRatio = duk_to_number(ctx, 1);
		duk_push_number(ctx, eventTarget->devicePixelRatio);	
		return true;
	}
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	static int document(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->document = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->document.c_str());	
		return true;
	}
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	static int frameElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->frameElement = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->frameElement.c_str());	
		return true;
	}
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	static int frames(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->frames = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->frames.c_str());	
		return true;
	}
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	static int fullScreen(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->fullScreen = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->fullScreen);	
		return true;
	}
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	static int history(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->history = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->history.c_str());	
		return true;
	}
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	static int indexedDB(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_string(ctx, 1))
			eventTarget->indexedDB = duk_to_string(ctx, 1);
		duk_push_string(ctx, eventTarget->indexedDB.c_str());	
		return true;
	}
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	static int innerHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->innerHeight = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->innerHeight);	
		return true;
	}
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	static int innerWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_number(ctx, 1))
			eventTarget->innerWidth = duk_to_uint(ctx, 1);
		duk_push_uint(ctx, eventTarget->innerWidth);	
		return true;
	}
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	static int isSecureContext(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventTargetAddress = duk_require_string(ctx, 0);
		DKWindow* eventTarget = (DKWindow*)DKDuktape::addressToPointer(eventTargetAddress);
		if (duk_is_boolean(ctx, 1))
			eventTarget->isSecureContext = duk_to_boolean(ctx, 1);
		duk_push_boolean(ctx, eventTarget->isSecureContext);	
		return true;
	}
	
	
};
REGISTER_OBJECT(DKWindowJS, true)


#endif //DKWindowJS_H