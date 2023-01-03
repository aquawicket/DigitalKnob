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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

// https://developer.mozilla.org/en-US/docs/Web/API/Event

#pragma once
#ifndef DKEvent_H
#define DKEvent_H

#include "DKDuktapeDom/DKDuktapeDom.h"


class DKEvent : public DKObjectT<DKEvent>
{
public:
	bool Init();
	
	// Properties
	static int bubbles(duk_context* ctx); //Read Only
	static int cancelBubble(duk_context* ctx);
	static int cancelable(duk_context* ctx); //Read Only
	static int composed(duk_context* ctx); //Read Only
	static int currentTarget(duk_context* ctx); //Read Only
	static int deepPath(duk_context* ctx); //Not standarized
	static int defaultPrevented(duk_context* ctx); //Read Only
	static int eventPhase(duk_context* ctx); //Read Only
	static int explicitOriginalTarget(duk_context* ctx); //Read Only, Not standardized
	static int originalTarget(duk_context* ctx); //Read Only, Not standardized
	static int returnValue(duk_context* ctx);
	static int srcElement(duk_context* ctx); //Not standarized
	static int target(duk_context* ctx); //Read Only
	static int timeStamp(duk_context* ctx); //Read Only
	static int type(duk_context* ctx); //Read Only
	static int isTrusted(duk_context* ctx); //Read Only

	// Obsolete properties
	static int scoped(duk_context* ctx); //Read Only, Obsolete

	// Methods
	static int createEvent(duk_context* ctx); //Deprecated
	static int composedPath(duk_context* ctx);
	static int initEvent(duk_context* ctx); //Deprecated
	static int preventDefault(duk_context* ctx);
	static int stopImmediatePropagation(duk_context* ctx);
	static int stopPropagation(duk_context* ctx);

	// Obsolete methods
	static int getPreventDefault(duk_context* ctx); //Not standardized
	static int preventBubble(duk_context* ctx); //Not standardized, Obsolete
	static int preventCapture(duk_context* ctx); //Not standardized, Obsolete

	// Extra
	static int getParameters(duk_context* ctx);
};


REGISTER_OBJECT(DKEvent, true)

#endif //DKEvent_H