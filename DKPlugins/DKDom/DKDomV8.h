#ifdef USE_DKCef
#pragma once
#ifndef DKDomV8_H
#define DKDomV8_H

#include "DKCef/DKCef.h"

/////////////////////////////////////////
class DKDomV8 : public DKObjectT<DKDomV8>
{
public:
	bool Init();
	bool End();

	static bool Test(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKDomV8, false);

#endif //DKDomV8_H
#endif //USE_DKCef