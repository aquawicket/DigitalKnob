#pragma once
#ifndef DKAudio_H
#define DKAudio_H
#include "DK.h"

/////////////////////////////////////////
class DKAudio : public DKObjectT<DKAudio>
{
public:
	void Init();
	void End(){};
	static void Play(DKString& file);
};

REGISTER_OBJECT(DKAudio, true);

#endif //DKAudio_H

