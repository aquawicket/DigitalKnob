#include "DK/DKApp.h"
#include "DKDom/DKDom.h"

bool DKDom::Init(){
	DKDEBUGFUNC();

	/*
	//Load the Duktape javascript DOM
		DKClass::DKCreate("DKDuktape/DKGlobalEventHandlers.js");
		DKClass::DKCreate("DKEventTarget");
			DKClass::DKCreate("DKEvent");
				DKClass::DKCreate("DKUIEvent");
				DKClass::DKCreate("DKKeyboardEvent");
			DKClass::DKCreate("DKDuktape/DKWindow.js");
				DKClass::DKCreate("DKConsole");
				DKClass::DKCreate("DKNavigator");
				DKClass::DKCreate("DKScreen");
				DKClass::DKCreate("DKXMLHttpRequest");
	*/			


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
			
			DKClass::DKCreate("DKDomWindowOrWorkerGlobalScope");
			DKClass::DKCreate("DKDomDocumentOrShadowRoot");
			DKClass::DKCreate("DKDomWindowOrWorkerGlobalScope");
			DKClass::DKCreate("DKDomWindow");
				DKClass::DKCreate("DKDomDocument");
				DKClass::DKCreate("DKDomConsole");
				DKClass::DKCreate("DKDomLocation");
				DKClass::DKCreate("DKDomNavigator");
				DKClass::DKCreate("DKDomScreen");
			
	return true;
}
