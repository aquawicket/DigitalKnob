//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

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
	static int offsetTop(duk_context* ctx);
};


REGISTER_OBJECT(DKDomHTMLElement, true)

#endif //DKDomHTMLElement_H