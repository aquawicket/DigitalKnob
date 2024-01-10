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
#ifndef DKRmlConverter_H
#define DKRmlConverter_H

#include "DK/DK.h"
#include "DKRmlInterface/DKRmlInterface.h"

WARNING_DISABLE
#include <RmlUi/Core.h>
WARNING_ENABLE


class DKRmlConverter {// : public DKObject{
public:
	static bool HtmlToRml(const DKString& html, DKString& rml);
	//bool Hyperlink(DKEvents* event);
	bool Hyperlink(DKRmlInterface* dkRmlInterface, DKEvents* event);
	//bool IndexToRml(const DKString& html, DKString& rml);
	//bool PostProcess(Rml::Element* element);
	static bool PostProcess(DKRmlInterface* dkRmlInterface, Rml::Element* element);
	//static bool ResizeIframe(DKEvents* event);
	static bool ResizeIframe(DKRmlInterface* dkRmlInterface, DKEvents* event);
	//bool ClickIframe(DKEvents* event);
	bool ClickIframe(DKRmlInterface* dkRmlInterface, DKEvents* event);
	//bool MouseOverIframe(DKEvents* event);
	bool MouseOverIframe(DKRmlInterface* dkRmlInterface, DKEvents* event);
	bool Encode(std::string& _data);
#if HAVE_tidy_html5
	bool TidyFile(const DKString& in, DKString& out);
#endif
	bool GetOuterHtml(Rml::Element* element, DKString& string);

	static DKString stored_html;
	static DKString stored_rml;
	static DKString processed;
	
	// TODO: multi-demensional map of html escape characters
	// https://mateam.net/html-escape-characters/
	// https://www.geeksforgeeks.org/implementing-multidimensional-map-in-c
	//
	//	NUMBER	SYMBOL		ENTITY		CODE		DESCRIPTION
	//
	//	9		Tab			&Tab;		&#9;		Tab
	//	10		New Line	&NewLine;	&#10;		New Line
	//	32		Space		&nbsp;		&#32;		Space
	//	33		!						&#33;		Exclamation mark
	//	34		“			&quot;		&#34;		Quotation mark
	//	35		#						&#35;		Number sign
	//	36		$						&#36;		Dollar sign
	//	37		%						&#37;		Percent sign
	//	38		&			&amp;		&#38;		Ampersand
	//	39		‘						&#39;		Apostrophe
	//	40		(						&#40;		Opening/Left Parenthesis
	//
	//	... and so on


};

#endif //DKRmlConverter_H
