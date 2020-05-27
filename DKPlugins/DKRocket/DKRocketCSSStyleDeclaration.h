#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketCSSStyleDeclaration_H
#define DKRocketCSSStyleDeclaration_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////////////////////
class DKRocketCSSStyleDeclaration : public DKObjectT<DKRocketCSSStyleDeclaration>
{
public:
	bool Init();
	
	static int getPropertyValue(duk_context* ctx);
	static int setProperty(duk_context* ctx);
};


REGISTER_OBJECT(DKRocketCSSStyleDeclaration, true)

#endif //DKRocketCSSStyleDeclaration_H
#endif //USE_DKDuktape