#pragma once
#ifndef DKRmlIframe_H
#define DKRmlIframe_H

#include "DKRMLIframe/ElementIframeInstancer.h"

class DKRmlIframe : public DKObjectT<DKRmlIframe>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<ElementIframeInstancer> ref;
};

REGISTER_OBJECT(DKRmlIframe, true)
#endif //DKRocketIframe_H