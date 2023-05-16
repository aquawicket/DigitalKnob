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
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_HTMLElement, true);


#endif //TEST_HTMLElement_H