// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef TEST_DKRmlCSSStyleDeclaration_H
#define TEST_DKRmlCSSStyleDeclaration_H

#include "DKDKRmlCSSStyleDeclaration/DKDKRmlCSSStyleDeclaration.h"


class TEST_DKRmlCSSStyleDeclaration : public DKObjectT<TEST_DKRmlCSSStyleDeclaration>
{
public:
	TEST_DKRmlCSSStyleDeclaration() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_DKRmlCSSStyleDeclaration.h //////");
		
		DKRmlCSSStyleDeclaration dkRmlCSSStyleDeclaration;
		printDKRmlCSSStyleDeclarationProperties(dkRmlCSSStyleDeclaration);
	}
	
	static void printDKRmlCSSStyleDeclarationProperties(DKRmlCSSStyleDeclaration& dkRmlCSSStyleDeclaration) {
		DKDEBUGFUNC(cssStyleDeclaration);
		
		TEST_CSSStyleDeclaration::printCSSStyleDeclarationProperties(cssStyleDeclaration);
	}
	
};
REGISTER_OBJECT(TEST_DKRmlCSSStyleDeclaration, true);


#endif //TEST_DKRmlCSSStyleDeclaration_H