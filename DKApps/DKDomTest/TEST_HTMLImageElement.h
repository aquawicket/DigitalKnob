// [IDL] https://html.spec.whatwg.org/multipage/embedded-content.html#htmlimageelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#pragma once
#ifndef TEST_HTMLImageElement_H
#define TEST_HTMLImageElement_H

#include "DKHTMLImageElement/DKHTMLImageElement.h"


class TEST_HTMLImageElement : public DKObjectT<TEST_HTMLImageElement>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_HTMLImageElement.h //////");
		
		DKHTMLImageElement htmlImageElement;
		printHTMLImageElementProperties(htmlImageElement);
		return true;
	}

	static void printHTMLImageElementProperties(DKHTMLImageElement& htmlImageElement){
		DKDEBUGFUNC(htmlImageElement);
		
		// [HTMLConstructor] constructor();
		// function
		
		// [CEReactions] attribute DOMString alt;
		DKConsole::log("htmlImageElement.alt() = "			+toString(htmlImageElement.alt()));
		
		// [CEReactions] attribute USVString src;
		DKConsole::log("htmlImageElement.src() = "			+toString(htmlImageElement.src()));
		
		// [CEReactions] attribute USVString srcset;
		DKConsole::log("htmlImageElement.srcset() = "		+toString(htmlImageElement.srcset()));
		
		// [CEReactions] attribute DOMString sizes;
		DKConsole::log("htmlImageElement.sizes() = "		+toString(htmlImageElement.sizes()));
		
		// [CEReactions] attribute DOMString? crossOrigin;
		DKConsole::log("htmlImageElement.crossOrigin() = "	+toString(htmlImageElement.crossOrigin()));
		
		// [CEReactions] attribute DOMString useMap;
		DKConsole::log("htmlImageElement.useMap() = "		+toString(htmlImageElement.useMap()));
		
		// [CEReactions] attribute boolean isMap;
		DKConsole::log("htmlImageElement.isMap() = "		+toString(htmlImageElement.isMap()));
		
		// [CEReactions] attribute unsigned long width;
		DKConsole::log("htmlImageElement.width() = "		+toString(htmlImageElement.width()));
		
		// [CEReactions] attribute unsigned long height;
		DKConsole::log("htmlImageElement.height() = "		+toString(htmlImageElement.height()));
		
		// readonly attribute unsigned long naturalWidth;
		DKConsole::log("htmlImageElement.naturalWidth() = "	+toString(htmlImageElement.naturalWidth()));
		
		// readonly attribute unsigned long naturalHeight;
		DKConsole::log("htmlImageElement.naturalHeight() = "+toString(htmlImageElement.naturalHeight()));
		
		// readonly attribute boolean complete;
		DKConsole::log("htmlImageElement.complete() = "		+toString(htmlImageElement.complete()));
		
		// readonly attribute USVString currentSrc;
		DKConsole::log("htmlImageElement.currentSrc() = "	+toString(htmlImageElement.currentSrc()));
		
		// [CEReactions] attribute DOMString referrerPolicy;
		DKConsole::log("htmlImageElement.referrerPolicy() = "+toString(htmlImageElement.referrerPolicy()));
		
		// [CEReactions] attribute DOMString decoding;
		DKConsole::log("htmlImageElement.decoding() = "		+toString(htmlImageElement.decoding()));
		
		// [CEReactions] attribute DOMString loading;
		DKConsole::log("htmlImageElement.loading() = "		+toString(htmlImageElement.loading()));
		
		// [CEReactions] attribute DOMString fetchPriority;
		DKConsole::log("htmlImageElement.fetchPriority() = "+toString(htmlImageElement.fetchPriority()));
		
		// Promise<undefined> decode();
		// function

		// also has obsolete members
	//};
	
		TEST_HTMLElement::printHTMLElementProperties(dynamic_cast<DKHTMLElement&>(htmlImageElement));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_HTMLImageElement, true);


#endif //TEST_HTMLImageElement_H