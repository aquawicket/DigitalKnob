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

	static bool CheckForUpdate(CefArgs args, CefReturn retval);
	static bool CreateUpdate(CefArgs args, CefReturn retval);
	static bool DoUpdate(CefArgs args, CefReturn retval);
	static bool UpdatePlugin(CefArgs args, CefReturn retval);

};

REGISTER_OBJECT(DKUpdateV8, false);

#endif //DKUpdateV8_H
#endif //USE_DKCef