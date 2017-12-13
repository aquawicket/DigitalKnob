#pragma once
#ifndef DKSDLText_H
#define DKSDLText_H

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "SDL_ttf.h"

// How many frames time values to keep
// The higher the value the smoother the result is...
#define FRAME_VALUES 30

/////////////////////////////////////////////
class DKSDLText : public DKObjectT<DKSDLText>
{
public:
	void Init();
	void End();
	
	void fpsinit();
	void fpsthink();

	void SetText(DKString text);
	void Draw();

	DKSDLWindow* dkSdlWindow;
	TTF_Font* font;
	SDL_Texture* texture;
	SDL_Color color;
	
	Uint32 frametimes[FRAME_VALUES]; // An array to store frame times:
	Uint32 frametimelast; // Last calculated SDL_GetTicks
	Uint32 framecount; // total frames rendered
	float framespersecond;
};

REGISTER_OBJECT(DKSDLText, true)

#endif //DKSDLText_H