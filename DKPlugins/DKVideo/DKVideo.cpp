#include "stdafx.h"
#include "DKVideo.h"

void DKVideo::Init()
{
	DKCreate("DKVideoJS");
	DKCreate("DKOSGVideo");
	DKCreate("DKSDLVideo");
}

//////////////////////////////////
void DKVideo::Play(DKString& file)
{
	DKClass::CallFunc("DKOSGVideo::Play", static_cast<void*>(&file));
	DKClass::CallFunc("DKSDLVideo::Play", static_cast<void*>(&file));
}
