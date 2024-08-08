/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
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
#ifndef DKRmlConverter_H
#define DKRmlConverter_H

#include "DK/DK.h"

//WARNING_DISABLE
#include <RmlUi/Core.h>
//WARNING_ENABLE


class DKRmlConverter  : public DKObject{
public:
	bool HtmlToRml(const DKString& html, DKString& rml);
	bool Hyperlink(DKEvents* event);
	//bool IndexToRml(const DKString& html, DKString& rml);
	bool PostProcess(Rml::Element* element);
	static bool ResizeIframe(DKEvents* event);
	bool ClickIframe(DKEvents* event);
	bool MouseOverIframe(DKEvents* event);
	bool Encode(std::string& data);
#if HAVE_tidy_html5
	bool TidyFile(const DKString& in, DKString& out);
#endif
	bool GetOuterHtml(Rml::Element* element, DKString& string);

	DKString stored_html;
	DKString stored_rml;
	DKString processed;
};

#endif //DKRmlConverter_H
