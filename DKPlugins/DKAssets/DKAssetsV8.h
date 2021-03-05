#ifdef USE_DKCef
#pragma once
#ifndef DKAssetsV8_H
#define DKAssetsV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////////
class DKAssetsV8 : public DKObjectT<DKAssetsV8>
{
public:
	bool Init();
	bool End();

	static bool LocalAssets(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKAssetsV8, false);

#endif //DKAssetsV8_H
#endif //USE_DKCef