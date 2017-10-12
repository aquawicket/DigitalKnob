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

	static void DrawBuffer();
	static void clientgone(rfbClientPtr cl);
	static enum rfbNewClientAction newclient(rfbClientPtr cl);
	static void newframebuffer(rfbScreenInfoPtr screen, int width, int height);
	static void mouseevent(int buttonMask, int x, int y, rfbClientPtr cl);
	static void keyevent(rfbBool down,rfbKeySym key,rfbClientPtr cl);

	static DKString capture; //GDI, DIRECTX, OPENGL
};


REGISTER_OBJECT(DKVncServer, true);

#endif //DKVncServer_H

