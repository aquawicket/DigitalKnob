#pragma once
#ifndef DKRmlIframe_H
#define DKRmlIframe_H
#include "DKRml/DKRml.h"
#include "DKRmlIframe/ElementIframe.h"
#include "DKRmlIframe/ElementIframeInstancer.h"
#include "../include/RmlUi/Core/ElementInstancer.h"

class DKRmlIframe : public DKObjectT<DKRmlIframe>
{
public:
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKRmlIframe, true)
#endif //DKRocketIframe_H