#pragma once
#ifndef DKRmlElement_H
#define DKRmlElement_H

#include "DKRmlElement/RmlElementInstancer.h"

class DKRmlElement : public DKObjectT<DKRmlElement>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<RmlElementInstancer> ref;
};

REGISTER_OBJECT(DKRmlElement, true)
#endif