#pragma once
#ifndef DKRocketToRML_H
#define DKRocketToRML_H

#include "DK/DK.h"
#include <Rocket/Core.h>
#include <Rocket/Controls.h>

//////////////////////////////////////
class DKRocketToRML  : public DKObject
{
public:
	DKString processed;
	bool HtmlToRml(const DKString& html, DKString& rml);
	bool Hyperlink(DKEvents* event);
	bool IndexToRml(const DKString& html, DKString& rml);
	bool PostProcess(Rocket::Core::Element* element);
	static bool ResizeIframe(DKEvents* event);
	bool ClickIframe(DKEvents* event);
	bool MouseOverIframe(DKEvents* event);
	bool Encode(std::string& data);
	bool TidyFile(const DKString& in, DKString& out);
};

#endif //DKRocketToRML_H