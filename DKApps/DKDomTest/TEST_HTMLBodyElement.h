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
		DKConsole::log("\n////// TEST_HTMLBodyElement.h //////");
		
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
				DKConsole::log("htmlBodyElement.onorientationchange() = "	+toString(htmlBodyElement.onorientationchange()));
		//};
		
		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// HTMLBodyElement includes WindowEventHandlers;
		// TODO

		// Source: HTML Standard (https://html.spec.whatwg.org/multipage/)
		// partial interface HTMLBodyElement {
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString text;
				DKConsole::log("htmlBodyElement.text() = "					+toString(htmlBodyElement.text()));
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString link;
				DKConsole::log("htmlBodyElement.link() = "					+toString(htmlBodyElement.link()));
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString vLink;
				DKConsole::log("htmlBodyElement.vLink() = "					+toString(htmlBodyElement.vLink()));
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString aLink;
				DKConsole::log("htmlBodyElement.aLink() = "					+toString(htmlBodyElement.aLink()));
		//
		// 		[CEReactions] attribute [LegacyNullToEmptyString] DOMString bgColor;
				DKConsole::log("htmlBodyElement.bgColor() = "				+toString(htmlBodyElement.bgColor()));
		//
		// 		[CEReactions] attribute DOMString background;
				DKConsole::log("htmlBodyElement.background() = "			+toString(htmlBodyElement.background()));
		//};
		
		TEST_HTMLElement::printHTMLElementProperties(dynamic_cast<DKHTMLElement&>(htmlBodyElement));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_HTMLBodyElement, true);


#endif //TEST_HTMLBodyElement_H