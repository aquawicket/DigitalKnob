//https://gist.github.com/armornick/3447121

#pragma once
#ifndef DKSDLAudio_H
#define DKSDLAudio_H
#include "DK.h"
#include "SDL.h"


///////////////////////////////////////////////
class DKSDLAudio : public DKObjectT<DKSDLAudio>
{
public:
	void Init();
	void End();

	void* Play(void* data);

	static void Callback(void *userdata, Uint8 *stream, int len);

	static Uint8* audio_pos; // global pointer to the audio buffer to be played
	static Uint32 audio_len; // remaining length of the sample we have to play
	
	static Uint32 wav_length; // length of our sample
	static Uint8* wav_buffer; // buffer containing our audio file
	static SDL_AudioSpec wav_spec; // the specs of our piece of music
};


REGISTER_OBJECT(DKSDLAudio, true);

#endif //DKSDLAudio_H

