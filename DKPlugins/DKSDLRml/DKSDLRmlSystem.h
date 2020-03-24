#pragma once
#ifndef DKSDLRmlSystem_H
#define DKSDLRmlSystem_H

#include <Rocket/Core/SystemInterface.h>
#include <Rocket/Core/Input.h>
#include <SDL.h>
#include "DK/DK.h"

//////////////////////////////////////////////////////////////////////
class RocketSDL2SystemInterface : public Rocket::Core::SystemInterface
{
public:
    Rocket::Core::Input::KeyIdentifier TranslateKey(SDL_Keycode sdlkey);
    int TranslateMouseButton(Uint8 button);
	int GetKeyModifiers();
	float GetElapsedTime();
    bool LogMessage(Rocket::Core::Log::Type type, const Rocket::Core::String& message);
};

#endif //DKSDLRmlSystem_H
