#include "DK/DKApp.h"
#include "DKDuktapeDom/DKDuktapeDom.h"

bool DKDuktapeDom::Init(){
	DKDEBUGFUNC();

	DKINFO("DKDuktapeDom::Init()");
	//Load the Duktape javascript DOM
	DKClass::DKCreate("DKEventTarget");
	DKClass::DKCreate("DKDuktapeDom/DKGlobalEventHandlers.js");
	DKClass::DKCreate("DKEvent");
	DKClass::DKCreate("DKUIEvent");
#ifndef IOS
    DKClass::DKCreate("DKKeyboardEvent");
#endif
	DKClass::DKCreate("DKDuktapeDom/DKWindow.js");
	DKClass::DKCreate("DKConsole");
	DKClass::DKCreate("DKNavigator");
	DKClass::DKCreate("DKScreen");
	DKClass::DKCreate("DKXMLHttpRequest");

	//create global window 
	duk_eval_string(dt->ctx, "var window = new Window('window')");
	duk_eval_string(dt->ctx,
		"({\n"
		"    print: this.print,\n"
		"    JSON: this.JSON,\n"
		"    eval: this.eval,\n"
		"    newGlobal: true,\n"
		"    window: this.window\n"
		"})\n");
		
	duk_eval_string(dt->ctx, "window.id = 'window'");
	duk_eval_string(dt->ctx, "console.log('window = '+window)");
	duk_eval_string(dt->ctx, "console.log('window.id = '+window.id)");
	
	duk_eval_string(dt->ctx, "var dk = new Object");
	duk_eval_string(dt->ctx, "window.dk = dk");
	duk_eval_string(dt->ctx, "console.log('dk = '+dk)");
		
	duk_eval_string(dt->ctx, "const DUKTAPE = true");
	duk_eval_string(dt->ctx, "window.DUKTAPE = DUKTAPE");
	duk_eval_string(dt->ctx, "console.log('DUKTAPE = '+DUKTAPE)");

	//Load the RmlUi Dom
	/*
	DKClass::DKCreate("DKDomEventTarget");
		DKClass::DKCreate("DKDom/DKDomGlobalEventHandlers.js");
		DKClass::DKCreate("DKDomXMLHttpRequestEventTarget");
			DKClass::DKCreate("DKDomXMLHttpRequest");
		DKClass::DKCreate("DKDomWindowEventHandlers");
		DKClass::DKCreate("DKDomEvent");
			DKClass::DKCreate("DKDomUIEvent");
			DKClass::DKCreate("DKDomKeyboardEvent");
			DKClass::DKCreate("DKDomMouseEvent");
		
		DKClass::DKCreate("DKDomNode");
			DKClass::DKCreate("DKDomElement");
				DKClass::DKCreate("DKDomHTMLElement");
				DKClass::DKCreate("DKDomHTMLCollection");
					DKClass::DKCreate("DKDomHTMLImageElement");
					DKClass::DKCreate("DKDomHTMLScriptElement");
					DKClass::DKCreate("DKDomHTMLSpanElement");
		DKClass::DKCreate("DKDomCSSStyleDeclaration");
		
		DKClass::DKCreate("DKDomWindowOrWorkerGlobalScope");
		DKClass::DKCreate("DKDomDocumentOrShadowRoot");
		DKClass::DKCreate("DKDomWindowOrWorkerGlobalScope");
		DKClass::DKCreate("DKDomWindow");
			DKClass::DKCreate("DKDomDocument");
			DKClass::DKCreate("DKDomConsole");
			DKClass::DKCreate("DKDomLocation");
			DKClass::DKCreate("DKDomNavigator");
			DKClass::DKCreate("DKDomScreen");
	*/
			
	return true;
}
