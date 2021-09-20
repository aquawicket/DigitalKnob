//https://developer.mozilla.org/en-US/docs/Web/API/Window

#include "DKRml/DKRml.h"
#include "DKDom/DKDomWindow.h"
#include "DKDom/DKDomElement.h"

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
	// Javascript bindings
	DKClass::DKCreate("DKDom/DKDomWindow.js");
	return true;
}

int DKDomWindow::closed(duk_context* ctx){
	return DKERROR("DKDomWindow::closed not implemented");
}

int DKDomWindow::console(duk_context* ctx){
	return DKERROR("DKDomWindow::console not implemented");
}

int DKDomWindow::controllers(duk_context* ctx){
	return DKERROR("DKDomWindow::controllers not implemented");
}

int DKDomWindow::customElements(duk_context* ctx){
	return DKERROR("DKDomWindow::customElements not implemented");
}

int DKDomWindow::crypto(duk_context* ctx){
	return DKERROR("DKDomWindow::crypto not implemented");
}

int DKDomWindow::devicePixelRatio(duk_context* ctx){
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

int DKDomWindow::document(duk_context* ctx){
	return DKERROR("DKDomWindow::document not implemented");
}

int DKDomWindow::DOMMatrix(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMMatrix not implemented");
}

int DKDomWindow::DOMMatrixReadOnly(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMMatrixReadOnly not implemented");
}

int DKDomWindow::DOMPoint(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMPoint not implemented");
}

int DKDomWindow::DOMPointReadOnly(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMPointReadOnly not implemented");
}

int DKDomWindow::DOMQuad(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMQuad not implemented");
}

int DKDomWindow::DOMRect(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMRect not implemented");
}

int DKDomWindow::DOMRectReadOnly(duk_context* ctx){
	return DKERROR("DKDomWindow::DOMRectReadOnly not implemented");
}

int DKDomWindow::event(duk_context* ctx){
	return DKERROR("DKDomWindow::event not implemented");
}

int DKDomWindow::frameElement(duk_context* ctx){
	return DKERROR("DKDomWindow::frameElement not implemented");
}

int DKDomWindow::frames(duk_context* ctx){
	return DKERROR("DKDomWindow::frames not implemented");
}

int DKDomWindow::fullscreen(duk_context* ctx){
	return DKERROR("DKDomWindow::fullscreen not implemented");
}

int DKDomWindow::history(duk_context* ctx){
	return DKERROR("DKDomWindow::history not implemented");
}

int DKDomWindow::innerHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int y = DKRml::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return true;
}

int DKDomWindow::innerWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int x = DKRml::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return true;
}

int DKDomWindow::isSecureContext(duk_context* ctx){
	return DKERROR("DKDomWindow::isSecureContext not implemented");
}

int DKDomWindow::length(duk_context* ctx){
	return DKERROR("DKDomWindow::length not implemented");
}

int DKDomWindow::location(duk_context* ctx){
	return DKERROR("DKDomWindow::location not implemented");
}

int DKDomWindow::locationbar(duk_context* ctx){
	return DKERROR("DKDomWindow::locationbar not implemented");
}

int DKDomWindow::locationStorage(duk_context* ctx){
	return DKERROR("DKDomWindow::locationStorage not implemented");
}

int DKDomWindow::menubar(duk_context* ctx){
	return DKERROR("DKDomWindow::menubar not implemented");
}

int DKDomWindow::messageManager(duk_context* ctx){
	return DKERROR("DKDomWindow::messageManager not implemented");
}

int DKDomWindow::mozInnerScreenX(duk_context* ctx){
	return DKERROR("DKDomWindow::mozInnerScreenX not implemented");
}

int DKDomWindow::mozInnerScreenY(duk_context* ctx){
	return DKERROR("DKDomWindow::mozInnerScreenY not implemented");
}

int DKDomWindow::name(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = DKRml::Get()->context->GetName();
	duk_push_string(ctx, name.c_str());
	return true;
}

int DKDomWindow::navigator(duk_context* ctx){
	return DKERROR("DKDomWindow::navigator not implemented");
}

int DKDomWindow::opener(duk_context* ctx){
	return DKERROR("DKDomWindow::opener not implemented");
}

int DKDomWindow::outterHeight(duk_context* ctx){
	return DKERROR("DKDomWindow::outterHeight not implemented");
}

int DKDomWindow::outterWidth(duk_context* ctx){
	return DKERROR("DKDomWindow::outterWidth not implemented");
}

int DKDomWindow::pageXOffset(duk_context* ctx){
	return DKERROR("DKDomWindow::pageXOffset not implemented");
}

int DKDomWindow::pageYOffset(duk_context* ctx){
	return DKERROR("DKDomWindow::pageYOffset not implemented");
}

int DKDomWindow::parent(duk_context* ctx){
	return DKERROR("DKDomWindow::parent not implemented");
}

int DKDomWindow::performance(duk_context* ctx){
	return DKERROR("DKDomWindow::performance not implemented");
}

int DKDomWindow::personalbar(duk_context* ctx){
	return DKERROR("DKDomWindow::personalbar not implemented");
}

int DKDomWindow::screen(duk_context* ctx){
	return DKERROR("DKDomWindow::screen not implemented");
}

int DKDomWindow::screenX(duk_context* ctx){
	return DKERROR("DKDomWindow::screenX not implemented");
}

int DKDomWindow::screenY(duk_context* ctx){
	return DKERROR("DKDomWindow::screenY not implemented");
}

int DKDomWindow::screenLeft(duk_context* ctx){
	return DKERROR("DKDomWindow::screenLeft not implemented");
}

int DKDomWindow::screenTop(duk_context* ctx){
	return DKERROR("DKDomWindow::screenTop not implemented");
}

int DKDomWindow::scrollbars(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollbars not implemented");
}

int DKDomWindow::scrollMaxX(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollMaxX not implemented");
}

int DKDomWindow::scrollMaxY(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollMaxY not implemented");
}

int DKDomWindow::scrollX(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollX not implemented");
}

int DKDomWindow::scrollY(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollY not implemented");
}

int DKDomWindow::self(duk_context* ctx){
	return DKERROR("DKDomWindow::self not implemented");
}

int DKDomWindow::sessionStroage(duk_context* ctx){
	return DKERROR("DKDomWindow::sessionStroage not implemented");
}

int DKDomWindow::sidebar(duk_context* ctx){
	return DKERROR("DKDomWindow::sidebar not implemented");
}

int DKDomWindow::speechSynthesis(duk_context* ctx){
	return DKERROR("DKDomWindow::speechSynthesis not implemented");
}

int DKDomWindow::status(duk_context* ctx){
	return DKERROR("DKDomWindow::status not implemented");
}

int DKDomWindow::statusbar(duk_context* ctx){
	return DKERROR("DKDomWindow::statusbar not implemented");
}

int DKDomWindow::toolbar(duk_context* ctx){
	return DKERROR("DKDomWindow::toolbar not implemented");
}

int DKDomWindow::top(duk_context* ctx){
	return DKERROR("DKDomWindow::top not implemented");
}

int DKDomWindow::visualViewport(duk_context* ctx){
	return DKERROR("DKDomWindow::visualViewport not implemented");
}

int DKDomWindow::window(duk_context* ctx){
	return DKERROR("DKDomWindow::window not implemented");
}

// Deprecated properties
int DKDomWindow::content(duk_context* ctx){
	return DKERROR("DKDomWindow::content not implemented");
}

int DKDomWindow::defaultStatus(duk_context* ctx){
	return DKERROR("DKDomWindow::defaultStatus not implemented");
}

int DKDomWindow::dialogArguments(duk_context* ctx){
	return DKERROR("DKDomWindow::dialogArguments not implemented");
}

int DKDomWindow::directories(duk_context* ctx){
	return DKERROR("DKDomWindow::directories not implemented");
}

int DKDomWindow::globalStorage(duk_context* ctx){
	return DKERROR("DKDomWindow::globalStorage not implemented");
}

int DKDomWindow::mozAnimationStartTime(duk_context* ctx){
	return DKERROR("DKDomWindow::mozAnimationStartTime not implemented");
}

int DKDomWindow::mozPaintCount(duk_context* ctx){
	return DKERROR("DKDomWindow::mozPaintCount not implemented");
}

int DKDomWindow::orientation(duk_context* ctx){
	return DKERROR("DKDomWindow::orientation not implemented");
}

int DKDomWindow::pkcs11(duk_context* ctx){
	return DKERROR("DKDomWindow::pkcs11 not implemented");
}

int DKDomWindow::returnValue(duk_context* ctx){
	return DKERROR("DKDomWindow::returnValue not implemented");
}

// Methods
int DKDomWindow::alert(duk_context* ctx){
	return DKERROR("DKDomWindow::alert not implemented");
}

int DKDomWindow::blur(duk_context* ctx){
	return DKERROR("DKDomWindow::blur not implemented");
}

int DKDomWindow::cancelAnimationFrame(duk_context* ctx){
	return DKERROR("DKDomWindow::cancelAnimationFrame not implemented");
}

int DKDomWindow::cancelIdleCallback(duk_context* ctx){
	return DKERROR("DKDomWindow::cancelIdleCallback not implemented");
}

int DKDomWindow::clearImmediate(duk_context* ctx){
	return DKERROR("DKDomWindow::clearImmediate not implemented");
}

int DKDomWindow::close(duk_context* ctx){
	return DKERROR("DKDomWindow::close not implemented");
}

int DKDomWindow::confirm(duk_context* ctx){
	return DKERROR("DKDomWindow::close not implemented");
}

int DKDomWindow::dump(duk_context* ctx){
	return DKERROR("DKDomWindow::dump not implemented");
}

int DKDomWindow::find(duk_context* ctx){
	return DKERROR("DKDomWindow::find not implemented");
}

int DKDomWindow::focus(duk_context* ctx){
	return DKERROR("DKDomWindow::focus not implemented");
}

int DKDomWindow::getComputedStyle(duk_context* ctx){
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = DKRml::addressToElement(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomCSSStyleDeclaration::getPropertyValue(): element invalid\n");
	}
	Rml::ComputedValues values = element->GetComputedValues();
	duk_push_undefined(ctx);
	return DKERROR("DKDomWindow::getComputedStyle not implemented");
}

int DKDomWindow::getDefaultComputedStyle(duk_context* ctx){
	return DKERROR("DKDomWindow::getDefaultComputedStyle not implemented");
}

int DKDomWindow::getSelection(duk_context* ctx){
	return DKERROR("DKDomWindow::getSelection not implemented");
}

int DKDomWindow::matchMedia(duk_context* ctx){
	return DKERROR("DKDomWindow::matchMedia not implemented");
}

int DKDomWindow::maximize(duk_context* ctx){
	return DKERROR("DKDomWindow::maximize not implemented");
}

int DKDomWindow::minimize(duk_context* ctx){
	return DKERROR("DKDomWindow::minimize not implemented");
}

int DKDomWindow::moveBy(duk_context* ctx){
	return DKERROR("DKDomWindow::moveBy not implemented");
}

int DKDomWindow::moveTo(duk_context* ctx){
	return DKERROR("DKDomWindow::moveTo not implemented");
}

int DKDomWindow::open(duk_context* ctx){
	return DKERROR("DKDomWindow::open not implemented");
}

int DKDomWindow::postMessage(duk_context* ctx){
	return DKERROR("DKDomWindow::postMessage not implemented");
}

int DKDomWindow::print(duk_context* ctx){
	return DKERROR("DKDomWindow::print not implemented");
}

int DKDomWindow::prompt(duk_context* ctx){
	return DKERROR("DKDomWindow::prompt not implemented");
}

int DKDomWindow::requestAnimationFrame(duk_context* ctx){
	return DKERROR("DKDomWindow::requestAnimationFrame not implemented");
}

int DKDomWindow::requestIdleCallback(duk_context* ctx){
	return DKERROR("DKDomWindow::requestIdleCallback not implemented");
}

int DKDomWindow::resizeBy(duk_context* ctx){
	return DKERROR("DKDomWindow::resizeBy not implemented");
}

int DKDomWindow::resizeTo(duk_context* ctx){
	return DKERROR("DKDomWindow::resizeTo not implemented");
}

int DKDomWindow::scroll(duk_context* ctx){
	return DKERROR("DKDomWindow::scroll not implemented");
}

int DKDomWindow::scrollBy(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollBy not implemented");
}

int DKDomWindow::scrollByLines(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollByLines not implemented");
}

int DKDomWindow::scrollByPages(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollByPages not implemented");
}

int DKDomWindow::scrollTo(duk_context* ctx){
	return DKERROR("DKDomWindow::scrollTo not implemented");
}

int DKDomWindow::setImmediate(duk_context* ctx){
	return DKERROR("DKDomWindow::setImmediate not implemented");
}

int DKDomWindow::setResizeable(duk_context* ctx){
	return DKERROR("DKDomWindow::setResizeable not implemented");
}

int DKDomWindow::sizeToContent(duk_context* ctx){
	return DKERROR("DKDomWindow::sizeToContent not implemented");
}

int DKDomWindow::stop(duk_context* ctx){
	return DKERROR("DKDomWindow::stop not implemented");
}

int DKDomWindow::updateCommands(duk_context* ctx){
	return DKERROR("DKDomWindow::updateCommands not implemented");
}

// Deprecated methods
int DKDomWindow::back(duk_context* ctx){
	return DKERROR("DKDomWindow::back not implemented");
}

int DKDomWindow::captureEvents(duk_context* ctx){
	return DKERROR("DKDomWindow::captureEvents not implemented");
}

int DKDomWindow::forward(duk_context* ctx){
	return DKERROR("DKDomWindow::forward not implemented");
}

int DKDomWindow::getAttention(duk_context* ctx){
	return DKERROR("DKDomWindow::getAttention not implemented");
}

int DKDomWindow::home(duk_context* ctx){
	return DKERROR("DKDomWindow::home not implemented");
}

int DKDomWindow::openDialog(duk_context* ctx){
	return DKERROR("DKDomWindow::openDialog not implemented");
}

int DKDomWindow::releaseEvents(duk_context* ctx){
	return DKERROR("DKDomWindow::releaseEvents not implemented");
}

int DKDomWindow::showModalDialog(duk_context* ctx){
	return DKERROR("DKDomWindow::showModalDialog not implemented");
}
