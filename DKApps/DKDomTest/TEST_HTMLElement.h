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
		DKINFO("\n////// TEST_HTMLElement.h //////\n");
		
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
		DKINFO("htmlElement.title() = "			+toString(htmlElement.title())			+"\n");
		
		// [CEReactions] attribute DOMString lang;
		DKINFO("htmlElement.lang() = "			+toString(htmlElement.lang())			+"\n");
		
		// [CEReactions] attribute boolean translate;
		DKINFO("htmlElement.translate() = "		+toString(htmlElement.translate())		+"\n");
		
		// [CEReactions] attribute DOMString dir;
		DKINFO("htmlElement.dir() = "			+toString(htmlElement.dir())			+"\n");
		
		// user interaction
		// [CEReactions] attribute (boolean or unrestricted double or DOMString)? hidden;
		DKINFO("htmlElement.hidden() = "		+toString(htmlElement.hidden())			+"\n");
		
		// [CEReactions] attribute boolean inert;
		DKINFO("htmlElement.inert() = "			+toString(htmlElement.inert())			+"\n");
		
		// undefined click();
		// function
		
		// [CEReactions] attribute DOMString accessKey;
		DKINFO("htmlElement.accessKey() = "		+toString(htmlElement.accessKey())		+"\n");
		
		// readonly attribute DOMString accessKeyLabel;
		DKINFO("htmlElement.accessKeyLabel() = "+toString(htmlElement.accessKeyLabel())	+"\n");
		
		// [CEReactions] attribute boolean draggable;
		DKINFO("htmlElement.draggable() = "		+toString(htmlElement.draggable())		+"\n");
		
		// [CEReactions] attribute boolean spellcheck;
		DKINFO("htmlElement.spellcheck() = "	+toString(htmlElement.spellcheck())		+"\n");
		
		// [CEReactions] attribute DOMString autocapitalize;
		DKINFO("htmlElement.autocapitalize() = "+toString(htmlElement.autocapitalize())	+"\n");
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString innerText;
		DKINFO("htmlElement.innerText() = "		+toString(htmlElement.innerText())		+"\n");
		
		// [CEReactions] attribute [LegacyNullToEmptyString] DOMString outerText;
		DKINFO("htmlElement.outerText() = "		+toString(htmlElement.outerText())		+"\n");
		
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