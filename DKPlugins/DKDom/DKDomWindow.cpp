/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://developer.mozilla.org/en-US/docs/Web/API/Window

#include "DKDom/DKDom.h"
#include "DKDom/DKDomWindow.h"
#include "DKDom/DKDomElement.h"
#include "DKDuktape/DKDuktape.h"

WARNING_DISABLE
#include "duktape.h"
WARNING_DISABLE


/*
// https://github.com/svaarala/duktape/blob/master/tests/api/test-set-global-object.c
static void dump_global_object_keys(duk_context *ctx) {
	DKDEBUGFUNC(ctx);
	// Prints only non-enumerable keys.  We can't use Object.getOwnPropertyNames() here because we might not have 'Object' any more.
	duk_eval_string_noresult(ctx,
	"(function () {\n"
	"    for (var k in this) { print('key:', k); }\n"
	"})()\n");
}
*/

bool DKDomWindow::Init(){
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
	DKDuktape::AttachFunction("CPP_DKDomWindow_fullScreen", DKDomWindow::fullscreen);
	DKDuktape::AttachFunction("CPP_DKDomWindow_history", DKDomWindow::history);
	DKDuktape::AttachFunction("CPP_DKDomWindow_innerHeight", DKDomWindow::innerHeight);
	DKDuktape::AttachFunction("CPP_DKDomWindow_innerWidth", DKDomWindow::innerWidth);
	DKDuktape::AttachFunction("CPP_DKDomWindow_isSecureContext", DKDomWindow::isSecureContext);
	DKDuktape::AttachFunction("CPP_DKDomWindow_length", DKDomWindow::length);
	DKDuktape::AttachFunction("CPP_DKDomWindow_location", DKDomWindow::location);
	DKDuktape::AttachFunction("CPP_DKDomWindow_locationbar", DKDomWindow::locationbar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_localStorage", DKDomWindow::localStorage);
	DKDuktape::AttachFunction("CPP_DKDomWindow_menubar", DKDomWindow::menubar);
	DKDuktape::AttachFunction("CPP_DKDomWindow_messageManager", DKDomWindow::messageManager);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozInnerScreenX", DKDomWindow::mozInnerScreenX);
	DKDuktape::AttachFunction("CPP_DKDomWindow_mozInnerScreenY", DKDomWindow::mozInnerScreenY);
	DKDuktape::AttachFunction("CPP_DKDomWindow_name", DKDomWindow::name);
	DKDuktape::AttachFunction("CPP_DKDomWindow_navigator", DKDomWindow::navigator);
	DKDuktape::AttachFunction("CPP_DKDomWindow_opener", DKDomWindow::opener);
	DKDuktape::AttachFunction("CPP_DKDomWindow_outerHeight", DKDomWindow::outerHeight);
	DKDuktape::AttachFunction("CPP_DKDomWindow_outerWidth", DKDomWindow::outerWidth);
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
	DKDuktape::AttachFunction("CPP_DKDomWindow_sessionStorage", DKDomWindow::sessionStorage);
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

	/*
	// TEST GREATING A GLOBAL OBJECT, later to be used to create the global Window object
	// https://github.com/svaarala/duktape/blob/master/tests/api/test-set-global-object.c
	/////////////////////////////////////////////////////////////////////////////////////
	
    //First, build a new global object which contains a few keys we want to see.
	#include "DKDuktape.h"
	DKDuktape* dt = DKDuktape::Get();
	printf("build replacement global object\n");
	duk_eval_string(dt->ctx,
		"({\n"
		"    print: this.print,\n"
		"    JSON: this.JSON,\n"
		"    eval: this.eval,\n"
		"    newGlobal: true,\n"
		"    testName: 'my new global'\n"
		"})\n");

	printf("top before: %ld\n", (long)duk_get_top(dt->ctx));
	duk_set_global_object(dt->ctx);
	printf("top after: %ld\n", (long)duk_get_top(dt->ctx));

	//Print available keys.  This exercises access to the global object directly.
	dump_global_object_keys(dt->ctx);

	//Test that indirect eval executes in the new global object too.
	printf("indirect eval\n");
	duk_eval_string_noresult(dt->ctx,"var myEval = eval;  // writes 'myEval' to global object as a side effect\n");
	dump_global_object_keys(dt->ctx);
	duk_eval_string_noresult(dt->ctx,"myEval('print(this.newGlobal)');");

	// Test access to global object through an object environment.
	printf("access through this.xxx and variable lookup xxx\n");
	duk_eval_string_noresult(dt->ctx, "print('this.testName:', this.testName);\n");
	duk_eval_string_noresult(dt->ctx, "print('testName:', testName);\n");
	printf("final top: %ld\n", (long)duk_get_top(dt->ctx));

	///////////////////////////////////////////////////////////////////////////////
	*/

	// Javascript bindings
	DKClass::DKCreate("DKDom/DKDomWindow.js");
	
	//Create the global window object
	DKDuktape* dt = DKDuktape::Get();
	if(DKClass::DKValid("DKRml,DKRml0")) {
		Rml::Element* window = DKRml::Get()->document->GetContext()->GetRootElement(); //Root element that holds all the documents.
		DKString window_address = pointerToAddress(window);
		DKString var_window = "var window = new Window('" + window_address + "')";
		duk_eval_string(dt->ctx, var_window.c_str());
	}
	else{
		duk_eval_string(dt->ctx, "var window = new Window('window')");
	}

	//duk_eval_string(dt->ctx, "globalThis.window = window");
	duk_eval_string(dt->ctx,
		"({\n"
		"    print: this.print,\n"
		"    JSON: this.JSON,\n"
		"    eval: this.eval,\n"
		"    newGlobal: true,\n"
		"    window: this.window\n"
		"})\n");
	duk_eval_string(dt->ctx, "var dk = new Object");
	duk_eval_string(dt->ctx, "window.dk = dk");
	duk_eval_string(dt->ctx, "window.id = 'window'");
	duk_eval_string(dt->ctx, "const DUKTAPE = true");
	duk_eval_string(dt->ctx, "window.DUKTAPE = DUKTAPE");
	duk_eval_string(dt->ctx, "console.log('window = '+window)");
	duk_eval_string(dt->ctx, "console.log('window.id = '+window.id)");
	duk_eval_string(dt->ctx, "console.log('DUKTAPE = '+DUKTAPE)");
	return true;
}

int DKDomWindow::closed(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::console(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::controllers(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::customElements(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::crypto(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::devicePixelRatio(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	//get
	if (!duk_is_number(ctx, 1)) {
		float ratio = DKRml::Get()->context->GetDensityIndependentPixelRatio();
		duk_push_number(ctx, ratio);
		return true;
	}
	//set
	float ratio = (float)duk_require_number(ctx, 1);
	DKRml::Get()->context->SetDensityIndependentPixelRatio(ratio);
	return true;
}

int DKDomWindow::document(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMMatrix(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMMatrixReadOnly(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMPoint(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMPointReadOnly(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMQuad(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMRect(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::DOMRectReadOnly(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::event(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::frameElement(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::frames(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::fullscreen(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::history(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::innerHeight(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	int y = DKRml::Get()->context->GetDimensions().y;
	duk_push_int(ctx, y);
	return true;
}

int DKDomWindow::innerWidth(duk_context* ctx) {
	DKDEBUGFUNC(ctx);
	int x = DKRml::Get()->context->GetDimensions().x;
	duk_push_int(ctx, x);
	return true;
}

int DKDomWindow::isSecureContext(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::length(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::location(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::locationbar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::localStorage(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::menubar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::messageManager(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::mozInnerScreenX(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::mozInnerScreenY(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::name(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = DKRml::Get()->context->GetName();
	duk_push_string(ctx, name.c_str());
	return true;
}

int DKDomWindow::navigator(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::opener(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::outerHeight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::outerWidth(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::pageXOffset(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::pageYOffset(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::parent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::performance(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::personalbar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::screen(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::screenX(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::screenY(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::screenLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::screenTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollbars(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollMaxX(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollMaxY(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollX(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	duk_push_int(ctx, 0);
	DKERROR("not implemented\n");
	return true;
}

int DKDomWindow::scrollY(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	duk_push_int(ctx, 0);
	DKERROR("not implemented\n");
	return true;
}

int DKDomWindow::self(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::sessionStorage(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::sidebar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::speechSynthesis(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::status(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::statusbar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::toolbar(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::top(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::visualViewport(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::window(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

// Deprecated properties
int DKDomWindow::content(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::defaultStatus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::dialogArguments(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::directories(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::globalStorage(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::mozAnimationStartTime(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::mozPaintCount(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::orientation(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::pkcs11(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::returnValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

// Methods
int DKDomWindow::alert(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::blur(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");

	/*
	DKRml::Get()->document->Blur();
	return true;
	*/
}

int DKDomWindow::cancelAnimationFrame(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::cancelIdleCallback(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::clearImmediate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::close(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::confirm(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::dump(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::find(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::focus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

//TODO - finish implementation
// getComputedStyle: https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
int DKDomWindow::getComputedStyle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	Rml::Element* element = (Rml::Element*)addressToPointer(address);
	if (!element) {
		duk_push_undefined(ctx);
		return DKERROR("DKDomWindow::getComputedStyle(): element invalid\n");
	}
	//const Rml::ComputedValues& computedValues = element->GetComputedValues();
	duk_push_undefined(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::getDefaultComputedStyle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::getSelection(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::matchMedia(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::maximize(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::minimize(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::moveBy(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::moveTo(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::open(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::postMessage(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::print(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::prompt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::requestAnimationFrame(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::requestIdleCallback(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::resizeBy(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::resizeTo(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scroll(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollBy(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollByLines(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollByPages(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::scrollTo(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::setImmediate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::setResizeable(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::sizeToContent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::stop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::updateCommands(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

// Deprecated methods
int DKDomWindow::back(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::captureEvents(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::forward(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::getAttention(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::home(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::openDialog(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::releaseEvents(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}

int DKDomWindow::showModalDialog(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	return DKERROR("not implemented\n");
}
