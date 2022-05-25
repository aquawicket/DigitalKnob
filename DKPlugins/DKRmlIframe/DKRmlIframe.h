#pragma once
#ifndef DKRmlIframe_H
#define DKRmlIframe_H

#include "DKRmlIframe/DKRmlIframe.h"
#include "DKRmlIframe/ElementIframe.h"
#include "DKRmlIframe/ElementIframeInstancer.h"

#include "DKRml/DKRml.h"
#include "../Include/RmlUi/Core/ElementInstancer.h"
#include "../Include/RmlUi/Core/Element.h"


class DKRmlIframe : public DKObjectT<DKRmlIframe>
{
public:
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKRmlIframe, true)
#endif //DKRocketIframe_H