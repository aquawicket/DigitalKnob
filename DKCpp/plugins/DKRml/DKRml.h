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
#ifndef DKRml_H
#define DKRml_H

#include "DK/DK.h"
#include "DKWindow/DKWindow.h"
#include "DKRml/DKRmlFile.h"
#include "DKRml/DKRmlConverter.h"

//WARNING_DISABLE
#include <RmlUi/Core.h>
//WARNING_ENABLE


class DKRml : public Rml::EventListener, public DKObjectT<DKRml> {
public:
	bool Init();
	bool End();
	bool GetSourceCode(DKString& source_code);
	bool LoadFont(const DKString& file);
	bool LoadFonts(DKString& directory);
	bool LoadUrl(const DKString& url);
	bool LoadHtml(const DKString& html);
	void ProcessEvent(Rml::Event& rmlEvent); //overwritten
	bool RegisterEvent(const DKString& elementAddress, const DKString& type);
	bool SendEvent(const DKString& elementAddress, const DKString& type, const DKString& value);
	bool DebuggerOff();
	bool DebuggerOn();
	bool DebuggerToggle();
	bool UnregisterEvent(const DKString& elementAddress, const DKString& type);
	static Rml::Event* addressToEvent(const DKString& address);
	static DKString eventToAddress(Rml::Event* event);
	static Rml::Element* addressToElement(const DKString& address);
	static DKString elementToAddress(Rml::Element* element);
	static bool GetOuterHTML(Rml::Element* element, DKString& outerHtml);
	static bool SetOuterHTML(Rml::Element* element, const DKString& outerHtml);
	DKString href;
	DKString protocol;
	DKString _path;
	DKString workingPath;
	Rml::Context* context;
	Rml::ElementDocument* document;
	static DKRmlFile* dkRmlFile;
	Rml::Element* hover;
	DKRmlConverter dkRmlConverter;
};

REGISTER_OBJECT(DKRml, true)
#endif //DKRml_H
