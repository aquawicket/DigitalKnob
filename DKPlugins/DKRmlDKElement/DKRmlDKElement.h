#pragma once
#ifndef DKRmlDKElement_H
#define DKRmlDKElement_H

#include "DKRmlDKElement/DKRmlDKElementInstancer.h"

class DKRmlDKElement : public DKObjectT<DKRmlDKElement>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<DKElementInstancer> ref;
};

REGISTER_OBJECT(DKRmlDKElement, true)
#endif //DKRocketIframe_H