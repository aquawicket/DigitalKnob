#pragma once
#ifndef DKRmlToRML_H
#define DKRmlToRML_H

#include "DK/DK.h"
#include <RmlUi/Core.h>
//#include <RmlUi/Controls.h>

///////////////////////////////////
class DKRmlToRML  : public DKObject
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
};

#endif //DKRmlToRML_H