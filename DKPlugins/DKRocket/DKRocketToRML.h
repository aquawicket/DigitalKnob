#pragma once
#ifndef DKRocketToRML_H
#define DKRocketToRML_H
#include "DK.h"

///////////////////
class DKRocketToRML
{
public:
	bool IndexToRml(const DKString& html, DKString& rml);
	bool HtmlToRml(const DKString& html, DKString& rml);

	void Hyperlink(DKEvent* event);
};

#endif //DKRocketToRML_H