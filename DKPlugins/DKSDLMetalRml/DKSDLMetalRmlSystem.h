#pragma once
#ifndef DKSDLMetalRmlSystem_H
#define DKSDLMetalRmlSystem_H

#include <RmlUi/Core.h>
#include <SDL.h>
#include "DK/DK.h"

///////////////////////////////////////////////////////////
class RmlSDL2SystemInterface : public Rml::SystemInterface
{
public:
    Rml::Input::KeyIdentifier TranslateKey(SDL_Keycode sdlkey);
    int TranslateMouseButton(Uint8 button);
	int GetKeyModifiers();
    double GetElapsedTime();
    bool LogMessage(Rml::Log::Type type, const Rml::String& message);
};

#endif //DKSDLMetalRmlSystem_H
