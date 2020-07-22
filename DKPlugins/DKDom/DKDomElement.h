//https://developer.mozilla.org/en-US/docs/Web/API/Element

#pragma once
#ifndef DKDomElement_H
#define DKDomElement_H

#include <RmlUi/Core.h>
#include "DKDom/DKDomElement.h"
#include "DKDuktape/DKDuktape.h"
#include "DKRml/DKRml.h"


///////////////////////////////////////////////////
class DKDomElement : public DKObjectT<DKDomElement>
{
public:
	bool Init();
	
	static int clientHeight(duk_context* ctx);
	static int clientLeft(duk_context* ctx);
	static int clientTop(duk_context* ctx);
	static int clientWidth(duk_context* ctx);
	static int getAttribute(duk_context* ctx);
	static int getElementsByClassName(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int innerHTML(duk_context* ctx);
	static int setAttribute(duk_context* ctx);
	static int tagName(duk_context* ctx);
};


REGISTER_OBJECT(DKDomElement, true)

#endif //DKDomElement_H