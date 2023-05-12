// [IDL] https://html.spec.whatwg.org/multipage/sections.html#htmlbodyelement
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLBodyElement
#pragma once
#ifndef TEST_HTMLBodyElement_H
#define TEST_HTMLBodyElement_H

//#include "DK/DK.h"
#include "DKHTMLBodyElement/DKHTMLBodyElement.h"


class TEST_HTMLBodyElement : public DKObjectT<TEST_HTMLBodyElement>
{
public:
	bool Init(){
		DKINFO("////// TEST_HTMLBodyElement.h ////// \n");
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_HTMLBodyElement, true);


#endif //TEST_HTMLBodyElement_H