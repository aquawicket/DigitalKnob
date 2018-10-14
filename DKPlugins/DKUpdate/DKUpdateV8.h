#ifdef USE_DKCef
#pragma once
#ifndef DKUpdateV8_H
#define DKUpdateV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKUpdateV8 : public DKObjectT<DKUpdateV8>
{
public:
	bool Init();
	bool End();

	//static bool GetMidiInputs(CefArgs args, CefReturn retval);

};

REGISTER_OBJECT(DKUpdateV8, false);

#endif //DKUpdateV8_H
#endif //USE_DKCef