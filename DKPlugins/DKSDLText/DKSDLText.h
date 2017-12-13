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
	void Init();
	void End();
	
	void Draw();

	DKSDLWindow* dkSdlWindow;
	TTF_Font* font;
	SDL_Texture* texture;
};

REGISTER_OBJECT(DKSDLText, true)

#endif //DKSDLText_H