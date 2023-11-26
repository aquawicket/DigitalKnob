// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef TEST_DKRmlCSSStyleDeclaration_H
#define TEST_DKRmlCSSStyleDeclaration_H

#include "DKRmlCSSStyleDeclaration/DKRmlCSSStyleDeclaration.h"


class TEST_DKRmlCSSStyleDeclaration //: public DKObjectT<TEST_DKRmlCSSStyleDeclaration>
{
public:
	TEST_DKRmlCSSStyleDeclaration() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlCSSStyleDeclaration.h //////");
		
		DKRmlCSSStyleDeclaration dkRmlCSSStyleDeclaration(NULL);
		printDKRmlCSSStyleDeclarationProperties(dkRmlCSSStyleDeclaration);
	}
	
	static void printDKRmlCSSStyleDeclarationProperties(DKRmlCSSStyleDeclaration& dkRmlCSSStyleDeclaration) {
		DKDEBUGFUNC(dkRmlCSSStyleDeclaration);
		
		console.log("dkRmlCSSStyleDeclaration = "		+toString(dkRmlCSSStyleDeclaration));
		
		TEST_CSSStyleDeclaration::printCSSStyleDeclarationProperties(dkRmlCSSStyleDeclaration);
	}
	
};
//REGISTER_OBJECT(TEST_DKRmlCSSStyleDeclaration, true);


#endif //TEST_DKRmlCSSStyleDeclaration_H