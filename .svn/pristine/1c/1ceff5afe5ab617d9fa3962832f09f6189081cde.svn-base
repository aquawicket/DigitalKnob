//https://github.com/wheybags/libRocket/tree/sdl2/Samples/basic/sdl2

#pragma once
#ifndef DKSDLRocket_H
#define DKSDLRocket_H
#include "DK.h"
#include "DKSDLWindow.h"
#include "DKRocket.h"
#include <Rocket/Core/Core.h>
#include "DKSDLRocketSystem.h"
#include "DKSDLRocketRenderer.h"


/////////////////////////////////////////////////
class DKSDLRocket : public DKObjectT<DKSDLRocket>
{
public:
	void Init();
	void End();

	bool handle(SDL_Event *event);
	//void ProcessEvent(Rocket::Core::Event& event);
	void Draw();

	DKSDLWindow* dkSdlWindow;
	DKRocket* dkRocket;
	RocketSDL2Renderer* Renderer;
	RocketSDL2SystemInterface* SystemInterface;
};


REGISTER_OBJECT(DKSDLRocket, true)
#endif //DKSDLRocket_H