#pragma once
#ifndef DKVncClient_H
#define DKVncClient_H
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include <rfb/rfbclient.h>

/////////////////////////////////////////////////
class DKVncClient : public DKObjectT<DKVncClient>
{
public:
	void Init();
	void End();

	DKSDLWindow* dkSdlWindow;
	rfbClient* cl;
};


REGISTER_OBJECT(DKVncClient, true);

#endif //DKVncClient_H

