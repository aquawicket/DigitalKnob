#ifdef USE_DKDuktape 
#pragma once
#ifndef DKCSSStyleDeclaration_H
#define DKCSSStyleDeclaration_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////////
class DKCSSStyleDeclaration : public DKObjectT<DKCSSStyleDeclaration>
{
public:
	bool Init();
	
	static int getPropertyValue(duk_context* ctx);
	static int setProperty(duk_context* ctx);
};


REGISTER_OBJECT(DKCSSStyleDeclaration, true)

#endif //DKCSSStyleDeclaration_H
#endif //USE_DKDuktape