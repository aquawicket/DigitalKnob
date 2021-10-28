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
	
	// Properties //

	//assignedSlot
	//attributes
	//childElementCount
	//children
	//classList
	//className
	static int clientHeight(duk_context* ctx);
	static int clientLeft(duk_context* ctx);
	static int clientTop(duk_context* ctx);
	static int clientWidth(duk_context* ctx);
	//firstElementChild
	//id
	static int innerHTML(duk_context* ctx);
	//lastElementChild
	//lastElementChild
	//localName
	//namespaceURI
	//nextElementSibling
	static int outerHTML(duk_context* ctx);
	//part
	//prefix
	//previousElementSibling
	static int scrollHeight(duk_context* ctx);
	static int scrollLeft(duk_context* ctx);
	//scrollLeftMax
	static int scrollTop(duk_context* ctx);
	//scrollTopMax
	static int scrollWidth(duk_context* ctx);
	//shadowRoot
	//openOrClosedShadowRoot
	//setHTML
	//slot
	//tagName

	// Properties included from ARIA //
	//TODO

	// Event handlers
	//onfullscreenchange
	//onfullscreenerror

	// Methods //
	
	static int closest(duk_context* ctx);
	static int getAttribute(duk_context* ctx);
	static int getElementsByClassName(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
	static int hasAttribute(duk_context* ctx);
	static int removeAttribute(duk_context* ctx);
	
	
	static int querySelector(duk_context* ctx);
	static int querySelectorAll(duk_context* ctx);
	
	static int scrollIntoView(duk_context* ctx);
	
	
	
	static int setAttribute(duk_context* ctx);
	static int tagName(duk_context* ctx);
};


REGISTER_OBJECT(DKDomElement, true)

#endif //DKDomElement_H