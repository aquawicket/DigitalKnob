#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketDocument_H
#define DKRocketDocument_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKRocketDocument : public DKObjectT<DKRocketDocument>
{
public:
	bool Init();
	
	static int body(duk_context* ctx);
	static int createElement(duk_context* ctx);
	static int documentElement(duk_context* ctx);
	static int getElementById(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
};


REGISTER_OBJECT(DKRocketDocument, true)

#endif //DKRocketDocument_H
#endif //USE_DKDuktape