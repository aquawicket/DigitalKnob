#ifdef USE_DKCef
#pragma once
#ifndef DKRmlV8_H
#define DKRmlV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKRmlV8 : public DKObjectT<DKRmlV8>
{
public:
	bool Init();
	bool End();

	static bool Reload(CefArgs args, CefReturn retval);
	static bool ToggleDebugger(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKRmlV8, false);

#endif //DKRmlV8_H
#endif //USE_DKCef