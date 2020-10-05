//https://developer.mozilla.org/en-US/docs/Web/API/Window

#include "DKRml/DKRml.h"
#include "DKDom/DKDomWindow.h"
#include "DKDom/DKDomElement.h"


////////////////////////
bool DKDomWindow::Init()
{
	DKDEBUGFUNC();

	// Properties
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_closed", DKDomWindow::closed);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_console", DKDomWindow::console);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_controllers", DKDomWindow::controllers);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_customElements", DKDomWindow::customElements);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_crypto", DKDomWindow::crypto);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_devicePixelRatio", DKDomWindow::devicePixelRatio);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_document", DKDomWindow::document);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMMatrix", DKDomWindow::DOMMatrix);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMMatrixReadOnly", DKDomWindow::DOMMatrixReadOnly);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMPoint", DKDomWindow::DOMPoint);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMPointReadOnly", DKDomWindow::DOMPointReadOnly);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMQuad", DKDomWindow::DOMQuad);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMRect", DKDomWindow::DOMRect);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_DOMRectReadOnly", DKDomWindow::DOMRectReadOnly);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_event", DKDomWindow::event);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_frameElement", DKDomWindow::frameElement);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_frames", DKDomWindow::frames);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_fullscreen", DKDomWindow::fullscreen);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_history", DKDomWindow::history);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_innerHeight", DKDomWindow::innerHeight);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_innerWidth", DKDomWindow::innerWidth);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_isSecureContext", DKDomWindow::isSecureContext);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_length", DKDomWindow::length);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_location", DKDomWindow::location);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_locationbar", DKDomWindow::locationbar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_locationStorage", DKDomWindow::locationStorage);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_menubar", DKDomWindow::menubar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_messageManager", DKDomWindow::messageManager);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_mozInnerScreenX", DKDomWindow::mozInnerScreenX);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_mozInnerScreenY", DKDomWindow::mozInnerScreenY);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_name", DKDomWindow::name);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_navigator", DKDomWindow::navigator);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_opener", DKDomWindow::opener);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_outterHeight", DKDomWindow::outterHeight);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_outterWidth", DKDomWindow::outterWidth);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_pageXOffset", DKDomWindow::pageXOffset);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_pageYOffset", DKDomWindow::pageYOffset);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_parent", DKDomWindow::parent);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_performance", DKDomWindow::performance);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_personalbar", DKDomWindow::personalbar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_screen", DKDomWindow::screen);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_screenX", DKDomWindow::screenX);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_screenY", DKDomWindow::screenY);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_screenLeft", DKDomWindow::screenLeft);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_screenTop", DKDomWindow::screenTop);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollbars", DKDomWindow::scrollbars);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollMaxX", DKDomWindow::scrollMaxX);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollMaxY", DKDomWindow::scrollMaxY);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollX", DKDomWindow::scrollX);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollY", DKDomWindow::scrollY);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_self", DKDomWindow::self);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_sessionStroage", DKDomWindow::sessionStroage);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_sidebar", DKDomWindow::sidebar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_speechSynthesis", DKDomWindow::speechSynthesis);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_status", DKDomWindow::status);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_statusbar", DKDomWindow::statusbar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_toolbar", DKDomWindow::toolbar);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_top", DKDomWindow::top);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_visualViewport", DKDomWindow::visualViewport);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_window", DKDomWindow::window);

	// Deprecated properties
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_content", DKDomWindow::content);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_defaultStatus", DKDomWindow::defaultStatus);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_dialogArguments", DKDomWindow::dialogArguments);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_directories", DKDomWindow::directories);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_globalStorage", DKDomWindow::globalStorage);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_mozAnimationStartTime", DKDomWindow::mozAnimationStartTime);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_mozPaintCount", DKDomWindow::mozPaintCount);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_orientation", DKDomWindow::orientation);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_pkcs11", DKDomWindow::pkcs11);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_returnValue", DKDomWindow::returnValue);

	// Methods
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_alert", DKDomWindow::alert);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_blur", DKDomWindow::blur);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_cancelAnimationFrame", DKDomWindow::cancelAnimationFrame);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_cancelIdleCallback", DKDomWindow::cancelIdleCallback);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_clearImmediate", DKDomWindow::clearImmediate);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_close", DKDomWindow::close);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_confirm", DKDomWindow::confirm);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_dump", DKDomWindow::dump);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_find", DKDomWindow::find);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_focus", DKDomWindow::focus);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_getComputedStyle", DKDomWindow::getComputedStyle);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_getDefaultComputedStyle", DKDomWindow::getDefaultComputedStyle);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_getSelection", DKDomWindow::getSelection);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_matchMedia", DKDomWindow::matchMedia);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_maximize", DKDomWindow::maximize);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_minimize", DKDomWindow::minimize);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_moveBy", DKDomWindow::moveBy);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_moveTo", DKDomWindow::moveTo);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_open", DKDomWindow::open);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_postMessage", DKDomWindow::postMessage);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_print", DKDomWindow::print);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_prompt", DKDomWindow::prompt);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_requestAnimationFrame", DKDomWindow::requestAnimationFrame);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_requestIdleCallback", DKDomWindow::requestIdleCallback);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_resizeBy", DKDomWindow::resizeBy);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_resizeTo", DKDomWindow::resizeTo);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scroll", DKDomWindow::scroll);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollBy", DKDomWindow::scrollBy);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollByLines", DKDomWindow::scrollByLines);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollByPages", DKDomWindow::scrollByPages);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_scrollTo", DKDomWindow::scrollTo);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_setImmediate", DKDomWindow::setImmediate);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_setResizeable", DKDomWindow::setResizeable);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_sizeToContent", DKDomWindow::sizeToContent);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_stop", DKDomWindow::stop);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_updateCommands", DKDomWindow::updateCommands);

	// Deprecated methods
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_back", DKDomWindow::back);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_captureEvents", DKDomWindow::captureEvents);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_forward", DKDomWindow::forward);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_getAttention", DKDomWindow::getAttention);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_home", DKDomWindow::home);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_openDialog", DKDomWindow::openDialog);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_releaseEvents", DKDomWindow::releaseEvents);
	DKDuktape::AttachFunction("DKCPP_DKDomWindow_showModalDialog", DKDomWindow::showModalDialog);
	
	DKClass::DKCreate("DKDom/DKDomWindow.js");
	
	return true;
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

///////////////////////////////////////
int DKDomWindow::name(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = DKRml::Get()->context->GetName();
	duk_push_string(ctx, name.c_str());
	return 1;
}