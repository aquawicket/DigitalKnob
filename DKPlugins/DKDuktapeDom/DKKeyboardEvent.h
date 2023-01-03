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

// https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent
// https://w3c.github.io/uievents/#interface-keyboardevent

#pragma once
#ifndef DKKeyboardEvent_H
#define DKKeyboardEvent_H

#include "DKDuktapeDom/DKDuktapeDom.h"


class DKKeyboardEvent : public DKObjectT<DKKeyboardEvent>
{
public:
	bool Init();
	
	// Properties
	static int altKey(duk_context* ctx);
	static int code(duk_context* ctx);
	static int ctrlKey(duk_context* ctx);
	static int isComposing(duk_context* ctx);
	static int key(duk_context* ctx);
	static int locale(duk_context* ctx);
	static int location(duk_context* ctx);
	static int metaKey(duk_context* ctx);
	static int repeat(duk_context* ctx);
	static int shiftKey(duk_context* ctx);

	// Methods
	static int getModifierState(duk_context* ctx);

	// Obsolete methods
	static int initKeyEvent(duk_context* ctx);
	static int initKeyboardEvent(duk_context* ctx);

	//Obsolete properties
	static int char1(duk_context* ctx);
	static int charCode(duk_context* ctx);
	static int keyCode(duk_context* ctx);
	static int keyIdentifier(duk_context* ctx);
	static int keyLocation(duk_context* ctx);
	static int which(duk_context* ctx);
};


REGISTER_OBJECT(DKKeyboardEvent, true)

#endif //DKKeyboardEvent_H