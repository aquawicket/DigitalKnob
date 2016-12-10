#pragma once
#ifndef DKUpdate_H
#define DKUpdate_H
#include "DK.h"

///////////////////////////////////////////
class DKUpdate : public DKObjectT<DKUpdate>
{
public:
	void Init();
	void End();

	bool CheckForUpdate(const DKString& url);
	bool CreateUpdate(const DKString& url);
	bool DoUpdate(const DKString& url);
};

REGISTER_OBJECT(DKUpdate, true);

#endif //DKUpdate_H