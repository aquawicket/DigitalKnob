/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

//https://gist.github.com/armornick/3447121
#pragma once
#ifndef DKSdlAudio_H
#define DKSdlAudio_H

WARNING_DISABLE
#include "SDL.h"
#include "SDL_mixer.h"
WARNING_ENABLE

#include "DK/DK.h"


struct track{
	DKString file;
	Mix_Music* snd;
	int position;
};

class DKSdlAudio : public DKObjectT<DKSdlAudio>
{
public:
	bool Init();
	bool End();

	bool GetDuration(const void* input, void* output);
	bool GetTime(const void* input, void* output);
	bool GetVolume(const void* input, void* output);
	bool Mute(const void* input, void* output);
	bool OpenMusic(const void* input, void* output);
	bool Pause(const void* input, void* output);
	bool PlaySound(const void* input, void* output);
	bool Resume(const void* input, void* output);
	bool SetTime(const void* input, void* output);
	bool SetVolume(const void* input, void* output);
	bool UnMute(const void* input, void* output);
	void Process();

	int _volume;
	track trk;
	unsigned int lastTime;
};


REGISTER_OBJECT(DKSdlAudio, true);
#endif //DKSdlAudio_H
