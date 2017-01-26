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
	DKClass::CallFunc("DKOSGVideo::Play", &file, NULL);
	DKClass::CallFunc("DKSDLVideo::Play", &file, NULL);
}
