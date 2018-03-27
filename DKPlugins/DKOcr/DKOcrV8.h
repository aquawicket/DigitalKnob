#ifdef USE_DKCef
#pragma once
#ifndef DKOcrV8_H
#define DKOcrV8_H

#include "DKCef/DKCef.h"

//////////////////////////////////////////
class DKOcrV8 : public DKObjectT<DKOcrV8>
{
public:
	bool Init();
	bool End();

	static bool ImageToText(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKOcrV8, false);

#endif //DKOcrV8_H
#endif //USE_DKCef