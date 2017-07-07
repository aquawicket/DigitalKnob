#pragma once
#ifndef DKCss_H
#define DKCss_H
#include "DK.h"


/////////////////////////////////////
class DKCss : public DKObjectT<DKCss>
{
public:
	void Init();
	void End();
};


REGISTER_OBJECT(DKCss, false);

#endif //DKCss_H
