#pragma once
#ifndef DKImageMagick_H
#define DKImageMagick_H

#include "DK/DK.h"

/////////////////////////////////////////////////////
class DKImageMagick : public DKObjectT<DKImageMagick>
{
public:
	bool Init();
	bool End();
};


REGISTER_OBJECT(DKImageMagick, true);

#endif //DKImageMagick_H

