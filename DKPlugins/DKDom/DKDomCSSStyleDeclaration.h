// https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration
#pragma once
#ifndef DKDomCSSStyleDeclaration_H
#define DKDomCSSStyleDeclaration_H

#include "DKDuktape/DKDuktape.h"


class DKDomCSSStyleDeclaration : public DKObjectT<DKDomCSSStyleDeclaration>
{
public:
	bool Init();
	
	static int getPropertyPriority(duk_context* ctx);
	static int getPropertyValue(duk_context* ctx);
	static int item(duk_context* ctx);
	static int removeProperty(duk_context* ctx);
	static int setProperty(duk_context* ctx);
//	static int getPropertyCSSValue(duk_context* ctx); //DEPRICATED
};


REGISTER_OBJECT(DKDomCSSStyleDeclaration, true)

#endif //DKDomCSSStyleDeclaration_H