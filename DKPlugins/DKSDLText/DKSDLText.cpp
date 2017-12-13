#include "DK/stdafx.h"
#include "DKSDLText.h"
#include "SDL_ttf.h"


//////////////////////
void DKSDLText::Init()
{
	TTF_Init();
	TTF_Font* font = TTF_OpenFont(DKFile::local_assets+"DKSDLText/arial.ttf", 25);
}

/////////////////////
void DKSDLText::End()
{

}
