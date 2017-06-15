#ifdef USE_DKCef
#pragma once
#ifndef DKWindowV8_H
#define DKWindowV8_H

#include "DKCef.h"

///////////////////////////////////////////////
class DKWindowV8 : public DKObjectT<DKWindowV8>
{
public:
	void Init();
	void End();

	static bool Test(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKWindowV8, false);

#endif //DKWindowV8_H
#endif //USE_DKCef