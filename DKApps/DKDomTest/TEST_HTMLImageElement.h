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
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_HTMLImageElement, true);


#endif //TEST_HTMLImageElement_H