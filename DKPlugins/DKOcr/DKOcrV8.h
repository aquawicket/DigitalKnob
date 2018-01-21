#ifdef USE_DKCef
#pragma once
#ifndef DKOcrV8_H
#define DKOcrV8_H

#include "DKCef/DKCef.h"

//////////////////////////////////////////
class DKOcrV8 : public DKObjectT<DKOcrV8>
{
public:
	void Init();
	void End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);

	static bool ImageToText(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKOcrV8, false);

#endif //DKOcrV8_H
#endif //USE_DKCef