#ifdef USE_DKCef
#pragma once
#ifndef DKRocketV8_H
#define DKRocketV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKRocketV8 : public DKObjectT<DKRocketV8>
{
public:
	bool Init();
	bool End();

	static bool Reload(CefArgs args, CefReturn retval);
	static bool ToggleDebugger(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKRocketV8, false);

#endif //DKRocketV8_H
#endif //USE_DKCef