/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#pragma once
#ifndef DKSdlRmlDocument_H
#define DKSdlRmlDocument_H

WARNING_DISABLE
#include <RmlUi/Core.h>
WARNING_ENABLE

#include "DK/DK.h"
#include "DKSDLWindow/DKSDLWindow.h"
#include "DKRmlInterface/DKRmlInterface.h"
#include "DKSdlRmlDocument/DKSdlRmlSystem.h"

#define USE_DKSDLRMLRENDERER 1
//#define USE_DKSDLRMLOPENGL 1
//#define USE_DKSDLRMLSHELL 1

#if USE_DKSDLRMLRENDERER
#	include "DKSdlRmlDocument/DKSdlRmlRenderer.h"
#endif
#if USE_DKSDLRMLOPENGL
#	include "DKSdlRmlDocument/DKSdlRmlOpenGL.h"
#endif
#if USE_DKSDLRMLSHELL
#	include "ShellRenderInterfaceOpenGL.h"
#endif


class DKSdlRmlDocument //: public DKObjectT<DKSdlRmlDocument>
{
public:
	DKSdlRmlDocument(DKSDLWindow* _dkSdlWindow, DKRmlInterface* _dkRmlInterface);

	bool Handle(SDL_Event *event);
	bool Render();
	void Update();
	//void ProcessEvent(Rml::Core::Event& event);
	
	DKRmlInterface* dkRmlInterface;
	DKSDLWindow* dkSdlWindow;
	
#	if USE_DKSDLRMLRENDERER
		static DKSdlRmlRenderer* Renderer;
#	elif USE_DKSDLRMLOPENGL
		DKSdlRmlOpenGL* Renderer;
#	elif USE_DKSDLRMLSHELL
		ShellRenderInterfaceOpenGL* Renderer;
#	endif

	static RmlSDL2SystemInterface* SystemInterface;

	static bool rml_render_interface_set;
};


//REGISTER_OBJECT(DKSdlRmlDocument, true)
#endif //DKSdlRmlDocument_H
