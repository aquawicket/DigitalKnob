#ifdef USE_DKDuktape 
#pragma once
#ifndef DKElement_H
#define DKElement_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKElement : public DKObjectT<DKElement>
{
public:
	bool Init();
	
	static int href(duk_context* ctx);
};


REGISTER_OBJECT(DKElement, true)

#endif //DKElement_H
#endif //USE_DKDuktape