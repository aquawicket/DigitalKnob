#pragma once
#ifndef DKRocketIframe_H
#define DKRocketIframe_H
#include "DKRml/DKRml.h"

///////////////////////////////////////////////////////////////////////////////////////////////
class DKRocketIframe : /*public Rocket::Core::EventListener,*/ public DKObjectT<DKRocketIframe>
{
public:
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKRocketIframe, true)
#endif //DKRocketIframe_H