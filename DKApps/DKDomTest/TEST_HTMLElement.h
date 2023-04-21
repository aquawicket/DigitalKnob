#pragma once
#ifndef TEST_HTMLElement_H
#define TEST_HTMLElement_H

#include "DK/DK.h"
//#include "DKHTMLElement/DKHTMLElement.h"	//TODO


// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
class TEST_HTMLElement : public DKObjectT<TEST_HTMLElement>
{
public:
	bool Init(){
		DKINFO("////// TEST_HTMLElement.h ////// \n");
		
		////// Instance properties //////
		// TODO
		
		
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_HTMLElement, true);


#endif //TEST_HTMLElement_H