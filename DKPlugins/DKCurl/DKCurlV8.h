#ifdef USE_DKCef
#pragma once
#ifndef DKCurlV8_H
#define DKCurlV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKCurlV8 : public DKObjectT<DKCurlV8>
{
public:
	bool Init();
	bool End();

	//static bool GetMidiInputs(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCurlV8, false);

#endif //DKCurlV8_H
#endif //USE_DKCef