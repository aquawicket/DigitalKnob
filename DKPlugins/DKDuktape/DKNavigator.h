#ifdef USE_DKDuktape 
#pragma once
#ifndef DKNavigator_H
#define DKNavigator_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////
class DKNavigator : public DKObjectT<DKNavigator>
{
public:
	bool Init();
	
	static int onLine(duk_context* ctx);
	static int platform(duk_context* ctx);
	static int productSub(duk_context* ctx);
};


REGISTER_OBJECT(DKNavigator, true)

#endif //DKNavigator_H
#endif //USE_DKDuktape