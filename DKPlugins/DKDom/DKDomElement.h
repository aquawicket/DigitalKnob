//https://developer.mozilla.org/en-US/docs/Web/API/Element

#pragma once
#ifndef DKDomElement_H
#define DKDomElement_H

#include "DKDom/DKDomElement.h"
#include "DKDuktape/DKDuktape.h"


class DKDomElement : public DKObjectT<DKDomElement>
{
public:
	bool Init();
	
	static int clientHeight(duk_context* ctx);
	static int clientLeft(duk_context* ctx);
	static int clientTop(duk_context* ctx);
	static int clientWidth(duk_context* ctx);
	static int closest(duk_context* ctx);
	static int getAttribute(duk_context* ctx);
	static int getElementsByClassName(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int removeAttribute(duk_context* ctx);
	static int innerHTML(duk_context* ctx);
	static int outerHTML(duk_context* ctx);
	static int querySelector(duk_context* ctx);
	static int querySelectorAll(duk_context* ctx);
	static int scrollHeight(duk_context* ctx);
	static int scrollIntoView(duk_context* ctx);
	static int scrollLeft(duk_context* ctx);
	static int scrollTop(duk_context* ctx);
	static int scrollWidth(duk_context* ctx);
	static int setAttribute(duk_context* ctx);
	static int tagName(duk_context* ctx);
};


REGISTER_OBJECT(DKDomElement, true)

#endif //DKDomElement_H