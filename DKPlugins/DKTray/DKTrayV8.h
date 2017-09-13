#ifdef USE_DKCef
#pragma once
#ifndef DKTrayV8_H
#define DKTrayV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKTrayV8 : public DKObjectT<DKTrayV8>
{
public:
	void Init();
	void End();
	//static bool Test(CefArgs args, CefReturn retval);
	
	static bool AddItem(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKTrayV8, false);

#endif //DKTrayV8_H
#endif //USE_DKCef