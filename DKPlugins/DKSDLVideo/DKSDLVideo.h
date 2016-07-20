//http://dranger.com/ffmpeg/

#pragma once
#ifndef DKSDLVideo_H
#define DKSDLVideo_H
#include "DK.h"
#include "ffplay.h"

///////////////////////////////////////////////
class DKSDLVideo : public DKObjectT<DKSDLVideo>
{
public:
	void Init();
	void End();
	void* Play(void* data);
};

REGISTER_OBJECT(DKSDLVideo, true)

#endif //DKSDLVideo_H