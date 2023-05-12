// [IDL] https://dom.spec.whatwg.org/#interface-htmlcollection
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection
#pragma once
#ifndef TEST_HTMLCollection_H
#define TEST_HTMLCollection_H

#include "DKHTMLCollection/DKHTMLCollection.h"


class TEST_HTMLCollection : public DKObjectT<TEST_HTMLCollection>
{
public:
	bool Init(){
		DKINFO("////// TEST_HTMLCollection.h ////// \n");
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_HTMLCollection, true);


#endif //TEST_HTMLCollection_H