// [IDL] https://drafts.csswg.org/cssom/#the-cssstyledeclaration-interface
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef TEST_CSSStyleDeclaration_H
#define TEST_CSSStyleDeclaration_H

#include "DKCSSStyleDeclaration/DKCSSStyleDeclaration.h"


class TEST_CSSStyleDeclaration : public DKObjectT<TEST_CSSStyleDeclaration>
{
public:
	TEST_CSSStyleDeclaration() {
		DKDEBUGFUNC();
		console.log("\n////// TEST_CSSStyleDeclaration.h //////");
		
		DKCSSStyleDeclaration cssStyleDeclaration;
		printCSSStyleDeclarationProperties(cssStyleDeclaration);
	}
	
	static void printCSSStyleDeclarationProperties(DKCSSStyleDeclaration& cssStyleDeclaration) {
		DKDEBUGFUNC(cssStyleDeclaration);
		
		console.log("cssStyleDeclaration = "			+toString(cssStyleDeclaration));
		
		// [CEReactions] attribute CSSOMString cssText;
		console.log("cssStyleDeclaration.cssText() = "	+toString(cssStyleDeclaration.cssText()));
		
		// readonly attribute unsigned long length;
		console.log("cssStyleDeclaration.length() = "	+toString(cssStyleDeclaration.length()));
		
		// getter CSSOMString item(unsigned long index);
		// function
		
		// CSSOMString getPropertyValue(CSSOMString property);
		// function
		
		// CSSOMString getPropertyPriority(CSSOMString property);
		// function
		
		// [CEReactions] undefined setProperty(CSSOMString property, [LegacyNullToEmptyString] CSSOMString value, optional [LegacyNullToEmptyString] CSSOMString priority = "");
		// function
		
		// [CEReactions] CSSOMString removeProperty(CSSOMString property);
		// function
		
		// readonly attribute CSSRule? parentRule;
		// TODO
		
		// [CEReactions] attribute [LegacyNullToEmptyString] CSSOMString cssFloat;
		console.log("cssStyleDeclaration.cssFloat() = "	+toString(cssStyleDeclaration.cssFloat()));
	}
	
};
REGISTER_OBJECT(TEST_CSSStyleDeclaration, true);


#endif //TEST_CSSStyleDeclaration_H