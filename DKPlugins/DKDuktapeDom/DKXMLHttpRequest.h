#ifdef HAVE_DKDuktape 
#pragma once
#ifndef DKXMLHttpRequest_H
#define DKXMLHttpRequest_H

#include "DKDuktapeDom/DKDuktapeDom.h"

///////////////////////////////////////////////////////////
class DKXMLHttpRequest : public DKObjectT<DKXMLHttpRequest>
{
public:
	bool Init();
	
	static int send(duk_context* ctx);
};


REGISTER_OBJECT(DKXMLHttpRequest, true)

#endif //DKXMLHttpRequest_H
#endif //HAVE_DKDuktape