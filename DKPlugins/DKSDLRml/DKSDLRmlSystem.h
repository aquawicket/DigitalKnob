#pragma once
#ifndef DKSDLRmlSystem_H
#define DKSDLRmlSystem_H

#include <RmlUi/Core.h>
#include <SDL.h>
#include "DK/DK.h"

////////////////////////////////////////////////////////////////
class RmlSDL2SystemInterface : public Rml::Core::SystemInterface
{
public:
    Rml::Core::Input::KeyIdentifier TranslateKey(SDL_Keycode sdlkey);
    int TranslateMouseButton(Uint8 button);
	int GetKeyModifiers();
    double GetElapsedTime();
    bool LogMessage(Rml::Core::Log::Type type, const Rml::Core::String& message);
};

#endif //DKSDLRmlSystem_H
