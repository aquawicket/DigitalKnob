// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement
#pragma once
#ifndef TEST_HTMLImageElement_H
#define TEST_HTMLImageElement_H

#include "DKHTMLImageElement/DKImageBodyElement.h"


class TEST_HTMLImageElement : public DKObjectT<TEST_HTMLImageElement>
{
public:
	bool Init(){
		DKINFO("////// TEST_HTMLImageElement.h ////// \n");
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_HTMLImageElement, true);


#endif //TEST_HTMLImageElement_H