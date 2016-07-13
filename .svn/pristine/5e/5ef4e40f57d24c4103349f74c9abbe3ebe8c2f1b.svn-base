#ifdef USE_DKDuktape 
#pragma once
#ifndef DKAudioJS_H
#define DKAudioJS_H

#include "DKDuktape.h"

/////////////////////////////////////////////
class DKAudioJS : public DKObjectT<DKAudioJS>
{
public:
	void Init();
	static int Play(duk_context* ctx);
};

REGISTER_OBJECT(DKAudioJS, true)

#endif //DKAudioJS_H
#endif //USE_DKDuktape