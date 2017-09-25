#pragma once
#ifndef DKVncServer_H
#define DKVncServer_H
#include "DK/DK.h"
#include <rfb/rfb.h>

/////////////////////////////////////////////////
class DKVncServer : public DKObjectT<DKVncServer>
{
public:
	void Init();
	void End();
	void Loop();
};


REGISTER_OBJECT(DKVncServer, true);

#endif //DKVncServer_H

