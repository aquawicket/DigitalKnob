#include "DK/stdafx.h"
#include "DKSDLText.h"
#include "DK/DKFile.h"

//////////////////////
void DKSDLText::Init()
{
	dkSdlWindow = DKSDLWindow::Instance("DKSDLWindow0");

	TTF_Init();
	DKString file = DKFile::local_assets+"DKSDLText/arial.ttf";
	font = TTF_OpenFont(file.c_str(), 20);
	color = {255, 255, 255};
	SetText(toString("Test String"));

	fpsinit();

	DKSDLWindow::AddDrawFunc(&DKSDLText::Draw, this);
}

/////////////////////
void DKSDLText::End()
{
	//SDL_FreeSurface(surface);
	//SDL_DestroyTexture(texture);
	TTF_CloseFont(font);
}

/////////////////////////
void DKSDLText::fpsinit() 
{
	// Set all frame times to 0ms.
	memset(frametimes, 0, sizeof(frametimes));
	framecount = 0;
	framespersecond = 0;
	frametimelast = SDL_GetTicks();
}

//////////////////////////
void DKSDLText::fpsthink()
{
	Uint32 frametimesindex;
	Uint32 getticks;
	Uint32 count;
	Uint32 i;

	// frametimesindex is the position in the array. It ranges from 0 to FRAME_VALUES.
	// This value rotates back to 0 after it hits FRAME_VALUES.
	frametimesindex = framecount % FRAME_VALUES;

	getticks = SDL_GetTicks(); // store the current time
	frametimes[frametimesindex] = getticks - frametimelast; // save the frame time value
	frametimelast = getticks; // save the last frame time for the next fpsthink
	framecount++; // increment the frame count

	if(framecount < FRAME_VALUES){
		count = framecount;
	}
	else{
		count = FRAME_VALUES;
	}

	framespersecond = 0;
	for(i = 0; i < count; i++){
		framespersecond += frametimes[i];
	}

	framespersecond /= count;
	framespersecond = 1000.f / framespersecond;
	DKString fps = toString((int)framespersecond);
	fps += "fps";
	SetText(fps);
}

//////////////////////////////////////
void DKSDLText::SetText(DKString text)
{
	surface = TTF_RenderText_Solid(font, text.c_str(), color);
	texture = SDL_CreateTextureFromSurface(dkSdlWindow->sdlren, surface);
	SDL_FreeSurface(surface);
}

//////////////////////
void DKSDLText::Draw()
{
	fpsthink();
	int texW = 0;
	int texH = 0;
	SDL_QueryTexture(texture, NULL, NULL, &texW, &texH);
	int left = 5;
	int top = dkSdlWindow->height - texH;
	SDL_Rect dstrect = {left, top, texW, texH};
	SDL_RenderCopy(dkSdlWindow->sdlren, texture, NULL, &dstrect);
	SDL_DestroyTexture(texture);
}
