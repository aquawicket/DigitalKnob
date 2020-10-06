//https://developer.mozilla.org/en-US/docs/Web/API/Window

#include "DKRml/DKRml.h"
#include "DKDom/DKDomWindow.h"
#include "DKDom/DKDomElement.h"


////////////////////////
bool DKDomWindow::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("CPP_DKDomWindow_closed", DKDomWindow::closed);
	DKDuktape::AttachFunction("CPP_DKDomWindow_console", DKDomWindow::console);
	DKDuktape::AttachFunction("CPP_DKDomWindow_controllers", DKDomWindow::controllers);
	DKDuktape::AttachFunction("CPP_DKDomWindow_customElements", DKDomWindow::customElements);
	DKDuktape::AttachFunction("CPP_DKDomWindow_crypto", DKDomWindow::crypto);
	DKDuktape::AttachFunction("CPP_DKDomWindow_devicePixelRatio", DKDomWindow::devicePixelRatio);
	DKDuktape::AttachFunction("CPP_DKDomWindow_document", DKDomWindow::document);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMMatrix", DKDomWindow::DOMMatrix);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMMatrixReadOnly", DKDomWindow::DOMMatrixReadOnly);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMPoint", DKDomWindow::DOMPoint);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMPointReadOnly", DKDomWindow::DOMPointReadOnly);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMQuad", DKDomWindow::DOMQuad);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMRect", DKDomWindow::DOMRect);
	DKDuktape::AttachFunction("CPP_DKDomWindow_DOMRectReadOnly", DKDomWindow::DOMRectReadOnly);
	DKDuktape::AttachFunction("CPP_DKDomWindow_event", DKDomWindow::event);
	DKDuktape::AttachFunction("CPP_DKDomWindow_frameElement", DKDomWindow::frameElement);
	DKDuktape::AttachFunction("CPP_DKDomWindow_frames", DKDomWindow::frames);
	DKDuktape::AttachFunction("CPP_DKDomWindow_fullscreen", DKDomWindow::fullscreen);
	DKDuktape::AttachFunction("CPP_DKDomWindow_history", DKDomWindow::history);
	DKDuktape::AttachFunction("CPP_DKDomWindow_innerHeight", DKDomWindow::innerHeight);
	DKDuktape::AttachFunction("CPP_DKDomWindow_innerWidth", DKDomWindow::innerWidth);
	DKDuktape::AttachFunction("CPP_DKDomWindow_isSecureContext", DKDomWindow::isSecureContext);
	DKDuktape::AttachFunction("CPP_DKDomWindow_length", DKDomWindow::length);
	DKDuktape::AttachFunction("CPP_DKDomWindow_location", DKDomWindow::location);
	DKDuktape::AttachFunction("CPP_DKDomWindow_locationbar", DKDomWindow::locationbar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_locationStorage", DKDomWindow::locationStorage);
	DKDuktape::AttachFunction("CPP_DKDomWindow_menubar", DKDomWindow::menubar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_messageManager", DKDomWindow::messageManager);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozInnerScreenX", DKDomWindow::mozInnerScreenX);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozInnerScreenY", DKDomWindow::mozInnerScreenY);
	DKDuktape::AttachFunction("CPP_DKDomWindow_name", DKDomWindow::name);
	DKDuktape::AttachFunction("CPP_DKDomWindow_navigator", DKDomWindow::navigator);
	DKDuktape::AttachFunction("CPP_DKDomWindow_opener", DKDomWindow::opener);
	DKDuktape::AttachFunction("CPP_DKDomWindow_outterHeight", DKDomWindow::outterHeight);
	DKDuktape::AttachFunction("CPP_DKDomWindow_outterWidth", DKDomWindow::outterWidth);
	DKDuktape::AttachFunction("CPP_DKDomWindow_pageXOffset", DKDomWindow::pageXOffset);
	DKDuktape::AttachFunction("CPP_DKDomWindow_pageYOffset", DKDomWindow::pageYOffset);
	DKDuktape::AttachFunction("CPP_DKDomWindow_parent", DKDomWindow::parent);
	DKDuktape::AttachFunction("CPP_DKDomWindow_performance", DKDomWindow::performance);
	DKDuktape::AttachFunction("CPP_DKDomWindow_personalbar", DKDomWindow::personalbar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_screen", DKDomWindow::screen);
	DKDuktape::AttachFunction("CPP_DKDomWindow_screenX", DKDomWindow::screenX);
	DKDuktape::AttachFunction("CPP_DKDomWindow_screenY", DKDomWindow::screenY);
	DKDuktape::AttachFunction("CPP_DKDomWindow_screenLeft", DKDomWindow::screenLeft);
	DKDuktape::AttachFunction("CPP_DKDomWindow_screenTop", DKDomWindow::screenTop);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollbars", DKDomWindow::scrollbars);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollMaxX", DKDomWindow::scrollMaxX);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollMaxY", DKDomWindow::scrollMaxY);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollX", DKDomWindow::scrollX);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollY", DKDomWindow::scrollY);
	DKDuktape::AttachFunction("CPP_DKDomWindow_self", DKDomWindow::self);
	DKDuktape::AttachFunction("CPP_DKDomWindow_sessionStroage", DKDomWindow::sessionStroage);
	DKDuktape::AttachFunction("CPP_DKDomWindow_sidebar", DKDomWindow::sidebar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_speechSynthesis", DKDomWindow::speechSynthesis);
	DKDuktape::AttachFunction("CPP_DKDomWindow_status", DKDomWindow::status);
	DKDuktape::AttachFunction("CPP_DKDomWindow_statusbar", DKDomWindow::statusbar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_toolbar", DKDomWindow::toolbar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_top", DKDomWindow::top);
	DKDuktape::AttachFunction("CPP_DKDomWindow_visualViewport", DKDomWindow::visualViewport);
	DKDuktape::AttachFunction("CPP_DKDomWindow_window", DKDomWindow::window);

	// Deprecated properties
	DKDuktape::AttachFunction("CPP_DKDomWindow_content", DKDomWindow::content);
	DKDuktape::AttachFunction("CPP_DKDomWindow_defaultStatus", DKDomWindow::defaultStatus);
	DKDuktape::AttachFunction("CPP_DKDomWindow_dialogArguments", DKDomWindow::dialogArguments);
	DKDuktape::AttachFunction("CPP_DKDomWindow_directories", DKDomWindow::directories);
	DKDuktape::AttachFunction("CPP_DKDomWindow_globalStorage", DKDomWindow::globalStorage);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozAnimationStartTime", DKDomWindow::mozAnimationStartTime);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozPaintCount", DKDomWindow::mozPaintCount);
	DKDuktape::AttachFunction("CPP_DKDomWindow_orientation", DKDomWindow::orientation);
	DKDuktape::AttachFunction("CPP_DKDomWindow_pkcs11", DKDomWindow::pkcs11);
	DKDuktape::AttachFunction("CPP_DKDomWindow_returnValue", DKDomWindow::returnValue);

	// Methods
	DKDuktape::AttachFunction("CPP_DKDomWindow_alert", DKDomWindow::alert);
	DKDuktape::AttachFunction("CPP_DKDomWindow_blur", DKDomWindow::blur);
	DKDuktape::AttachFunction("CPP_DKDomWindow_cancelAnimationFrame", DKDomWindow::cancelAnimationFrame);
	DKDuktape::AttachFunction("CPP_DKDomWindow_cancelIdleCallback", DKDomWindow::cancelIdleCallback);
	DKDuktape::AttachFunction("CPP_DKDomWindow_clearImmediate", DKDomWindow::clearImmediate);
	DKDuktape::AttachFunction("CPP_DKDomWindow_close", DKDomWindow::close);
	DKDuktape::AttachFunction("CPP_DKDomWindow_confirm", DKDomWindow::confirm);
	DKDuktape::AttachFunction("CPP_DKDomWindow_dump", DKDomWindow::dump);
	DKDuktape::AttachFunction("CPP_DKDomWindow_find", DKDomWindow::find);
	DKDuktape::AttachFunction("CPP_DKDomWindow_focus", DKDomWindow::focus);
	DKDuktape::AttachFunction("CPP_DKDomWindow_getComputedStyle", DKDomWindow::getComputedStyle);
	DKDuktape::AttachFunction("CPP_DKDomWindow_getDefaultComputedStyle", DKDomWindow::getDefaultComputedStyle);
	DKDuktape::AttachFunction("CPP_DKDomWindow_getSelection", DKDomWindow::getSelection);
	DKDuktape::AttachFunction("CPP_DKDomWindow_matchMedia", DKDomWindow::matchMedia);
	DKDuktape::AttachFunction("CPP_DKDomWindow_maximize", DKDomWindow::maximize);
	DKDuktape::AttachFunction("CPP_DKDomWindow_minimize", DKDomWindow::minimize);
	DKDuktape::AttachFunction("CPP_DKDomWindow_moveBy", DKDomWindow::moveBy);
	DKDuktape::AttachFunction("CPP_DKDomWindow_moveTo", DKDomWindow::moveTo);
	DKDuktape::AttachFunction("CPP_DKDomWindow_open", DKDomWindow::open);
	DKDuktape::AttachFunction("CPP_DKDomWindow_postMessage", DKDomWindow::postMessage);
	DKDuktape::AttachFunction("CPP_DKDomWindow_print", DKDomWindow::print);
	DKDuktape::AttachFunction("CPP_DKDomWindow_prompt", DKDomWindow::prompt);
	DKDuktape::AttachFunction("CPP_DKDomWindow_requestAnimationFrame", DKDomWindow::requestAnimationFrame);
	DKDuktape::AttachFunction("CPP_DKDomWindow_requestIdleCallback", DKDomWindow::requestIdleCallback);
	DKDuktape::AttachFunction("CPP_DKDomWindow_resizeBy", DKDomWindow::resizeBy);
	DKDuktape::AttachFunction("CPP_DKDomWindow_resizeTo", DKDomWindow::resizeTo);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scroll", DKDomWindow::scroll);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollBy", DKDomWindow::scrollBy);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollByLines", DKDomWindow::scrollByLines);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollByPages", DKDomWindow::scrollByPages);
	DKDuktape::AttachFunction("CPP_DKDomWindow_scrollTo", DKDomWindow::scrollTo);
	DKDuktape::AttachFunction("CPP_DKDomWindow_setImmediate", DKDomWindow::setImmediate);
	DKDuktape::AttachFunction("CPP_DKDomWindow_setResizeable", DKDomWindow::setResizeable);
	DKDuktape::AttachFunction("CPP_DKDomWindow_sizeToContent", DKDomWindow::sizeToContent);
	DKDuktape::AttachFunction("CPP_DKDomWindow_stop", DKDomWindow::stop);
	DKDuktape::AttachFunction("CPP_DKDomWindow_updateCommands", DKDomWindow::updateCommands);

	// Deprecated methods
	DKDuktape::AttachFunction("CPP_DKDomWindow_back", DKDomWindow::back);
	DKDuktape::AttachFunction("CPP_DKDomWindow_captureEvents", DKDomWindow::captureEvents);
	DKDuktape::AttachFunction("CPP_DKDomWindow_forward", DKDomWindow::forward);
	DKDuktape::AttachFunction("CPP_DKDomWindow_getAttention", DKDomWindow::getAttention);
	DKDuktape::AttachFunction("CPP_DKDomWindow_home", DKDomWindow::home);
	DKDuktape::AttachFunction("CPP_DKDomWindow_openDialog", DKDomWindow::openDialog);
	DKDuktape::AttachFunction("CPP_DKDomWindow_releaseEvents", DKDomWindow::releaseEvents);
	DKDuktape::AttachFunction("CPP_DKDomWindow_showModalDialog", DKDomWindow::showModalDialog);
	
	DKClass::DKCreate("DKDom/DKDomWindow.js");
	
	return true;
}


/////////////////////////////////////////
int DKDomWindow::closed(duk_context* ctx)
{
	DKERROR("DKDomWindow::closed not implemented");
	return false;
}

//////////////////////////////////////////
int DKDomWindow::console(duk_context* ctx)
{
	DKERROR("DKDomWindow::console not implemented");
	return false;
}

//////////////////////////////////////////////
int DKDomWindow::controllers(duk_context* ctx)
{
	DKERROR("DKDomWindow::controllers not implemented");
	return false;
}

/////////////////////////////////////////////////
int DKDomWindow::customElements(duk_context* ctx)
{
	DKERROR("DKDomWindow::customElements not implemented");
	return false;
}

/////////////////////////////////////////
int DKDomWindow::crypto(duk_context* ctx)
{
	DKERROR("DKDomWindow::crypto not implemented");
	return false;
}

///////////////////////////////////////////////////
int DKDomWindow::devicePixelRatio(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);

	//get
	if (!duk_is_number(ctx, 1)) {
		float ratio = DKRml::Get()->context->GetDensityIndependentPixelRatio();
		duk_push_number(ctx, ratio);
		return true;
	}
	//set
	float ratio = duk_require_number(ctx, 1);
	DKRml::Get()->context->SetDensityIndependentPixelRatio(ratio);
	return true;
}

///////////////////////////////////////////
int DKDomWindow::document(duk_context* ctx)
{
	DKERROR("DKDomWindow::document not implemented");
	return false;
}

////////////////////////////////////////////
int DKDomWindow::DOMMatrix(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMMatrix not implemented");
	return false;
}

////////////////////////////////////////////////////
int DKDomWindow::DOMMatrixReadOnly(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMMatrixReadOnly not implemented");
	return false;
}

///////////////////////////////////////////
int DKDomWindow::DOMPoint(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMPoint not implemented");
	return false;
}

///////////////////////////////////////////////////
int DKDomWindow::DOMPointReadOnly(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMPointReadOnly not implemented");
	return false;
}

//////////////////////////////////////////
int DKDomWindow::DOMQuad(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMQuad not implemented");
	return false;
}

//////////////////////////////////////////
int DKDomWindow::DOMRect(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMRect not implemented");
	return false;
}

//////////////////////////////////////////////////
int DKDomWindow::DOMRectReadOnly(duk_context* ctx)
{
	DKERROR("DKDomWindow::DOMRectReadOnly not implemented");
	return false;
}

////////////////////////////////////////
int DKDomWindow::event(duk_context* ctx)
{
	DKERROR("DKDomWindow::event not implemented");
	return false;
}

///////////////////////////////////////////////
int DKDomWindow::frameElement(duk_context* ctx)
{
	DKERROR("DKDomWindow::frameElement not implemented");
	return false;
}

/////////////////////////////////////////
int DKDomWindow::frames(duk_context* ctx)
{
	DKERROR("DKDomWindow::frames not implemented");
	return false;
}

/////////////////////////////////////////////
int DKDomWindow::fullscreen(duk_context* ctx)
{
	DKERROR("DKDomWindow::fullscreen not implemented");
	return false;
}

//////////////////////////////////////////
int DKDomWindow::history(duk_context* ctx)
{
	DKERROR("DKDomWindow::history not implemented");
	return false;
}

//////////////////////////////////////////////
int DKDomWindow::innerHeight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int y = DKRml::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return 1;
}

/////////////////////////////////////////////
int DKDomWindow::innerWidth(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int x = DKRml::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return 1;
}

//////////////////////////////////////////////////
int DKDomWindow::isSecureContext(duk_context* ctx)
{
	DKERROR("DKDomWindow::isSecureContext not implemented");
	return false;
}

/////////////////////////////////////////
int DKDomWindow::length(duk_context* ctx)
{
	DKERROR("DKDomWindow::length not implemented");
	return false;
}

///////////////////////////////////////////
int DKDomWindow::location(duk_context* ctx)
{
	DKERROR("DKDomWindow::location not implemented");
	return false;
}

//////////////////////////////////////////////
int DKDomWindow::locationbar(duk_context* ctx)
{
	DKERROR("DKDomWindow::locationbar not implemented");
	return false;
}

//////////////////////////////////////////////////
int DKDomWindow::locationStorage(duk_context* ctx)
{
	DKERROR("DKDomWindow::locationStorage not implemented");
	return false;
}

//////////////////////////////////////////
int DKDomWindow::menubar(duk_context* ctx)
{
	DKERROR("DKDomWindow::menubar not implemented");
	return false;
}

/////////////////////////////////////////////////
int DKDomWindow::messageManager(duk_context* ctx)
{
	DKERROR("DKDomWindow::messageManager not implemented");
	return false;
}

//////////////////////////////////////////////////
int DKDomWindow::mozInnerScreenX(duk_context* ctx)
{
	DKERROR("DKDomWindow::mozInnerScreenX not implemented");
	return false;
}

//////////////////////////////////////////////////
int DKDomWindow::mozInnerScreenY(duk_context* ctx)
{
	DKERROR("DKDomWindow::mozInnerScreenY not implemented");
	return false;
}

///////////////////////////////////////
int DKDomWindow::name(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = DKRml::Get()->context->GetName();
	duk_push_string(ctx, name.c_str());
	return 1;
}

int DKDomWindow::navigator(duk_context* ctx)
{
	DKERROR("DKDomWindow::navigator not implemented");
	return false;
}

int DKDomWindow::opener(duk_context* ctx)
{
	DKERROR("DKDomWindow::opener not implemented");
	return false;
}

int DKDomWindow::outterHeight(duk_context* ctx)
{
	DKERROR("DKDomWindow::outterHeight not implemented");
	return false;
}

int DKDomWindow::outterWidth(duk_context* ctx)
{
	DKERROR("DKDomWindow::outterWidth not implemented");
	return false;
}

int DKDomWindow::pageXOffset(duk_context* ctx)
{
	DKERROR("DKDomWindow::pageXOffset not implemented");
	return false;
}

int DKDomWindow::pageYOffset(duk_context* ctx)
{
	DKERROR("DKDomWindow::pageYOffset not implemented");
	return false;
}

int DKDomWindow::parent(duk_context* ctx)
{
	DKERROR("DKDomWindow::parent not implemented");
	return false;
}

int DKDomWindow::performance(duk_context* ctx)
{
	DKERROR("DKDomWindow::performance not implemented");
	return false;
}

int DKDomWindow::personalbar(duk_context* ctx)
{
	DKERROR("DKDomWindow::personalbar not implemented");
	return false;
}

int DKDomWindow::screen(duk_context* ctx)
{
	DKERROR("DKDomWindow::screen not implemented");
	return false;
}

int DKDomWindow::screenX(duk_context* ctx)
{
	DKERROR("DKDomWindow::screenX not implemented");
	return false;
}

int DKDomWindow::screenY(duk_context* ctx)
{
	DKERROR("DKDomWindow::screenY not implemented");
	return false;
}

int DKDomWindow::screenLeft(duk_context* ctx)
{
	DKERROR("DKDomWindow::screenLeft not implemented");
	return false;
}

int DKDomWindow::screenTop(duk_context* ctx)
{
	DKERROR("DKDomWindow::screenTop not implemented");
	return false;
}

int DKDomWindow::scrollbars(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollbars not implemented");
	return false;
}

int DKDomWindow::scrollMaxX(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollMaxX not implemented");
	return false;
}

int DKDomWindow::scrollMaxY(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollMaxY not implemented");
	return false;
}

int DKDomWindow::scrollX(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollX not implemented");
	return false;
}

int DKDomWindow::scrollY(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollY not implemented");
	return false;
}

int DKDomWindow::self(duk_context* ctx)
{
	DKERROR("DKDomWindow::self not implemented");
	return false;
}

int DKDomWindow::sessionStroage(duk_context* ctx)
{
	DKERROR("DKDomWindow::sessionStroage not implemented");
	return false;
}

int DKDomWindow::sidebar(duk_context* ctx)
{
	DKERROR("DKDomWindow::sidebar not implemented");
	return false;
}

int DKDomWindow::speechSynthesis(duk_context* ctx)
{
	DKERROR("DKDomWindow::speechSynthesis not implemented");
	return false;
}

int DKDomWindow::status(duk_context* ctx)
{
	DKERROR("DKDomWindow::status not implemented");
	return false;
}

int DKDomWindow::statusbar(duk_context* ctx)
{
	DKERROR("DKDomWindow::statusbar not implemented");
	return false;
}

int DKDomWindow::toolbar(duk_context* ctx)
{
	DKERROR("DKDomWindow::toolbar not implemented");
	return false;
}

int DKDomWindow::top(duk_context* ctx)
{
	DKERROR("DKDomWindow::top not implemented");
	return false;
}

int DKDomWindow::visualViewport(duk_context* ctx)
{
	DKERROR("DKDomWindow::visualViewport not implemented");
	return false;
}

int DKDomWindow::window(duk_context* ctx)
{
	DKERROR("DKDomWindow::window not implemented");
	return false;
}


// Deprecated properties
int DKDomWindow::content(duk_context* ctx)
{
	DKERROR("DKDomWindow::content not implemented");
	return false;
}

int DKDomWindow::defaultStatus(duk_context* ctx)
{
	DKERROR("DKDomWindow::defaultStatus not implemented");
	return false;
}

int DKDomWindow::dialogArguments(duk_context* ctx)
{
	DKERROR("DKDomWindow::dialogArguments not implemented");
	return false;
}

int DKDomWindow::directories(duk_context* ctx)
{
	DKERROR("DKDomWindow::directories not implemented");
	return false;
}

int DKDomWindow::globalStorage(duk_context* ctx)
{
	DKERROR("DKDomWindow::globalStorage not implemented");
	return false;
}

int DKDomWindow::mozAnimationStartTime(duk_context* ctx)
{
	DKERROR("DKDomWindow::mozAnimationStartTime not implemented");
	return false;
}

int DKDomWindow::mozPaintCount(duk_context* ctx)
{
	DKERROR("DKDomWindow::mozPaintCount not implemented");
	return false;
}

int DKDomWindow::orientation(duk_context* ctx)
{
	DKERROR("DKDomWindow::orientation not implemented");
	return false;
}

int DKDomWindow::pkcs11(duk_context* ctx)
{
	DKERROR("DKDomWindow::pkcs11 not implemented");
	return false;
}

int DKDomWindow::returnValue(duk_context* ctx)
{
	DKERROR("DKDomWindow::returnValue not implemented");
	return false;
}


// Methods
int DKDomWindow::alert(duk_context* ctx)
{
	DKERROR("DKDomWindow::alert not implemented");
	return false;
}

int DKDomWindow::blur(duk_context* ctx)
{
	DKERROR("DKDomWindow::blur not implemented");
	return false;
}

int DKDomWindow::cancelAnimationFrame(duk_context* ctx)
{
	DKERROR("DKDomWindow::cancelAnimationFrame not implemented");
	return false;
}

int DKDomWindow::cancelIdleCallback(duk_context* ctx)
{
	DKERROR("DKDomWindow::cancelIdleCallback not implemented");
	return false;
}

int DKDomWindow::clearImmediate(duk_context* ctx)
{
	DKERROR("DKDomWindow::clearImmediate not implemented");
	return false;
}

int DKDomWindow::close(duk_context* ctx)
{
	DKERROR("DKDomWindow::close not implemented");
	return false;
}

int DKDomWindow::confirm(duk_context* ctx)
{
	DKERROR("DKDomWindow::close not implemented");
	return false;
}

int DKDomWindow::dump(duk_context* ctx)
{
	DKERROR("DKDomWindow::dump not implemented");
	return false;
}

int DKDomWindow::find(duk_context* ctx)
{
	DKERROR("DKDomWindow::find not implemented");
	return false;
}

int DKDomWindow::focus(duk_context* ctx)
{
	DKERROR("DKDomWindow::focus not implemented");
	return false;
}

int DKDomWindow::getComputedStyle(duk_context* ctx)
{
	DKERROR("DKDomWindow::getComputedStyle not implemented");
	return false;
}

int DKDomWindow::getDefaultComputedStyle(duk_context* ctx)
{
	DKERROR("DKDomWindow::getDefaultComputedStyle not implemented");
	return false;
}

int DKDomWindow::getSelection(duk_context* ctx)
{
	DKERROR("DKDomWindow::getSelection not implemented");
	return false;
}

int DKDomWindow::matchMedia(duk_context* ctx)
{
	DKERROR("DKDomWindow::matchMedia not implemented");
	return false;
}

int DKDomWindow::maximize(duk_context* ctx)
{
	DKERROR("DKDomWindow::maximize not implemented");
	return false;
}

int DKDomWindow::minimize(duk_context* ctx)
{
	DKERROR("DKDomWindow::minimize not implemented");
	return false;
}

int DKDomWindow::moveBy(duk_context* ctx)
{
	DKERROR("DKDomWindow::moveBy not implemented");
	return false;
}

int DKDomWindow::moveTo(duk_context* ctx)
{
	DKERROR("DKDomWindow::moveTo not implemented");
	return false;
}

int DKDomWindow::open(duk_context* ctx)
{
	DKERROR("DKDomWindow::open not implemented");
	return false;
}

int DKDomWindow::postMessage(duk_context* ctx)
{
	DKERROR("DKDomWindow::postMessage not implemented");
	return false;
}

int DKDomWindow::print(duk_context* ctx)
{
	DKERROR("DKDomWindow::print not implemented");
	return false;
}

int DKDomWindow::prompt(duk_context* ctx)
{
	DKERROR("DKDomWindow::prompt not implemented");
	return false;
}

int DKDomWindow::requestAnimationFrame(duk_context* ctx)
{
	DKERROR("DKDomWindow::requestAnimationFrame not implemented");
	return false;
}

int DKDomWindow::requestIdleCallback(duk_context* ctx)
{
	DKERROR("DKDomWindow::requestIdleCallback not implemented");
	return false;
}

int DKDomWindow::resizeBy(duk_context* ctx)
{
	DKERROR("DKDomWindow::resizeBy not implemented");
	return false;
}

int DKDomWindow::resizeTo(duk_context* ctx)
{
	DKERROR("DKDomWindow::resizeTo not implemented");
	return false;
}

int DKDomWindow::scroll(duk_context* ctx)
{
	DKERROR("DKDomWindow::scroll not implemented");
	return false;
}

int DKDomWindow::scrollBy(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollBy not implemented");
	return false;
}

int DKDomWindow::scrollByLines(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollByLines not implemented");
	return false;
}

int DKDomWindow::scrollByPages(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollByPages not implemented");
	return false;
}

int DKDomWindow::scrollTo(duk_context* ctx)
{
	DKERROR("DKDomWindow::scrollTo not implemented");
	return false;
}

int DKDomWindow::setImmediate(duk_context* ctx)
{
	DKERROR("DKDomWindow::setImmediate not implemented");
	return false;
}

int DKDomWindow::setResizeable(duk_context* ctx)
{
	DKERROR("DKDomWindow::setResizeable not implemented");
	return false;
}

int DKDomWindow::sizeToContent(duk_context* ctx)
{
	DKERROR("DKDomWindow::sizeToContent not implemented");
	return false;
}

int DKDomWindow::stop(duk_context* ctx)
{
	DKERROR("DKDomWindow::stop not implemented");
	return false;
}

int DKDomWindow::updateCommands(duk_context* ctx)
{
	DKERROR("DKDomWindow::updateCommands not implemented");
	return false;
}


// Deprecated methods
int DKDomWindow::back(duk_context* ctx)
{
	DKERROR("DKDomWindow::back not implemented");
	return false;
}

int DKDomWindow::captureEvents(duk_context* ctx)
{
	DKERROR("DKDomWindow::captureEvents not implemented");
	return false;
}

int DKDomWindow::forward(duk_context* ctx)
{
	DKERROR("DKDomWindow::forward not implemented");
	return false;
}

int DKDomWindow::getAttention(duk_context* ctx)
{
	DKERROR("DKDomWindow::getAttention not implemented");
	return false;
}

int DKDomWindow::home(duk_context* ctx)
{
	DKERROR("DKDomWindow::home not implemented");
	return false;
}

int DKDomWindow::openDialog(duk_context* ctx)
{
	DKERROR("DKDomWindow::openDialog not implemented");
	return false;
}

int DKDomWindow::releaseEvents(duk_context* ctx)
{
	DKERROR("DKDomWindow::releaseEvents not implemented");
	return false;
}

int DKDomWindow::showModalDialog(duk_context* ctx)
{
	DKERROR("DKDomWindow::showModalDialog not implemented");
	return false;
}
