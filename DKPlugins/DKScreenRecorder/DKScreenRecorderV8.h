#ifdef USE_DKCef
#pragma once
#ifndef DKScreenRecorderV8_H
#define DKScreenRecorderV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////////////////////
class DKScreenRecorderV8 : public DKObjectT<DKScreenRecorderV8>
{
public:
	bool Init();
	bool End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKScreenRecorderV8, false);

#endif //DKScreenRecorderV8_H
#endif //USE_DKCef