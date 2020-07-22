#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomHTMLElement_H
#define DKDomHTMLElement_H

#include <RmlUi/Core.h>
#include "DKDuktape/DKDuktape.h"
#include "DKRml/DKRml.h"

///////////////////////////////////////////////////////////
class DKDomHTMLElement : public DKObjectT<DKDomHTMLElement>
{
public:
	bool Init();

	static int focus(duk_context* ctx);
};


REGISTER_OBJECT(DKDomHTMLElement, true)

#endif //DKDomHTMLElement_H
#endif //USE_DKDuktape