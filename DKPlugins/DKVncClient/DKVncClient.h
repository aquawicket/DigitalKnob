#pragma once
#ifndef DKVncClient_H
#define DKVncClient_H
#include "DK/DK.h"

/////////////////////////////////////////////////
class DKVncClient : public DKObjectT<DKVncClient>
{
public:
	void Init();
	void End();
};


REGISTER_OBJECT(DKVncClient, true);

#endif //DKVncClient_H

