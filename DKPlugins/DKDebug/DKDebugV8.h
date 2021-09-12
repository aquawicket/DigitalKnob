#ifdef USE_DKCef
#pragma once
#ifndef DKDebugV8_H
#define DKDebugV8_H

#include "DKCef/DKCef.h"

class DKDebugV8 : public DKObjectT<DKDebugV8>
{
public:
	bool Init();
	bool End();
	static bool SendBugReport(CefArgs args, CefReturn retval);
	static bool ShowStackTrace(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKDebugV8, false);

#endif //DKDebugV8_H
#endif //USE_DKCef