/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#pragma once
#ifndef DKVncClient_H
#define DKVncClient_H

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#ifdef LINUX
typedef unsigned long z_size_t;
#endif

//WARNING_DISABLE
#include <rfb/rfbclient.h>
//WARNING_ENABLE


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
	bool draw();
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
