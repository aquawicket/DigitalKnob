#ifdef USE_DKDuktape
#pragma once
#ifndef DKAssetsJS_H
#define DKAssetsJS_H

#include "DKDuktape.h"

///////////////////////////////////////////////
class DKAssetsJS : public DKObjectT<DKAssetsJS>
{
public:
	void Init();
	static int LocalAssets(duk_context* ctx);
	static int OnlineAssets(duk_context* ctx);
	//static int AppendDataPath(duk_context* ctx);
};

REGISTER_OBJECT(DKAssetsJS, true)

#endif //DKAssetsJS_H
#endif //USE_DKDuktape