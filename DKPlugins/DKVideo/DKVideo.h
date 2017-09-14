#pragma once
#ifndef DKVideo_H
#define DKVideo_H
#include "DK/DK.h"

/////////////////////////////////////////
class DKVideo : public DKObjectT<DKVideo>
{
public:
	void Init();
	void End(){};
	
	static void Play(DKString& file);
};

REGISTER_OBJECT(DKVideo, true);
#endif //DKVideo_H

