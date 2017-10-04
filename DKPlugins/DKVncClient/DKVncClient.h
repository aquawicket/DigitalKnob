#pragma once
#ifndef DKVncClient_H
#define DKVncClient_H
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include <rfb/rfbclient.h>



struct { int sdl; int rfb; } buttonMapping[]={
	{1, rfbButton1Mask},
	{2, rfbButton2Mask},
	{3, rfbButton3Mask},
	{4, rfbButton4Mask},
	{5, rfbButton5Mask},
	{0,0}
};

/////////////////////////////////////////////////
class DKVncClient : public DKObjectT<DKVncClient>
{
public:
	void Init();
	void End();

	static void update(rfbClient* cl,int x,int y,int w,int h);
	static rfbBool resize(rfbClient* client);
	static void kbd_leds(rfbClient* cl, int value, int pad);
	static void text_chat(rfbClient* cl, int value, char *text);
	static void got_selection(rfbClient *cl, const char *text, int len);
	static void cleanup(rfbClient* cl);
	static void resizeRectangleToReal(rfbClient *cl, int x, int y, int w, int h);
	static uint32_t get(rfbClient *cl, int x, int y);
	static void put(int x, int y, uint32_t v);
	static void setRealDimension(rfbClient *client, int w, int h);
	static rfbBool handleSDLEvent(rfbClient *cl, SDL_Event *e);

	DKSDLWindow* dkSdlWindow;
	rfbClient* cl;
	static int enableResizable, viewOnly, listenLoop, buttonMask;
	static int realWidth, realHeight, bytesPerPixel, rowStride;
	static char *sdlPixels;
	static int rightAltKeyDown, leftAltKeyDown;
};


REGISTER_OBJECT(DKVncClient, true);

#endif //DKVncClient_H

