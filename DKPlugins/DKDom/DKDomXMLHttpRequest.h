#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomXMLHttpRequest_H
#define DKDomXMLHttpRequest_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////
class DKDomXMLHttpRequest : public DKObjectT<DKDomXMLHttpRequest>
{
public:
	bool Init();
	
	static int send(duk_context* ctx);
};


REGISTER_OBJECT(DKDomXMLHttpRequest, true)

#endif //DKDomXMLHttpRequest_H
#endif //USE_DKDuktape