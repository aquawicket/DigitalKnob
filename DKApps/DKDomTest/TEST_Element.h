// [IDL] https://dom.spec.whatwg.org/#interface-element
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Element
#pragma once
#ifndef TEST_Element_H
#define TEST_Element_H

#include "DKElement/DKElement.h"


class TEST_Element : public DKObjectT<TEST_Element>
{
public:
	bool Init(){
		DKINFO("\n////// TEST_Element.h //////\n");

		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Element, true);


#endif //TEST_Element_H