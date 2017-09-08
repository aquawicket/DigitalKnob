//https://github.com/ashafiei/dranger-ffmpeg-tuto
//http://dranger.com/ffmpeg/

#pragma once
#ifndef DKSDLVideo_H
#define DKSDLVideo_H
#include "DK.h"
#include "WAAVE.h"

///////////////////////////////////////////////
class DKSDLVideo : public DKObjectT<DKSDLVideo>
{
public:
	void Init();
	void End();
	
	void* Play(void* data);
	bool handle(SDL_Event* event);

	WVStream* stream;
	WVStreamingObject* streamObj;
};

REGISTER_OBJECT(DKSDLVideo, true)

#endif //DKSDLVideo_H