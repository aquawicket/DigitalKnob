#ifdef USE_DKDuktape 
#pragma once
#ifndef DKNavigator_H
#define DKNavigator_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKNavigator : public DKObjectT<DKNavigator>
{
public:
	bool Init();
	
	static int clear(duk_context* ctx);
	static int debug(duk_context* ctx);
	static int error(duk_context* ctx);
	static int info(duk_context* ctx);
	static int warn(duk_context* ctx);
};


REGISTER_OBJECT(DKNavigator, true)

#endif //DKNavigator_H
#endif //USE_DKDuktape