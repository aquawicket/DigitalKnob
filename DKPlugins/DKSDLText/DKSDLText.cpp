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
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKSDLText/DKSDLText.h"
#include "DK/DKFile.h"


bool DKSDLText::Init(){
	DKDEBUGFUNC();
	if(!DKSDLWindow::Valid("DKSDLWindow0"))
		return DKERROR("DKSDKWindow::Valid() failed\n");
	dkSdlWindow = DKSDLWindow::Get("DKSDLWindow0");
	if(!dkSdlWindow)
		return DKERROR("SDL window not available \n");
	TTF_Init();
	DKString file = DKFile::local_assets+"DKSDLText/arial.ttf";
	font = TTF_OpenFont(file.c_str(), 20);
    color.r = 255;
    color.g = 0;
    color.b = 0;
	SetText(toString("Test String"));
	DKSDLWindow::AddRenderFunc(&DKSDLText::Render, this);
	return true;
}

bool DKSDLText::End(){
	DKDEBUGFUNC();
	//SDL_FreeSurface(surface);
	//SDL_DestroyTexture(texture);
	//TTF_CloseFont(font);
	return true;
}

bool DKSDLText::SetText(const DKString& text){
	//DKDEBUGFUNC(text);  //EXCESSIVE LOGGING
	surface = TTF_RenderText_Solid(font, text.c_str(), color);
	texture = SDL_CreateTextureFromSurface(dkSdlWindow->renderer, surface);
	SDL_FreeSurface(surface);
	return true;
}

bool DKSDLText::Render(){
	//DKDEBUGFUNC();  //EXCESSIVE LOGGING
	
	//DEBUG CODE
	/*
	SetText("TEST");
	int dtexW = 0;
	int dtexH = 0;
	SDL_QueryTexture(texture, NULL, NULL, &dtexW, &dtexH);
	int dleft = 0;
	int dtop = 0;
	SDL_Rect ddstrect = {dleft, dtop, dtexW, dtexH};
	SDL_RenderCopy(dkSdlWindow->renderer, texture, NULL, &ddstrect);
	SDL_DestroyTexture(texture);
	*/

	//return; //remove to turn fps counter on

	//Draw fps
	unsigned int fps;
	DKUtil::GetFps(fps);
	DKString fpsString = toString(fps)+"fps";
	SetText(fpsString);
	int texW = 0;
	int texH = 0;
	SDL_QueryTexture(texture, NULL, NULL, &texW, &texH);
	int left = 5;
	int top = dkSdlWindow->height - texH;
	SDL_Rect dstrect = {left, top, texW, texH};
	SDL_RenderCopy(dkSdlWindow->renderer, texture, NULL, &dstrect);
	SDL_DestroyTexture(texture);
	return true;
}
