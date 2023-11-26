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

#include "DK/DKApp.h"
#include "DKDuktapeDom/DKDuktapeDom.h"


bool DKDuktapeDom::Init(){
	DKDEBUGFUNC();

	//DKINFO("DKDuktapeDom::Init()\n");
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
	DKDuktape* dt = DKDuktape::Get();
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
