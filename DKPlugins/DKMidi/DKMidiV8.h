#ifdef USE_DKCef
#pragma once
#ifndef DKMidiV8_H
#define DKMidiV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKMidiV8 : public DKObjectT<DKMidiV8>
{
public:
	bool Init();
	bool End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKMidiV8, false);

#endif //DKMidiV8_H
#endif //USE_DKCef