#pragma once
#ifndef DKVideo_H
#define DKVideo_H
#include "DK/DK.h"

/////////////////////////////////////////
class DKVideo : public DKObjectT<DKVideo>
{
public:
	bool Init();
	bool End(){ return true; };
	
	static bool Play(DKString& file);
};

REGISTER_OBJECT(DKVideo, true);
#endif //DKVideo_H

