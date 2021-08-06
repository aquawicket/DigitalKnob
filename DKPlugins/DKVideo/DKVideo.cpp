#include "DK/stdafx.h"
#include "DKVideo.h"

////////////////////
bool DKVideo::Init()
{
	DKDEBUGFUNC();
	DKClass::DKCreate("DKVideoJS");
	DKClass::DKCreate("DKOSGVideo");
	DKClass::DKCreate("DKSDLVideo");
	return true;
}

//////////////////////////////////
bool DKVideo::Play(DKString& file)
{
	DKDEBUGFUNC();
	if(DKClass::HasFunc("DKSDLVideo::Play")){
		return DKClass::CallFunc("DKSDLVideo::Play", &file, NULL);
	}
	if(DKClass::HasFunc("DKOSGVideo::Play")){
		return DKClass::CallFunc("DKOSGVideo::Play", &file, NULL);
	}
	
	DKERROR("DKVideo::Play() - No function available\n");
	return false;
}