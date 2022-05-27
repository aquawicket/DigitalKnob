#pragma once
#ifndef DKRmlIframe_H
#define DKRmlIframe_H

#include "DKRmlIframe/RmlIframeInstancer.h"

class DKRmlIframe : public DKObjectT<DKRmlIframe>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<RmlIframeInstancer> ref;
};

REGISTER_OBJECT(DKRmlIframe, true)
#endif //DKRmlIframe_H