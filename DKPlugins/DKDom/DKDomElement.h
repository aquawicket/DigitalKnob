/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

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
	
	////// Instance properties //////
	static int assignedSlot(duk_context* ctx);		//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/assignedSlot
	static int attributes(duk_context* ctx);		//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes
	static int childElementCount(duk_context* ctx);	//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/childElementCount
	static int children(duk_context* ctx);			//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/children
	static int classList(duk_context* ctx);			//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/classList
	static int className(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/className
	static int clientHeight(duk_context* ctx);		//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientHeight
	static int clientLeft(duk_context* ctx);		//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientLeft
	static int clientTop(duk_context* ctx);			//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientTop
	static int clientWidth(duk_context* ctx);		//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/clientWidth
	static int elementTiming(duk_context* ctx);		//(Experimental) https://developer.mozilla.org/en-US/docs/Web/API/Element/elementTiming
	static int firstElementChild(duk_context* ctx);	//(Read only) https://developer.mozilla.org/en-US/docs/Web/API/Element/firstElementChild
	static int id(duk_context* ctx);				// https://developer.mozilla.org/en-US/docs/Web/API/Element/id
	static int innerHTML(duk_context* ctx);			// https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML

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