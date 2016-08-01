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
	static int OpenMusic(duk_context* ctx);
	static int Pause(duk_context* ctx);
	static int Resume(duk_context* ctx);
	static int Mute(duk_context* ctx);
	static int UnMute(duk_context* ctx);
	static int GetVolume(duk_context* ctx);
	static int SetVolume(duk_context* ctx);
};

REGISTER_OBJECT(DKAudioJS, true)

#endif //DKAudioJS_H
#endif //USE_DKDuktape