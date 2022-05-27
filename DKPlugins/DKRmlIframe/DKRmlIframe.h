#pragma once
#ifndef DKRmlIframe_H
#define DKRmlIframe_H

#include "DKRmlIframe/RmlElementInstancer.h"

class DKRmlIframe : public DKObjectT<DKRmlIframe>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<RmlElementInstancer> ref;
};

REGISTER_OBJECT(DKRmlIframe, true)
#endif