#pragma once
#ifndef DKRocketToRML_H
#define DKRocketToRML_H
#include "DKString.h"

///////////////////
class DKRocketToRML
{
public:
	static void toRml(const DKString& html, DKString& rml);
};

#endif //DKRocketToRML_H