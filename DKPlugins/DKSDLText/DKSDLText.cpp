#include "DK/stdafx.h"
#include "DKSDLText.h"
#include "DK/DKFile.h"


//////////////////////
void DKSDLText::Init()
{
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");

	TTF_Init();
	DKString file = DKFile::local_assets+"DKSDLText/arial.ttf";
	font = TTF_OpenFont(file.c_str(), 25);
	SDL_Color color = {255, 255, 255};
	SDL_Surface* surface = TTF_RenderText_Solid(font, "Test Text", color);
	texture = SDL_CreateTextureFromSurface(dkSdlWindow->sdlren, surface);
	SDL_FreeSurface(surface);

	DKSDLWindow::AddDrawFunc(&DKSDLText::Draw, this);
}

/////////////////////
void DKSDLText::End()
{
	SDL_DestroyTexture(texture);
	TTF_CloseFont(font);
}

//////////////////////
void DKSDLText::Draw()
{
	int texW = 0;
	int texH = 0;
	SDL_QueryTexture(texture, NULL, NULL, &texW, &texH);
	SDL_Rect dstrect = {0, 0, texW, texH};
	SDL_RenderCopy(dkSdlWindow->sdlren, texture, NULL, &dstrect);
}
