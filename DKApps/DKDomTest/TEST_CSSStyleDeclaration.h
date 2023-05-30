// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef TEST_CSSStyleDeclaration_H
#define TEST_CSSStyleDeclaration_H

#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


class TEST_CSSStyleDeclaration : public DKObjectT<TEST_CSSStyleDeclaration>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		console.log("\n////// TEST_CSSStyleDeclaration.h //////");
		
		return DKTODO();
	}
	
};
REGISTER_OBJECT(TEST_CSSStyleDeclaration, true);


#endif //TEST_CSSStyleDeclaration_H