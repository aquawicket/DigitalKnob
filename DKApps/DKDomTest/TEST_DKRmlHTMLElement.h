// [IDL] https://html.spec.whatwg.org/multipage/dom.html#htmlelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
#pragma once
#ifndef TEST_DKRmlHTMLElement_H
#define TEST_DKRmlHTMLElement_H

#include "DKRmlHTMLElement/DKRmlHTMLElement.h"


class TEST_DKRmlHTMLElement //: public DKObjectT<TEST_DKRmlHTMLElement>
{
public:
	DKRmlHTMLElement* _dkRmlHTMLElement;
	
	TEST_DKRmlHTMLElement(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlHTMLElement.h //////");
		
		_dkRmlHTMLElement = new DKRmlHTMLElement(TEST_DKRmlEventListener::_dkRmlEventListener, NULL);
		
		printDKRmlHTMLElementProperties(_dkRmlHTMLElement);
	}
	
	static void printDKRmlHTMLElementProperties(DKRmlHTMLElement* dkRmlHTMLElement){
		DKDEBUGFUNC(dkRmlHTMLElement);
		
		console.log("dkRmlHTMLElement = "	+toString(dkRmlHTMLElement));
		
		TEST_HTMLElement::printHTMLElementProperties(dkRmlHTMLElement);
	}
};
//REGISTER_OBJECT(TEST_DKRmlHTMLElement, true);


#endif //TEST_DKRmlHTMLElement