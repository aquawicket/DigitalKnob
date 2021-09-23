//https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement

#pragma once
#ifndef DKDomHTMLElement_H
#define DKDomHTMLElement_H

#include "DKDuktape/DKDuktape.h"


///////////////////////////////////////////////////////////
class DKDomHTMLElement : public DKObjectT<DKDomHTMLElement>
{
public:
	bool Init();

	static int focus(duk_context* ctx);
	static int offsetHeight(duk_context* ctx);
	static int offsetLeft(duk_context* ctx);
	static int offsetParent(duk_context* ctx);
	static int offsetTop(duk_context* ctx);
	static int offsetWidth(duk_context* ctx);
};


REGISTER_OBJECT(DKDomHTMLElement, true)

#endif //DKDomHTMLElement_H