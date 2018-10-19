#ifdef USE_DKDuktape 
#pragma once
#ifndef DKXmlJS_H
#define DKXmlJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////
class DKXmlJS : public DKObjectT<DKXmlJS>
{
public:
	bool Init();

	static int GetXmlNode(duk_context* ctx);
};


#endif //DKXmlJS_H
#endif //USE_DKDuktape