#ifdef USE_DKCef
#pragma once
#ifndef DKTrayV8_H
#define DKTrayV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKTrayV8 : public DKObjectT<DKTrayV8>
{
public:
	bool Init();
	bool End();
	
	static bool AddItem(CefArgs args, CefReturn retval);
	static bool GetIcon(CefArgs args, CefReturn retval);
	static bool SetIcon(CefArgs args, CefReturn retval);
	static bool SetTooltip(CefArgs args, CefReturn retval);
	static bool ShowBalloon(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKTrayV8, false);

#endif //DKTrayV8_H
#endif //USE_DKCef