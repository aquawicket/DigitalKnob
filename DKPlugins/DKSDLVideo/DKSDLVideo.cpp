#include "stdafx.h"
#include "DKSDLVideo.h"


////////////////////
void DKSDLVideo::Init()
{
	DKClass::RegisterFunc("DKSDLVideo::Play", &DKSDLVideo::Play, this);
}

///////////////////
void DKSDLVideo::End()
{

}

//////////////////////////////////
void* DKSDLVideo::Play(void* data)
{
	//TODO
	DKLog("DKSDLVideo::Play(): not implemented yet. \n", DKERROR);
	return NULL;
}

