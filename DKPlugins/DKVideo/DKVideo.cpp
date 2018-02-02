#include "DK/stdafx.h"
#include "DKVideo.h"

////////////////////
bool DKVideo::Init()
{
	DKCreate("DKVideoJS");
	DKCreate("DKOSGVideo");
	DKCreate("DKSDLVideo");
	return true;
}

//////////////////////////////////
void DKVideo::Play(DKString& file)
{
	DKClass::CallFunc("DKOSGVideo::Play", &file, NULL);
	DKClass::CallFunc("DKSDLVideo::Play", &file, NULL);
}
