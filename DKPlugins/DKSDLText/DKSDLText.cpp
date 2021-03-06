#include "DK/stdafx.h"
#include "DKSDLText.h"
#include "DK/DKFile.h"

//////////////////////
bool DKSDLText::Init()
{
	if(!DKSDLWindow::Valid("DKSDLWindow0")){ return false; }
	dkSdlWindow = DKSDLWindow::Get("DKSDLWindow0");
	if(!dkSdlWindow){
		return false; //SDL window not available
	}

	TTF_Init();
	DKString file = DKFile::local_assets+"/DKSDLText/arial.ttf";
	font = TTF_OpenFont(file.c_str(), 20);
    color.r = 100;
    color.g = 100;
    color.b = 255;
	SetText(toString("Test String"));

	DKSDLWindow::AddRenderFunc(&DKSDLText::Render, this);
	return true;
}

/////////////////////
bool DKSDLText::End()
{
	//SDL_FreeSurface(surface);
	//SDL_DestroyTexture(texture);
	//TTF_CloseFont(font);
	return true;
}

/////////////////////////////////////////////
bool DKSDLText::SetText(const DKString& text)
{
	surface = TTF_RenderText_Solid(font, text.c_str(), color);
	texture = SDL_CreateTextureFromSurface(dkSdlWindow->renderer, surface);
	SDL_FreeSurface(surface);
	return true;
}

////////////////////////
void DKSDLText::Render()
{
	//DEBUG CODE
	SetText(" ");
	int dtexW = 0;
	int dtexH = 0;
	SDL_QueryTexture(texture, NULL, NULL, &dtexW, &dtexH);
	int dleft = 0;
	int dtop = 0;
	SDL_Rect ddstrect = {dleft, dtop, dtexW, dtexH};
	SDL_RenderCopy(dkSdlWindow->renderer, texture, NULL, &ddstrect);
	SDL_DestroyTexture(texture);

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
}