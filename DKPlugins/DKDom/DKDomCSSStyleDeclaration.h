#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomCSSStyleDeclaration_H
#define DKDomCSSStyleDeclaration_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////////////////////
class DKDomCSSStyleDeclaration : public DKObjectT<DKDomCSSStyleDeclaration>
{
public:
	bool Init();
	
	static int getPropertyValue(duk_context* ctx);
	static int setProperty(duk_context* ctx);
};


REGISTER_OBJECT(DKDomCSSStyleDeclaration, true)

#endif //DKDomCSSStyleDeclaration_H
#endif //USE_DKDuktape