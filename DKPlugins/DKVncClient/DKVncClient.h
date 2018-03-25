#pragma once
#ifndef DKVncClient_H
#define DKVncClient_H
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#ifdef LINUX
typedef unsigned long z_size_t;
#endif
#include <rfb/rfbclient.h>


/////////////////////////////////////////////////
class DKVncClient : public DKObjectT<DKVncClient>
{
public:
	bool Init();
	bool End();

	static bool TestInt(int& input, int& output);
	static bool TestString(DKString& input, DKString& output);
	static bool TestReturnInt(int& output);
	static bool TestReturnString(DKString& output);

	bool Connect(const DKString& address, const DKString& password);  
	void draw();
	static void update(rfbClient* cl,int x,int y,int w,int h);
	//static rfbBool resize(rfbClient* client);
	static void kbd_leds(rfbClient* cl, int value, int pad);
	static void text_chat(rfbClient* cl, int value, char *text);
	static void got_selection(rfbClient *cl, const char *text, int len);
	static void cleanup(rfbClient* cl);
	static void resizeRectangleToReal(rfbClient *cl, int x, int y, int w, int h);
	static uint32_t get(rfbClient *cl, int x, int y);
	static void put(int x, int y, uint32_t v);
	//static void setRealDimension(rfbClient *client, int w, int h);
	bool handle(SDL_Event *e);
	static rfbKeySym SDL_key2rfbKeySym(SDL_KeyboardEvent* e);
	static char* password(rfbClient *cl);
	static bool ValidateAspectRatio(rfbClient *cl);

	static DKSDLWindow* dkSdlWindow;
	static SDL_Texture *tex;
	static rfbClient* cl;
	static int enableResizable, viewOnly, buttonMask;
	static int realWidth, realHeight, bytesPerPixel, rowStride;
	static int rightShiftKeyDown, leftShiftKeyDown;
	static const char* pass;
	static int message_wait;
	static bool seperate_loop;
	rfbBool rfbInitConnection(rfbClient* client);

	static long last_mouse_move;
};


REGISTER_OBJECT(DKVncClient, true);

#endif //DKVncClient_H

