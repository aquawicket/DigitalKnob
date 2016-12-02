#pragma once
#ifndef DKCefV8_H
#define DKCefV8_H

#include "DKCef.h"

/////////////////////////////////////////
class DKCefV8 : public DKObjectT<DKCefV8>
{
public:
	void Init();
	void End();
	static bool MyFunc(CefArgs args, CefReturn retval);
	static bool DKCreate_CPP(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCefV8, false);

#endif //DKCefV8_H