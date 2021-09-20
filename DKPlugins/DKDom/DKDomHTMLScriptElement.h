//https://developer.mozilla.org/en-US/docs/Web/API/HTMLScriptElement

#pragma once
#ifndef DKDomHTMLScriptElement_H
#define DKDomHTMLScriptElement_H

#include <RmlUi/Core.h>
#include "DKDuktape/DKDuktape.h"
#include "DKRml/DKRml.h"

class DKDomHTMLScriptElement : public DKObjectT<DKDomHTMLScriptElement>
{
public:
	bool Init();
	static int async(duk_context* ctx);
};

REGISTER_OBJECT(DKDomHTMLScriptElement, true)

#endif //DKDomHTMLScriptElement_H