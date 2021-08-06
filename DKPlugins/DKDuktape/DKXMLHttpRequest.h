#ifdef USE_DKDuktape 
#pragma once
#ifndef DKXMLHttpRequest_H
#define DKXMLHttpRequest_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKXMLHttpRequest : public DKObjectT<DKXMLHttpRequest>
{
public:
	bool Init();
	
	static int send(duk_context* ctx);
};


REGISTER_OBJECT(DKXMLHttpRequest, true)

#endif //DKXMLHttpRequest_H
#endif //USE_DKDuktape