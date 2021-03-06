#pragma once
#ifndef DKSDLText_H
#define DKSDLText_H

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "SDL_ttf.h"


/////////////////////////////////////////////
class DKSDLText : public DKObjectT<DKSDLText>
{
public:
	bool Init();
	bool End();
	
	bool SetText(const DKString& text);
	void Render();

	DKSDLWindow* dkSdlWindow;
	TTF_Font* font;
	SDL_Texture* texture;
	SDL_Surface* surface;
	SDL_Color color;
};

REGISTER_OBJECT(DKSDLText, true)

#endif //DKSDLText_H