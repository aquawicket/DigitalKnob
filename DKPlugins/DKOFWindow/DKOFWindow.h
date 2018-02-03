#pragma once
#ifndef DKOFWindow_H
#define DKOFWindow_H
#include "DK.h"


////////////////////////////////////////////////
class DKOFWindow : public DKObjectT<DKOFWindow>
{
public:
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKOFWindow, true)

#endif //DKOFWindow_H
