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
#ifndef DKSFMLRml_H
#define DKSFMLRml_H

//WARNING_DISABLE
#include "RmlUi/Core.h"
//WARNING_ENABLE

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

	bool Handle(sf::Event& event);
	void Render();
	void Update();
	//void ProcessEvent(Rml::Core::Event& event);
	
	DKSFMLWindow* dkSFMLWindow;
	DKRml* dkRml;
#ifdef RML_SHELL_RENDER
	ShellRenderInterfaceOpenGL* Renderer;
#else
	RmlSFMLRenderer* renderer;
#endif
	RmlSFMLSystemInterface* systemInterface;
};
REGISTER_OBJECT(DKSFMLRml, true)
#endif //DKSFMLRml_H
