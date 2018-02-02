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
	void End();
	
	void SetText(DKString text);
	void Draw();

	DKSDLWindow* dkSdlWindow;
	TTF_Font* font;
	SDL_Texture* texture;
	SDL_Surface* surface;
	SDL_Color color;
};

REGISTER_OBJECT(DKSDLText, true)

#endif //DKSDLText_H