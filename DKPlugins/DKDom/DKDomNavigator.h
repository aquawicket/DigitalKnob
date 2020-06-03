#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomNavigator_H
#define DKDomNavigator_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////
class DKDomNavigator : public DKObjectT<DKDomNavigator>
{
public:
	bool Init();
	
	static int onLine(duk_context* ctx);
	static int platform(duk_context* ctx);
	static int productSub(duk_context* ctx);
};


REGISTER_OBJECT(DKDomNavigator, true)

#endif //DKDomNavigator_H
#endif //USE_DKDuktape