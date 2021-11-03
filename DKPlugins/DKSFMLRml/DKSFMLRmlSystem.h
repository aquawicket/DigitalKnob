#pragma once
#ifndef DKSFMLRmlSystem_H
#define DKSFMLRmlSystem_H

#include <RmlUi/Core.h>
#include <SFML.h>
#include "DK/DK.h"

class RmlSFML2SystemInterface : public Rml::SystemInterface
{
public:
    Rml::Input::KeyIdentifier TranslateKey(SFML_Keycode sdlkey);
    int TranslateMouseButton(Uint8 button);
	int GetKeyModifiers();
    double GetElapsedTime();
    bool LogMessage(Rml::Log::Type type, const Rml::String& message);
};

#endif //DKSFMLRmlSystem_H
