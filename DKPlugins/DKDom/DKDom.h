#pragma once
#ifndef DKDom_H
#define DKDom_H


#include "DKDuktape/DKDuktape.h"
#include "DKRml/DKRml.h"
#include <RmlUi/Core.h>


typedef Rml::Element DKDom_Element;


class DKDom : public DKObjectT<DKDom>
{
public:
	bool Init();
	
};

REGISTER_OBJECT(DKDom, true)

#endif //DKDomElement_H