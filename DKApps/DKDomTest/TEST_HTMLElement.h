// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef TEST_HTMLElement_H
#define TEST_HTMLElement_H

#include "DKHTMLElement/DKHTMLElement.h"


class TEST_HTMLElement //: public DKObjectT<TEST_HTMLElement>
{
public:
	TEST_HTMLElement(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_HTMLElement.h //////");
		
		DKHTMLElement htmlElement;
		printHTMLElementProperties(&htmlElement);
	}
	
	static void printHTMLElementProperties(DKHTMLElement* htmlElement){
		DKDEBUGFUNC(htmlElement);
		
		console.log("htmlElement = "					+toString(htmlElement));
		
		// [HTMLConstructor] constructor();
		// function
		
		// metadata attributes
		// [CEReactions] attribute DOMString title;
		console.log("htmlElement->title() = "			+toString(htmlElement->title()));
		
		// [CEReactions] attribute DOMString lang;
		console.log("htmlElement->lang() = "			+toString(htmlElement->lang()));
		
		// [CEReactions] attribute boolean translate;
		console.log("htmlElement->translate() = "		+toString(htmlElement->translate()));
		
		// [CEReactions] attribute DOMString dir;
		console.log("htmlElement->dir() = "				+toString(htmlElement->dir()));
		
		// user interaction
		// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
		console.log("htmlElement->hidden() = "			+toString(htmlElement->hidden()));
		
		// [CEReactions] attribute boolean inert;
		console.log("htmlElement->inert() = "			+toString(htmlElement->inert()));
		
		// undefined click();
		// function
		
		// [CEReactions] attribute DOMString accessKey;
		console.log("htmlElement->accessKey() = "		+toString(htmlElement->accessKey()));
		
		// readonly attribute DOMString accessKeyLabel;
		console.log("htmlElement->accessKeyLabel() = "	+toString(htmlElement->accessKeyLabel()));
		
		// [CEReactions] attribute boolean draggable;
		console.log("htmlElement->draggable() = "		+toString(htmlElement->draggable()));
		
		// [CEReactions] attribute boolean spellcheck;
		console.log("htmlElement->spellcheck() = "		+toString(htmlElement->spellcheck()));
		
		// [CEReactions] attribute DOMString autocapitalize;
		console.log("htmlElement->autocapitalize() = "	+toString(htmlElement->autocapitalize()));
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
		console.log("htmlElement->innerText() = "		+toString(htmlElement->innerText()));
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
		console.log("htmlElement->outerText() = "		+toString(htmlElement->outerText()));
		
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
		
		TEST_Element::printElementProperties(htmlElement);
	}
};
//REGISTER_OBJECT(TEST_HTMLElement, true);


#endif //TEST_HTMLElement_H