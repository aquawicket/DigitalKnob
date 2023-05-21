// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#pragma once
#ifndef TEST_HTMLBodyElement_H
#define TEST_HTMLBodyElement_H

#include "DKHTMLBodyElement/DKHTMLBodyElement.h"


class TEST_HTMLBodyElement : public DKObjectT<TEST_HTMLBodyElement>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_HTMLBodyElement.h //////\n");
		
		DKHTMLBodyElement htmlBodyElement;
		printHTMLBodyElementProperties(htmlBodyElement);
		return true;
	}

	static void printHTMLBodyElementProperties(DKHTMLBodyElement& htmlBodyElement){
		DKDEBUGFUNC(htmlBodyElement);
		
		// [HTMLConstructor] constructor();
		// function
		
		// also has obsolete members
	//};
	
		// Source: Compatibility Standard (https://compat.spec.whatwg.org/)
		// partial interface HTMLBodyElement {
		//		attribute EventHandler onorientationchange;
				DKINFO("htmlBodyElement.onorientationchange() = "	+toString(htmlBodyElement.onorientationchange())	+"\n");
		//};
		
		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// HTMLBodyElement includes WindowEventHandlers;
		// TODO

		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// partial interface HTMLBodyElement {
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
				DKINFO("htmlBodyElement.text() = "					+toString(htmlBodyElement.text())					+"\n");
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
				DKINFO("htmlBodyElement.link() = "					+toString(htmlBodyElement.link())					+"\n");
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
				DKINFO("htmlBodyElement.vLink() = "					+toString(htmlBodyElement.vLink())					+"\n");
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
				DKINFO("htmlBodyElement.aLink() = "					+toString(htmlBodyElement.aLink())					+"\n");
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
				DKINFO("htmlBodyElement.bgColor() = "				+toString(htmlBodyElement.bgColor())				+"\n");
		//
		// 		[CEReactions] attribute DOMString background;
				DKINFO("htmlBodyElement.background() = "			+toString(htmlBodyElement.background())				+"\n");
		//};
	}
};
REGISTER_OBJECT(TEST_HTMLBodyElement, true);


#endif //TEST_HTMLBodyElement_H