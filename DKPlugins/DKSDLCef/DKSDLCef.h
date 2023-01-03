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
#ifndef DKSDLCef_H
#define DKSDLCef_H

//WARNING_DISABLE
	#include <list>
	#include <include/cef_client.h>
	#include <include/cef_render_handler.h>
	#include <include/cef_browser_process_handler.h>
	#include <include/cef_display_handler.h>
	#ifdef LINUX
		//#include <X11/cursorfont.h>
	#endif
	#include "SDL.h"
//WARNING_ENABLE

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCef.h"
#include "DKSDLCef/DKSDLCefKeyboard.h"
#include "DKSDLWindow/DKSDLWindow.h"


class DKSDLCefHandler;

class DKSDLCef : public DKObjectT<DKSDLCef>
{
public:
	bool Init();
	bool End();

	bool GetCefMouseButton(const int& button, CefBrowserHost::MouseButtonType& type);
	bool GetScrollDeltas(SDL_Event *event, float &deltaX, float &deltaY);
	bool GetTexture(const void* input, void* output);
	bool Handle(SDL_Event *event);
	bool OnClick(const void* input, void* output);
	bool OnMouseOver(const void* input, void* output);
	bool OnResize(const void* input, void* output);
	bool SetupCef();
	bool TransparentPixel(SDL_Event *event);
	bool Draw();
	
	DKSDLWindow* dkSdlWindow;
	SDL_Texture* popup_image;
	DKCef* dkCef;
	CefRect popup_rect;
	DKSDLCefHandler* cefHandler;
	DKSDLCefKeyboard _keyAdapter;
	bool _mouseLMBdown;
	float _scrollFactor;
};

REGISTER_OBJECT(DKSDLCef, true);

#endif //DKSDLCef_H