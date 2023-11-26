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
#include "DKDom/DKDom.h"

bool DKDom::Init(){
	DKDEBUGFUNC();

	//Load the Duktape javascript DOM
#ifdef DUKTAPE_DOM
	DKClass::DKCreate("DKEventTarget");
	DKClass::DKCreate("DKDuktape/DKGlobalEventHandlers.js");
	DKClass::DKCreate("DKEvent");
	DKClass::DKCreate("DKUIEvent");
#ifndef IOS
	DKClass::DKCreate("DKKeyboardEvent");
#endif
	DKClass::DKCreate("DKDuktape/DKWindow.js");
	DKClass::DKCreate("DKConsole");
	DKClass::DKCreate("DKNavigator");
	DKClass::DKCreate("DKScreen");
	DKClass::DKCreate("DKXMLHttpRequest");
#endif


	//Load the Duktape javascript DOM
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
			
		//DKClass::DKCreate("DKDomWindowOrWorkerGlobalScope");
		DKClass::DKCreate("DKDomDocumentOrShadowRoot");
		DKClass::DKCreate("DKDom/DKDomWindowOrWorkerGlobalScope.js");
		DKClass::DKCreate("DKDomWindow");
			DKClass::DKCreate("DKDomDocument");
			DKClass::DKCreate("DKDomConsole");
			DKClass::DKCreate("DKDomLocation");
			DKClass::DKCreate("DKDomNavigator");
			DKClass::DKCreate("DKDomScreen");
		
	return true;
}
