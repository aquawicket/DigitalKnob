#pragma once
#ifndef DKSFMLRml_H
#define DKSFMLRml_H

#include <RmlUi/Core.h>
#include "DK/DK.h"
#include "DKSFMLWindow/DKSFMLWindow.h"
#include "DKRml/DKRml.h"
#include "DKSFMLRml/DKSFMLRmlSystem.h"
#include "DKSFMLRml/DKSFMLRmlRenderer.h"

//#include "ShellRenderInterfaceOpenGL.h"
//#define RML_SHELL_RENDER 1

class DKSFMLRml : public DKObjectT<DKSFMLRml>
{
public:
	bool Init();
	bool End();

	bool Handle(SFML_Event *event);
	void Render();
	void Update();
	//void ProcessEvent(Rml::Core::Event& event);
	
	DKSFMLWindow* dkSFMLWindow;
	DKRml* dkRml;
#ifdef RML_SHELL_RENDER
	ShellRenderInterfaceOpenGL* Renderer;
#else
	RmlSFML2Renderer* Renderer;
#endif
	RmlSFML2SystemInterface* SystemInterface;
};
REGISTER_OBJECT(DKSFMLRml, true)
#endif //DKSFMLRml_H
