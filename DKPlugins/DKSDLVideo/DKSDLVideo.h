//https://github.com/ashafiei/dranger-ffmpeg-tuto
//http://dranger.com/ffmpeg/
#pragma once
#ifndef DKSDLVideo_H
#define DKSDLVideo_H

#include "WAAVE.h"
#include "DK/DK.h"

///////////////////////////////////////////////
class DKSDLVideo : public DKObjectT<DKSDLVideo>
{
public:
	void Init();
	void End();
	
	bool Handle(SDL_Event* event);
	bool Play(const void* input, void* output);
	
	WVStream* stream;
	WVStreamingObject* streamObj;
};

REGISTER_OBJECT(DKSDLVideo, true)

#endif //DKSDLVideo_H