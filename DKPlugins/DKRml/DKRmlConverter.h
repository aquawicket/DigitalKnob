#pragma once
#ifndef DKRmlConverter_H
#define DKRmlConverter_H

#include "DK/DK.h"
#include <RmlUi/Core.h>

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
	bool TidyFile(const DKString& in, DKString& out);
	bool GetOuterHtml(Rml::Element* element, DKString& string);

	DKString stored_html;
	DKString stored_rml;
	DKString processed;
};

#endif //DKRmlConverter_H