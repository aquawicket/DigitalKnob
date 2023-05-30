// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef TEST_HTMLElement_H
#define TEST_HTMLElement_H

#include "DKHTMLElement/DKHTMLElement.h"


class TEST_HTMLElement : public DKObjectT<TEST_HTMLElement>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKConsole::log("\n////// TEST_HTMLElement.h //////");
		
		DKHTMLElement htmlElement;
		printHTMLElementProperties(htmlElement);
		return true;
	}
	
	static void printHTMLElementProperties(DKHTMLElement& htmlElement){
		DKDEBUGFUNC(htmlElement);
		
		// [HTMLConstructor] constructor();
		// function
		
		// metadata attributes
		// [CEReactions] attribute DOMString title;
		DKConsole::log("htmlElement.title() = "			+toString(htmlElement.title()));
		
		// [CEReactions] attribute DOMString lang;
		DKConsole::log("htmlElement.lang() = "			+toString(htmlElement.lang()));
		
		// [CEReactions] attribute boolean translate;
		DKConsole::log("htmlElement.translate() = "		+toString(htmlElement.translate()));
		
		// [CEReactions] attribute DOMString dir;
		DKConsole::log("htmlElement.dir() = "			+toString(htmlElement.dir()));
		
		// user interaction
		// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
		DKConsole::log("htmlElement.hidden() = "		+toString(htmlElement.hidden()));
		
		// [CEReactions] attribute boolean inert;
		DKConsole::log("htmlElement.inert() = "			+toString(htmlElement.inert()));
		
		// undefined click();
		// function
		
		// [CEReactions] attribute DOMString accessKey;
		DKConsole::log("htmlElement.accessKey() = "		+toString(htmlElement.accessKey()));
		
		// readonly attribute DOMString accessKeyLabel;
		DKConsole::log("htmlElement.accessKeyLabel() = "+toString(htmlElement.accessKeyLabel()));
		
		// [CEReactions] attribute boolean draggable;
		DKConsole::log("htmlElement.draggable() = "		+toString(htmlElement.draggable()));
		
		// [CEReactions] attribute boolean spellcheck;
		DKConsole::log("htmlElement.spellcheck() = "	+toString(htmlElement.spellcheck()));
		
		// [CEReactions] attribute DOMString autocapitalize;
		DKConsole::log("htmlElement.autocapitalize() = "+toString(htmlElement.autocapitalize()));
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
		DKConsole::log("htmlElement.innerText() = "		+toString(htmlElement.innerText()));
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
		DKConsole::log("htmlElement.outerText() = "		+toString(htmlElement.outerText()));
		
		// ElementInternals attachInternals();
		// function
		
		// The popover API
		// undefined showPopover();
		// function
		
		// undefined hidePopover();
		// function
		
		// undefined togglePopover(optional boolean force);
		// function
		
		// [CEReactions] attribute DOMString? popover;
		// function
		
	//};

		// HTMLElement includes GlobalEventHandlers;
		// HTMLElement includes ElementContentEditable;
		// HTMLElement includes HTMLOrSVGElement;
		
		// [Exposed=Window]
		// interface HTMLUnknownElement : HTMLElement {
			// Note: intentionally no [HTMLConstructor]
		// };
		
		TEST_Element::printElementProperties(dynamic_cast<DKElement&>(htmlElement));	//TODO: try to remove the need for dynamic_cast
	}
};
REGISTER_OBJECT(TEST_HTMLElement, true);


#endif //TEST_HTMLElement_H