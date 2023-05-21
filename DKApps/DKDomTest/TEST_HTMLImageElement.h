// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
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
		DKINFO("\n////// TEST_HTMLImageElement.h //////\n");
		
		DKHTMLImageElement htmlImageElement;
		printHTMLImageElementProperties(htmlImageElement);
		return true;
	}

	static void printHTMLImageElementProperties(DKHTMLImageElement& htmlImageElement){
		DKDEBUGFUNC(htmlImageElement);
		
		// [HTMLConstructor] constructor();
		// function
		
		// [CEReactions] attribute DOMString alt;
		DKINFO("htmlImageElement.alt() = "			+toString(htmlImageElement.alt())				+"\n");
		
		// [CEReactions] attribute USVString src;
		DKINFO("htmlImageElement.src() = "			+toString(htmlImageElement.src())				+"\n");
		
		// [CEReactions] attribute USVString srcset;
		DKINFO("htmlImageElement.srcset() = "		+toString(htmlImageElement.srcset())			+"\n");
		
		// [CEReactions] attribute DOMString sizes;
		DKINFO("htmlImageElement.sizes() = "		+toString(htmlImageElement.sizes())				+"\n");
		
		// [CEReactions] attribute DOMString? crossOrigin;
		DKINFO("htmlImageElement.crossOrigin() = "	+toString(htmlImageElement.crossOrigin())		+"\n");
		
		// [CEReactions] attribute DOMString useMap;
		DKINFO("htmlImageElement.useMap() = "		+toString(htmlImageElement.useMap())			+"\n");
		
		// [CEReactions] attribute boolean isMap;
		DKINFO("htmlImageElement.isMap() = "		+toString(htmlImageElement.isMap())				+"\n");
		
		// [CEReactions] attribute unsigned long width;
		DKINFO("htmlImageElement.width() = "		+toString(htmlImageElement.width())				+"\n");
		
		// [CEReactions] attribute unsigned long height;
		DKINFO("htmlImageElement.height() = "		+toString(htmlImageElement.height())			+"\n");
		
		// readonly attribute unsigned long naturalWidth;
		DKINFO("htmlImageElement.naturalWidth() = "	+toString(htmlImageElement.naturalWidth())		+"\n");
		
		// readonly attribute unsigned long naturalHeight;
		DKINFO("htmlImageElement.naturalHeight() = "+toString(htmlImageElement.naturalHeight())		+"\n");
		
		// readonly attribute boolean complete;
		DKINFO("htmlImageElement.complete() = "		+toString(htmlImageElement.complete())			+"\n");
		
		// readonly attribute USVString currentSrc;
		DKINFO("htmlImageElement.currentSrc() = "	+toString(htmlImageElement.currentSrc())		+"\n");
		
		// [CEReactions] attribute DOMString referrerPolicy;
		DKINFO("htmlImageElement.referrerPolicy() = "+toString(htmlImageElement.referrerPolicy())	+"\n");
		
		// [CEReactions] attribute DOMString decoding;
		DKINFO("htmlImageElement.decoding() = "		+toString(htmlImageElement.decoding())			+"\n");
		
		// [CEReactions] attribute DOMString loading;
		DKINFO("htmlImageElement.loading() = "		+toString(htmlImageElement.loading())			+"\n");
		
		// [CEReactions] attribute DOMString fetchPriority;
		DKINFO("htmlImageElement.fetchPriority() = "+toString(htmlImageElement.fetchPriority())		+"\n");
		
		// Promise<undefined> decode();
		// function

		// also has obsolete members
	//};
	}
};
REGISTER_OBJECT(TEST_HTMLImageElement, true);


#endif //TEST_HTMLImageElement_H