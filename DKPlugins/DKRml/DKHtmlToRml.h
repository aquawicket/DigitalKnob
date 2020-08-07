#pragma once
#ifndef DKHtmlToRml_H
#define DKHtmlToRml_H

#include "DK/DK.h"
#include <RmlUi/Core.h>

///////////////////////////////////
class DKHtmlToRml  : public DKObject
{
public:
	DKString processed;
	bool HtmlToRml(const DKString& html, DKString& rml);
	bool Hyperlink(DKEvents* event);
	bool IndexToRml(const DKString& html, DKString& rml);
	bool PostProcess(Rml::Element* element);
	static bool ResizeIframe(DKEvents* event);
	bool ClickIframe(DKEvents* event);
	bool MouseOverIframe(DKEvents* event);
	bool Encode(std::string& data);
	bool TidyFile(const DKString& in, DKString& out);
	bool GetOuterHtml(Rml::Element* element, DKString& string);
};

#endif //DKHtmlToRml_H