#pragma once
#ifndef DKRocketCss_H
#define DKRocketCss_H
#include "DK/DK.h"
#include "DKRocket/DKRocket.h"

/////////////////////////////////////////////////
class DKRocketCss : public DKObjectT<DKRocketCss>
{
public:
	bool Init();
	bool End();

	static DKRocket* dkRocket;
};


REGISTER_OBJECT(DKRocketCss, false);

#endif //DKRocketCss_H
