#ifdef USE_DKCef
#pragma once
#ifndef DKCefV8_H
#define DKCefV8_H

#include "DKCef.h"

////////////////////////////////////////////
class DKThreadV8 : public DKObjectT<DKCefV8>
{
public:
	void Init();
	void End();
	static bool MyFunc(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKThreadV8, false);

#endif //DKCefV8_H
#endif //USE_DKCef