#pragma once
#ifndef DKSDLRml_H
#define DKSDLRml_H

#include <RmlUi/Core.h>
#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "DKRml/DKRml.h"
#include "DKSDLRml/DKSDLRmlSystem.h"

//#define USE_DKSDLRMLRENDERER 1
#define USE_DKSDLRMLOPENGL 1
//#define USE_DKSDLRMLSHELL 1

#if USE_DKSDLRMLRENDERER
#	include "DKSDLRml/DKSDLRmlRenderer.h"
#endif
#if USE_DKSDLRMLOPENGL
#	include "DKSDLRml/DKSDLRmlOpenGL.h"
#endif
#if USE_DKSDLRMLSHELL
#	include "ShellRenderInterfaceOpenGL.h"
#endif


class DKSDLRml : public DKObjectT<DKSDLRml>
{
public:
	bool Init();
	bool End();

	bool Handle(SDL_Event *event);
	bool Render();
	void Update();
	//void ProcessEvent(Rml::Core::Event& event);
	
	DKRml* dkRml;
	DKSDLWindow* dkSdlWindow;
	
#	if USE_DKSDLRMLRENDERER
		DKSDLRmlRenderer* Renderer;
#	elif USE_DKSDLRMLOPENGL
		DKSDLRmlOpenGL* Renderer;
#	elif USE_DKSDLRMLSHELL
		ShellRenderInterfaceOpenGL* Renderer;
#	endif
	RmlSDL2SystemInterface* SystemInterface;
};


REGISTER_OBJECT(DKSDLRml, true)
#endif //DKSDLRml_H