#pragma once
#ifndef DKEventTarget_H
#define DKEventTarget_H

#include "DK/DK.h"


class DKEventTarget : public DKObjectT<DKEventTarget>
{
public:
	bool Init();
	bool End();
};
REGISTER_OBJECT(DKEventTarget, false);


#endif //DKEventTarget_H