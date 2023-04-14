#if HAVE_DKDuktape

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
		DKDuktape::AttachFunction("CPP_DKWindow_windows", 			DKWindowJS::windows);
	
		
		////// Deprecated properties //////
		DKDuktape::AttachFunction("CPP_DKWindow_content", 		DKWindowJS::content);
		DKDuktape::AttachFunction("CPP_DKWindow_defaultStatus", DKWindowJS::defaultStatus);
		DKDuktape::AttachFunction("CPP_DKWindow_event", 		DKWindowJS::event);
		DKDuktape::AttachFunction("CPP_DKWindow_external", 		DKWindowJS::external);
		DKDuktape::AttachFunction("CPP_DKWindow_orientation", 	DKWindowJS::orientation);
		DKDuktape::AttachFunction("CPP_DKWindow_returnValue", 	DKWindowJS::returnValue);
		DKDuktape::AttachFunction("CPP_DKWindow_sidebar", 		DKWindowJS::sidebar);
		DKDuktape::AttachFunction("CPP_DKWindow_status", 		DKWindowJS::status);
		
		
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
		DKClass::DKCreate("DKWindow/DKWindow.js");
		
		return true;
	}
	
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
		DKString _caches = GetString(ctx);
		if(!eventTarget(ctx)->caches(_caches, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _caches);
		return true;
	}
	// [Window.clientInformation](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	static int clientInformation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _clientInformation = GetString(ctx);
		if(!eventTarget(ctx)->clientInformation(_clientInformation, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _clientInformation);
		return true;
	}
	// [Window.closed](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/closed
	static int closed(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _closed = GetBool(ctx);
		if(!eventTarget(ctx)->closed(_closed, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _closed);
		return true;
	}
	// [Window.console](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/console
	static int console(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _console = GetString(ctx);
		if(!eventTarget(ctx)->console(_console, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _console);
		return true;
	}
	// [Window.credentialless](Read only)(Experimental)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/credentialless
	static int credentialless(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _credentialless = GetBool(ctx);
		if(!eventTarget(ctx)->credentialless(_credentialless, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _credentialless);
		return true;
	}
	// [Window.crypto](Read only) https://developer.mozilla.org/en-US/docs/Web/API/crypto_property
	static int crypto(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _crypto = GetString(ctx);
		if(!eventTarget(ctx)->crypto(_crypto, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _crypto);
		return true;
	}
	// [Window.customElements](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/customElements
	static int customElements(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _customElements = GetString(ctx);
		if(!eventTarget(ctx)->customElements(_customElements, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _customElements);
		return true;
	}
	// [Window.devicePixelRatio](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/devicePixelRatio
	static int devicePixelRatio(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		double _devicePixelRatio = GetDouble(ctx);
		if(!eventTarget(ctx)->devicePixelRatio(_devicePixelRatio, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _devicePixelRatio);
		return true;
	}
	// [Window.document](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/document
	static int document(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _document = GetString(ctx);
		if(!eventTarget(ctx)->document(_document, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _document);
		return true;
	}
	// [Window.frameElement](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frameElement
	static int frameElement(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _frameElement = GetString(ctx);
		if(!eventTarget(ctx)->frameElement(_frameElement, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _frameElement);
		return true;
	}
	// [Window.frames](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/frames
	static int frames(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _frames = GetString(ctx);
		if(!eventTarget(ctx)->frames(_frames, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _frames);
		return true;
	}
	// [Window.fullScreen](Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/fullScreen
	static int fullScreen(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _fullScreen = GetBool(ctx);
		if(!eventTarget(ctx)->fullScreen(_fullScreen, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _fullScreen);
		return true;
	}
	// [Window.history](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/History
	static int history(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _history = GetString(ctx);
		if(!eventTarget(ctx)->history(_history, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _history);
		return true;
	}
	// [Window.indexedDB](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/indexedDB
	static int indexedDB(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _indexedDB = GetString(ctx);
		if(!eventTarget(ctx)->indexedDB(_indexedDB, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _indexedDB);
		return true;
	}
	// [Window.innerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerHeight
	static int innerHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _innerHeight = GetUint(ctx);
		if(!eventTarget(ctx)->innerHeight(_innerHeight, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _innerHeight);
		return true;
	}
	// [Window.innerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/innerWidth
	static int innerWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _innerWidth = GetUint(ctx);
		if(!eventTarget(ctx)->innerWidth(_innerWidth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _innerWidth);
		return true;
	}
	// [Window.isSecureContext](Read only) https://developer.mozilla.org/en-US/docs/Web/API/isSecureContext
	static int isSecureContext(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		bool _isSecureContext = GetBool(ctx);
		if(!eventTarget(ctx)->isSecureContext(_isSecureContext, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _isSecureContext);
		return true;
	}
	// [Window.launchQueue](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/launchQueue
	static int launchQueue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _launchQueue = GetString(ctx);
		if(!eventTarget(ctx)->launchQueue(_launchQueue, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _launchQueue);
		return true;
	}
	// [Window.length](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/length
	static int length(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _length = GetUint(ctx);
		if(!eventTarget(ctx)->length(_length, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _length);
		return true;
	}
	// [Window.location] https://developer.mozilla.org/en-US/docs/Web/API/Window/location
	static int location(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _location = GetString(ctx);
		if(!eventTarget(ctx)->location(_location, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _location);
		return true;
	}
	// [Window.locationbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/locationbar
	static int locationbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _locationbar = GetString(ctx);
		if(!eventTarget(ctx)->locationbar(_locationbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _locationbar);
		return true;
	}
	// [Window.localStorage](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
	static int localStorage(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _localStorage = GetString(ctx);
		if(!eventTarget(ctx)->localStorage(_localStorage, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _localStorage);
		return true;
	}
	// [Window.menubar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/menubar
	static int menubar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _menubar = GetString(ctx);
		if(!eventTarget(ctx)->menubar(_menubar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _menubar);
		return true;
	}
	// [Window.mozInnerScreenX](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenX
	static int mozInnerScreenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		double _mozInnerScreenX = GetDouble(ctx);
		if(!eventTarget(ctx)->mozInnerScreenX(_mozInnerScreenX, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _mozInnerScreenX);
		return true;
	}
	// [Window.mozInnerScreenY](Read only)(Non-standard) https://developer.mozilla.org/en-US/docs/Web/API/Window/mozInnerScreenY
	static int mozInnerScreenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		double _mozInnerScreenY = GetDouble(ctx);
		if(!eventTarget(ctx)->mozInnerScreenY(_mozInnerScreenY, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _mozInnerScreenY);
		return true;
	}
	// [Window.name] https://developer.mozilla.org/en-US/docs/Web/API/Window/name
	static int name(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _name = GetString(ctx);
		if(!eventTarget(ctx)->name(_name, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _name);
		return true;
	}
	// [Window.navigation](Read only)(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigation
	static int navigation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _name = GetString(ctx);
		if(!eventTarget(ctx)->name(_name, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _name);
		return true;
	}
	// [Window.navigator](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
	static int navigator(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _navigator = GetString(ctx);
		if(!eventTarget(ctx)->navigator(_navigator, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _navigator);
		return true;
	}
	// [Window.opener] https://developer.mozilla.org/en-US/docs/Web/API/Window/opener
	static int opener(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _opener = GetString(ctx);
		if(!eventTarget(ctx)->opener(_opener, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _opener);
		return true;
	}
	// [Window.origin](Read only) https://developer.mozilla.org/en-US/docs/Web/API/origin
	static int origin(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _origin = GetString(ctx);
		if(!eventTarget(ctx)->origin(_origin, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _origin);
		return true;
	}
	// [Window.outerHeight](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerHeight
	static int outerHeight(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _outerHeight = GetUint(ctx);
		if(!eventTarget(ctx)->outerHeight(_outerHeight, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _outerHeight);
		return true;
	}
	// [Window.outerWidth](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/outerWidth
	static int outerWidth(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _outerWidth = GetUint(ctx);
		if(!eventTarget(ctx)->outerWidth(_outerWidth, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _outerWidth);
		return true;
	}
	// [Window.pageXOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageXOffset
	static int pageXOffset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _pageXOffset = GetUint(ctx);
		if(!eventTarget(ctx)->pageXOffset(_pageXOffset, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _pageXOffset);
		return true;
	}
	// [Window.pageYOffset](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/pageYOffset
	static int pageYOffset(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _pageYOffset = GetUint(ctx);
		if(!eventTarget(ctx)->pageYOffset(_pageYOffset, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _pageYOffset);
		return true;
	}
	// [Window.parent](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/parent
	static int parent(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _parent = GetString(ctx);
		if(!eventTarget(ctx)->parent(_parent, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _parent);
		return true;
	}
	// [Window.performance](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/performance
	static int performance(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _performance = GetString(ctx);
		if(!eventTarget(ctx)->performance(_performance, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _performance);
		return true;
	}
	// [Window.personalbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/personalbar
	static int personalbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _personalbar = GetString(ctx);
		if(!eventTarget(ctx)->personalbar(_personalbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _personalbar);
		return true;
	}
	// [Window.scheduler](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scheduler
	static int scheduler(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _scheduler = GetString(ctx);
		if(!eventTarget(ctx)->scheduler(_scheduler, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scheduler);
		return true;
	}
	// [Window.screen](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screen
	static int screen(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _screen = GetString(ctx);
		if(!eventTarget(ctx)->screen(_screen, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _screen);
		return true;
	}
	// [Window.screenX and Window.screenLeft](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenX
	static int screenX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _screenX = GetInt(ctx);
		if(!eventTarget(ctx)->screenX(_screenX, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _screenX);
		return true;
	}
	// [Window.screenY and Window.screenTop](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/screenY
	static int screenY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _screenY = GetInt(ctx);
		if(!eventTarget(ctx)->screenY(_screenY, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _screenY);
		return true;
	}
	// [Window.scrollbars](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollbars
	static int scrollbars(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _scrollbars = GetString(ctx);
		if(!eventTarget(ctx)->scrollbars(_scrollbars, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollbars);
		return true;
	}
	// [Window.scrollMaxX](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxX
	static int scrollMaxX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _scrollMaxX = GetUint(ctx);
		if(!eventTarget(ctx)->scrollMaxX(_scrollMaxX, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollMaxX);
		return true;
	}
	// [Window.scrollMaxY](Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollMaxY
	static int scrollMaxY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _scrollMaxY = GetUint(ctx);
		if(!eventTarget(ctx)->scrollMaxY(_scrollMaxY, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollMaxY);
		return true;
	}
	// [Window.scrollX](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollX
	static int scrollX(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _scrollX = GetUint(ctx);
		if(!eventTarget(ctx)->scrollX(_scrollX, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollX);
		return true;
	}
	// [Window.scrollY](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/scrollY
	static int scrollY(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		unsigned int _scrollY = GetUint(ctx);
		if(!eventTarget(ctx)->scrollY(_scrollY, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _scrollY);
		return true;
	}
	// [Window.self](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/self
	static int self(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _self = GetString(ctx);
		if(!eventTarget(ctx)->self(_self, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _self);
		return true;
	}
	// [Window.sessionStorage] https://developer.mozilla.org/en-US/docs/Web/API/Window/sessionStorage
	static int sessionStorage(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _sessionStorage = GetString(ctx);
		if(!eventTarget(ctx)->sessionStorage(_sessionStorage, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _sessionStorage);
		return true;
	}
	// [Window.speechSynthesis](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/speechSynthesis
	static int speechSynthesis(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _speechSynthesis = GetString(ctx);
		if(!eventTarget(ctx)->speechSynthesis(_speechSynthesis, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _speechSynthesis);
		return true;
	}
	// [Window.statusbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/statusbar
	static int statusbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _statusbar = GetString(ctx);
		if(!eventTarget(ctx)->statusbar(_statusbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _statusbar);
		return true;
	}
	// [Window.toolbar](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/toolbar
	static int toolbar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _toolbar = GetString(ctx);
		if(!eventTarget(ctx)->toolbar(_toolbar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _toolbar);
		return true;
	}
	// [Window.top](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/top
	static int top(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _top = GetString(ctx);
		if(!eventTarget(ctx)->top(_top, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _top);
		return true;
	}
	// [Window.visualViewport](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/visualViewport
	static int visualViewport(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _visualViewport = GetString(ctx);
		if(!eventTarget(ctx)->visualViewport(_visualViewport, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _visualViewport);
		return true;
	}
	// [Window.window](Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/window
	static int window(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _window = GetString(ctx);
		if(!eventTarget(ctx)->window(_window, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _window);
		return true;
	}
	// [window[0], window[1], etc.] https://developer.mozilla.org/en-US/docs/Web/API/Window
	static int windows(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _windows = GetString(ctx);
		if(!eventTarget(ctx)->windows(_windows, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _windows);
		return true;
	}
	
	
	////// Deprecated properties //////
	// [Window.content and Window._content](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window
	static int content(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _content = GetString(ctx);
		if(!eventTarget(ctx)->content(_content, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _content);
		return true;
	}
	// [Window.defaultStatus](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/defaultStatus
	static int defaultStatus(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _defaultStatus = GetString(ctx);
		if(!eventTarget(ctx)->defaultStatus(_defaultStatus, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _defaultStatus);
		return true;
	}
	// [Window.event](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/event
	static int event(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _event = GetString(ctx);
		if(!eventTarget(ctx)->event(_event, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _event);
		return true;
	}
	// [Window.external](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/external
	static int external(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _external = GetString(ctx);
		if(!eventTarget(ctx)->external(_external, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _external);
		return true;
	}
	// [Window.orientation](Deprecated)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/orientation
	static int orientation(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int _orientation = GetInt(ctx);
		if(!eventTarget(ctx)->orientation(_orientation, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _orientation);
		return true;
	}
	// [Window.returnValue](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window
	static int returnValue(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _returnValue = GetString(ctx);
		if(!eventTarget(ctx)->returnValue(_returnValue, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _returnValue);
		return true;
	}
	// [Window.sidebar](Deprecated)(Non-standard)(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Window/sidebar
	static int sidebar(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _sidebar = GetString(ctx);
		if(!eventTarget(ctx)->sidebar(_sidebar, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _sidebar);
		return true;
	}
	// [Window.status](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/status
	static int status(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString _status = GetString(ctx);
		if(!eventTarget(ctx)->status(_status, duk_is_valid_index(ctx, 1)))
			return false;
		dukglue_push(ctx, _status);
		return true;
	}
	
	
	////// Instance methods //////
	// [Window.blur()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int blur(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->blur())
			return false;
		return true;
	}
	// [Window.close()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int close(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->close())
			return false;
		return true;
	}
	// [Window.dump()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int dump(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString message = duk_require_string(ctx, 1);
		if(!eventTarget(ctx)->dump(message))
			return false;
		return true;
	}
	// [Window.focus()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int focus(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->focus())
			return false;
		return true;
	}
	// [Window.moveBy()] https://developer.mozilla.org/en-US/docs/Web/API/moveBy
	static int moveBy(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int deltaX = duk_require_int(ctx, 1);
		int deltaY = duk_require_int(ctx, 2);
		if(!eventTarget(ctx)->moveBy(deltaX, deltaY))
			return false;
		return true;
	}
	// [Window.moveTo()] https://developer.mozilla.org/en-US/docs/Web/API/moveTo
	static int moveTo(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int x = duk_require_int(ctx, 1);
		int y = duk_require_int(ctx, 2);
		if(!eventTarget(ctx)->moveTo(x, y))
			return false;
		return true;
	}
	// [Window.resizeBy()] https://developer.mozilla.org/en-US/docs/Web/API/resizeBy
	static int resizeBy(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int xDelta = duk_require_int(ctx, 1);
		int yDelta = duk_require_int(ctx, 2);
		if(!eventTarget(ctx)->resizeBy(xDelta, yDelta))
			return false;
		return true;
	}
	// [Window.resizeTo()] https://developer.mozilla.org/en-US/docs/Web/API/resizeTo
	static int resizeTo(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		int width = duk_require_int(ctx, 1);
		int height = duk_require_int(ctx, 2);
		if(!eventTarget(ctx)->resizeTo(width, height))
			return false;
		return true;
	}
	
	
	////// Deprecated methods //////
	// [Window.back()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/back
	static int back(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->back())
			return false;
		return true;
	}
	// [Window.captureEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/captureEvents
	static int captureEvents(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->captureEvents())
			return false;
		return true;
	}
	// [Window.forward()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/forward
	static int forward(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->forward())
			return false;
		return true;
	}
	// [Window.releaseEvents()](Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/releaseEvents
	static int releaseEvents(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		DKString eventType = duk_require_string(ctx, 1);
		if(!eventTarget(ctx)->releaseEvents(eventType))
			return false;
		return true;
	}
	// [Window.showModalDialog()](Non-standard)(Deprecated) https://developer.mozilla.org/en-US/docs/Web/API/Window/showModalDialog
	static int showModalDialog(duk_context* ctx){
		DKDEBUGFUNC(ctx);
		if(!eventTarget(ctx)->showModalDialog())
			return false;
		return true;
	}
	
};
REGISTER_OBJECT(DKWindowJS, true)


#endif //DKWindowJS_H
#endif //HAVE_DKDuktape