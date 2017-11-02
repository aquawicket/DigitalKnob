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
	static rfbKeySym DKVncClient::SDL_key2rfbKeySym(SDL_KeyboardEvent* e);
	static char* password(rfbClient *cl);


	static DKSDLWindow* dkSdlWindow;
	static SDL_Texture *tex;
	rfbClient* cl;
	static int enableResizable, viewOnly, buttonMask;
	static int realWidth, realHeight, bytesPerPixel, rowStride;
	static int rightAltKeyDown, leftAltKeyDown;
	static const char* pass;
	static int fps;
	static int message_wait;
};


REGISTER_OBJECT(DKVncClient, true);

#endif //DKVncClient_H

