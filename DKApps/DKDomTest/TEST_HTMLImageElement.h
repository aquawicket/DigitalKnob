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
		console.log("\n////// TEST_HTMLImageElement.h //////");
		
		DKHTMLImageElement htmlImageElement;
		printHTMLImageElementProperties(htmlImageElement);
		return true;
	}

	static void printHTMLImageElementProperties(DKHTMLImageElement& htmlImageElement){
		DKDEBUGFUNC(htmlImageElement);
		
		// [HTMLConstructor] constructor();
		// function
		
		// [CEReactions] attribute DOMString alt;
		console.log("htmlImageElement.alt() = "			+toString(htmlImageElement.alt()));
		
		// [CEReactions] attribute USVString src;
		console.log("htmlImageElement.src() = "			+toString(htmlImageElement.src()));
		
		// [CEReactions] attribute USVString srcset;
		console.log("htmlImageElement.srcset() = "		+toString(htmlImageElement.srcset()));
		
		// [CEReactions] attribute DOMString sizes;
		console.log("htmlImageElement.sizes() = "		+toString(htmlImageElement.sizes()));
		
		// [CEReactions] attribute DOMString? crossOrigin;
		console.log("htmlImageElement.crossOrigin() = "	+toString(htmlImageElement.crossOrigin()));
		
		// [CEReactions] attribute DOMString useMap;
		console.log("htmlImageElement.useMap() = "		+toString(htmlImageElement.useMap()));
		
		// [CEReactions] attribute boolean isMap;
		console.log("htmlImageElement.isMap() = "		+toString(htmlImageElement.isMap()));
		
		// [CEReactions] attribute unsigned long width;
		console.log("htmlImageElement.width() = "		+toString(htmlImageElement.width()));
		
		// [CEReactions] attribute unsigned long height;
		console.log("htmlImageElement.height() = "		+toString(htmlImageElement.height()));
		
		// readonly attribute unsigned long naturalWidth;
		console.log("htmlImageElement.naturalWidth() = "+toString(htmlImageElement.naturalWidth()));
		
		// readonly attribute unsigned long naturalHeight;
		console.log("htmlImageElement.naturalHeight() = "+toString(htmlImageElement.naturalHeight()));
		
		// readonly attribute boolean complete;
		console.log("htmlImageElement.complete() = "	+toString(htmlImageElement.complete()));
		
		// readonly attribute USVString currentSrc;
		console.log("htmlImageElement.currentSrc() = "	+toString(htmlImageElement.currentSrc()));
		
		// [CEReactions] attribute DOMString referrerPolicy;
		console.log("htmlImageElement.referrerPolicy() = "+toString(htmlImageElement.referrerPolicy()));
		
		// [CEReactions] attribute DOMString decoding;
		console.log("htmlImageElement.decoding() = "	+toString(htmlImageElement.decoding()));
		
		// [CEReactions] attribute DOMString loading;
		console.log("htmlImageElement.loading() = "		+toString(htmlImageElement.loading()));
		
		// [CEReactions] attribute DOMString fetchPriority;
		console.log("htmlImageElement.fetchPriority() = "+toString(htmlImageElement.fetchPriority()));
		
		// Promise<undefined> decode();
		// function

		// also has obsolete members
	//};
	
		TEST_HTMLElement::printHTMLElementProperties(dynamic_cast<DKHTMLElement&>(htmlImageElement));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_HTMLImageElement, true);


#endif //TEST_HTMLImageElement_H