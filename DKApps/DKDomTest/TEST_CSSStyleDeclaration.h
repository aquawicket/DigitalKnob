// [IDL]
// [MDN]
#pragma once
#ifndef TEST_CSSStyleDeclaration_H
#define TEST_CSSStyleDeclaration_H

#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


class TEST_CSSStyleDeclaration : public DKObjectT<TEST_CSSStyleDeclaration>
{
public:
	bool Init(){
		DKINFO("////// TEST_CSSStyleDeclaration.h ////// \n");
		
		return DKTODO();
	}
	
};
REGISTER_OBJECT(TEST_CSSStyleDeclaration, true);


#endif //TEST_CSSStyleDeclaration_H