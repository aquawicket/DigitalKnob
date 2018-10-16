#pragma once
#ifndef DKSDLCef_H
#define DKSDLCef_H

#include <list>
#include <include/cef_client.h>
#include <include/cef_render_handler.h>
#include <include/cef_browser_process_handler.h>
#include <include/cef_display_handler.h>
#include "SDL.h"

#include "DK/DK.h"
#include "DK/DKApp.h"
#include "DKCef/DKCef.h"
#include "DKSDLCef/DKSDLCefKeyboard.h"
#include "DKSDLWindow/DKSDLWindow.h"

#ifndef WIN32
#define  UNREFERENCED_PARAMETER(P) (P)
#endif

#ifdef LINUX
//#include <X11/cursorfont.h>
#endif

class DKSDLCefHandler;

///////////////////////////////////////////
class DKSDLCef : public DKObjectT<DKSDLCef>
{
public:
	bool Init();
	bool End();

	bool GetCefMouseButton(const int& button, CefBrowserHost::MouseButtonType& type);
	bool GetScrollDeltas(SDL_Event *event, float &deltaX, float &deltaY);
	bool GetTexture(const void* input, void* output);
	bool Handle(SDL_Event *event);
	bool OnClick(const void* input, void* output);
	bool OnMouseOver(const void* input, void* output);
	bool OnResize(const void* input, void* output);
	bool SetupCef();
	bool TransparentPixel(SDL_Event *event);
	void Draw();
	
	DKSDLWindow* dkSdlWindow;
	DKCef* dkCef;
	bool _mouseLMBdown;
	DKSDLCefKeyboard _keyAdapter;
	float _scrollFactor;
	SDL_Texture* background_image;
	SDL_Texture* popup_image;
	CefRect popup_rect;
	DKSDLCefHandler* cefHandler;
};

REGISTER_OBJECT(DKSDLCef, true);

#endif //DKSDLCef_H