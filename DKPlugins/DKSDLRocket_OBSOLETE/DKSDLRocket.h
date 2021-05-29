//https://github.com/wheybags/libRocket/tree/sdl2/Samples/basic/sdl2
#pragma once
#ifndef DKSDLRocket_H
#define DKSDLRocket_H

#include <Rocket/Core/Core.h>
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "DKRocket/DKRocket.h"
#include "DKSDLRocket/DKSDLRocketSystem.h"
#include "DKSDLRocket/DKSDLRocketRenderer.h"

//#include "ShellRenderInterfaceOpenGL.h"
//#define ROCKET_SHELL_RENDER 1

/////////////////////////////////////////////////
class DKSDLRocket : public DKObjectT<DKSDLRocket>
{
public:
	bool Init();
	bool End();

	bool Handle(SDL_Event *event);
	void Draw();
	//void ProcessEvent(Rocket::Core::Event& event);
	
	DKSDLWindow* dkSdlWindow;
	DKRocket* dkRocket;
#ifdef ROCKET_SHELL_RENDER
	ShellRenderInterfaceOpenGL* Renderer;
#else
	RocketSDL2Renderer* Renderer;
#endif
	RocketSDL2SystemInterface* SystemInterface;
};


REGISTER_OBJECT(DKSDLRocket, true)
#endif //DKSDLRocket_H