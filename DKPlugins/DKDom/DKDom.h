#pragma once
#ifndef DKDom_H
#define DKDom_H

#include <RmlUi/Core.h>
#include "DKDuktape/DKDuktape.h"
#include "DKRml/DKRml.h"

class DKDom : public DKObjectT<DKDom>
{
public:
	bool Init();
	
};

REGISTER_OBJECT(DKDom, true)

#endif //DKDomElement_H