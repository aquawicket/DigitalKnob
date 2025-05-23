/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

// https://github.com/mikke89/RmlUi
// https://mikke89.github.io/RmlUiDoc/
#pragma once
#ifndef DKRmlInterface_H
#define DKRmlInterface_H

#include "DK/DK.h"
#include "DKInterface/DKInterface.h"
#include "DKWindow/DKWindow.h"
#include "DKRmlInterface/DKRmlFile.h"

WARNING_DISABLE
#include <RmlUi/Core.h>
WARNING_ENABLE


class DKRmlInterface : virtual public DKInterface//, public Rml::EventListener //, public DKObjectT<DKRmlInterface> 
{
public:
	DKRmlInterface(DKWindow* window);
	~DKRmlInterface();
	
	bool GetSourceCode(DKString& source_code); 									//FIXME: https://stackoverflow.com/a/1367597/688352
	bool LoadFont(const DKString& file);
	bool LoadFonts(DKString& directory);
	bool LoadUrl(const DKString& url);
	bool LoadHtml(const DKString& html);
	
	DKString href_ = "";
	DKString protocol = "";
	DKString _path = "";
	static DKString workingPath; //FIXME: make un-static
	Rml::Context* context = nullptr;
	Rml::ElementDocument* document = nullptr;
	DKRmlFile* dkRmlFile = nullptr;
	Rml::Element* hover = nullptr;

	static bool rml_initialized;
	static bool rml_debugger_initialized;
	static bool rml_properties_registered;
	
	static Rml::ElementInstancer* original_html_instancer;
	static Rml::ElementInstancer* original_head_instancer;
	static Rml::ElementInstancer* original_body_instancer;	
};

//REGISTER_OBJECT(DKRmlInterface, true)
#endif //DKRmlInterface_H
