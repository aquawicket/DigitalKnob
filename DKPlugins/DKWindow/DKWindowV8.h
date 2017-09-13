#ifdef USE_DKCef
#pragma once
#ifndef DKWindowV8_H
#define DKWindowV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKWindowV8 : public DKObjectT<DKWindowV8>
{
public:
	void Init();
	void End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);

	static bool SetIcon(CefArgs args, CefReturn retval);
	static bool SetTitle(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKWindowV8, false);

#endif //DKWindowV8_H
#endif //USE_DKCef