#pragma once
#ifndef DKVncServer_H
#define DKVncServer_H
#include "DK/DK.h"
#include <rfb/rfb.h>

//DirectX Capture
#include <Wincodec.h>             // we use WIC for saving images
#include <d3d9.h>                 // DirectX 9 header
#pragma comment(lib, "d3d9.lib")  // link to DirectX 9 library
#define WIDEN2(x) L ## x
#define WIDEN(x) WIDEN2(x)
#define __WFILE__ WIDEN(__FILE__)
#define HRCHECK(__expr) {hr=(__expr);if(FAILED(hr)){wprintf(L"FAILURE 0x%08X (%i)\n\tline: %u file: '%s'\n\texpr: '" WIDEN(#__expr) L"'\n",hr, hr, __LINE__,__WFILE__);}}
#define RELEASE(__p) {if(__p!=nullptr){__p->Release();__p=nullptr;}}

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
	static rfbBool rfbCheckPasswordByList2(rfbClientPtr cl,const char* response,int len);

	static DKString capture; //GDI, DIRECTX, OPENGL
	static int _buttonMask;
	static int _key;
};


REGISTER_OBJECT(DKVncServer, true);

#endif //DKVncServer_H

