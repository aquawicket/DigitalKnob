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
	static int PlaySound(duk_context* ctx);
	static int PlayMusic(duk_context* ctx);
	static int Pause(duk_context* ctx);
	static int Resume(duk_context* ctx);
};

REGISTER_OBJECT(DKAudioJS, true)

#endif //DKAudioJS_H
#endif //USE_DKDuktape