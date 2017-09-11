#pragma once
#ifndef DKRocketToRML_H
#define DKRocketToRML_H
#include "DK.h"
#include "DKRocket.h"

/////////////////////////////////////////////////////
class DKRocketToRML : public DKObjectT<DKRocketToRML>
{
public:
	bool HtmlToRml(const DKString& html, DKString& rml);
	bool Hyperlink(DKEvent* event);
	bool IndexToRml(const DKString& html, DKString& rml);
	bool PostProcess(Rocket::Core::Element* element);
	bool ResizeIframe(DKEvent* event);
};

#endif //DKRocketToRML_H