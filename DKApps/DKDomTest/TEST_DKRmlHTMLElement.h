// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef TEST_DKRmlHTMLElement_H
#define TEST_DKRmlHTMLElement_H

#include "DKRmlHTMLElement/DKRmlHTMLElement.h"


class TEST_DKRmlHTMLElement //: public DKObjectT<TEST_DKRmlHTMLElement>
{
public:
	DKRmlHTMLElement* dkRmlHTMLElement;
	//std::unique_ptr<DKRmlHTMLElement> dkRmlHTMLElement;
	
	TEST_DKRmlHTMLElement(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlHTMLElement.h //////");
		
		dkRmlHTMLElement = new DKRmlHTMLElement(TEST_DKRmlInterface::dkRmlInterface, NULL);
		
		printDKRmlHTMLElementProperties(*dkRmlHTMLElement);
	}
	
	static void printDKRmlHTMLElementProperties(DKRmlHTMLElement& dkRmlHTMLElement){
		DKDEBUGFUNC(dkRmlHTMLElement);
		
		TEST_HTMLElement::printHTMLElementProperties(dynamic_cast<DKHTMLElement&>(dkRmlHTMLElement));	//TODO: try to remove the need for dynamic_cast
	}
};
//REGISTER_OBJECT(TEST_DKRmlHTMLElement, true);


#endif //TEST_DKRmlHTMLElement