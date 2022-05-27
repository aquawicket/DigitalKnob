#pragma once
#ifndef DKRmlElementTest_H
#define DKRmlElementTest_H

#include "DKRmlElementTest/DLRmlElementTestInstancer.h"

class DKRmlElementTest : public DKObjectT<DKRmlElementTest>
{
public:
	bool Init();
	bool End();
	std::shared_ptr<ElementTestInstancer> ref;
};

REGISTER_OBJECT(DKRmlElementTest, true)
#endif //DKRocketIframe_H