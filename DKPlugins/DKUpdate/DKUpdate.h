#pragma once
#ifndef DKUpdate_H
#define DKUpdate_H
#include "DK/DK.h"

///////////////////////////////////////////
class DKUpdate : public DKObjectT<DKUpdate>
{
public:
	void Init();
	void End();

	static bool CheckForUpdate();
	static bool CreateUpdate();
	static bool DoUpdate();

	static DKString url;
};

REGISTER_OBJECT(DKUpdate, true);

#endif //DKUpdate_H