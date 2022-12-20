/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
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
#ifndef HAVE_sdl_ttf
#	error "DKSDLText requires sdl_ttf library"
#endif 

#pragma once
#ifndef DKSDLText_H
#define DKSDLText_H

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"

//WARNING_DISABLE
#include "SDL_ttf.h"
//WARNING_ENABLE


class DKSDLText : public DKObjectT<DKSDLText>
{
public:
	bool Init();
	bool End();
	
	bool SetText(const DKString& text);
	bool Render();

	DKSDLWindow* dkSdlWindow;
	TTF_Font* font;
	SDL_Texture* texture;
	SDL_Surface* surface;
	SDL_Color color;
};


REGISTER_OBJECT(DKSDLText, true)
#endif //DKSDLText_H
