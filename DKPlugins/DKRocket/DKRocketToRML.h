#pragma once
#ifndef DKRocketToRML_H
#define DKRocketToRML_H
#include "DKString.h"

///////////////////
class DKRocketToRML
{
public:
	static bool IndexToRml(const DKString& html, DKString& rml);
	static bool HtmlToRml(const DKString& html, DKString& rml);
};

#endif //DKRocketToRML_H