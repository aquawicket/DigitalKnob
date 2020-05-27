#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketElement_H
#define DKRocketElement_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////
class DKRocketElement : public DKObjectT<DKRocketElement>
{
public:
	bool Init();
	
	static int clientHeight(duk_context* ctx);
	static int clientLeft(duk_context* ctx);
	static int clientTop(duk_context* ctx);
	static int clientWidth(duk_context* ctx);
	static int getAttribute(duk_context* ctx);
	static int getElementsByClassName(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int innerHTML(duk_context* ctx);
	static int setAttribute(duk_context* ctx);
	static int tagName(duk_context* ctx);
};


REGISTER_OBJECT(DKRocketElement, true)

#endif //DKRocketElement_H
#endif //USE_DKDuktape