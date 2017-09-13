#pragma once
#ifndef DKCss_H
#define DKCss_H
#include "DK/DK.h"
#include "DKRocket/DKRocket.h"

/////////////////////////////////////
class DKCss : public DKObjectT<DKCss>
{
public:
	void Init();
	void End();

	static DKRocket* dkRocket;
};


REGISTER_OBJECT(DKCss, false);

#endif //DKCss_H
