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
