#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDocument_H
#define DKDocument_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////
class DKDocument : public DKObjectT<DKDocument>
{
public:
	bool Init();
	
	static int body(duk_context* ctx);
	static int createElement(duk_context* ctx);
	static int documentElement(duk_context* ctx);
	static int getElementById(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
};


REGISTER_OBJECT(DKDocument, true)

#endif //DKDocument_H
#endif //USE_DKDuktape