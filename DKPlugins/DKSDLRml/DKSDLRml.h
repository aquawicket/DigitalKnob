#pragma once
#ifndef DKSDLRml_H
#define DKSDLRml_H

#include <RmlUi/Core.h>
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "DKRml/DKRml.h"
#include "DKSDLRml/DKSDLRmlSystem.h"
#include "DKSDLRml/DKSDLRmlOpenGL.h"

//#include "ShellRenderInterfaceOpenGL.h"
//#define RML_SHELL_RENDER 1

///////////////////////////////////////////
class DKSDLRml : public DKObjectT<DKSDLRml>
{
public:
	bool Init();
	bool End();

	bool Handle(SDL_Event *event);
	bool Render();
	void Update();
	//void ProcessEvent(Rml::Core::Event& event);
	
	DKSDLWindow* dkSdlWindow;
	DKRml* dkRml;
#ifdef RML_SHELL_RENDER
	ShellRenderInterfaceOpenGL* Renderer;
#else
	DKSDLRmlOpenGL* Renderer;
#endif
	RmlSDL2SystemInterface* SystemInterface;
};


REGISTER_OBJECT(DKSDLRml, true)
#endif //DKSDLRml_H