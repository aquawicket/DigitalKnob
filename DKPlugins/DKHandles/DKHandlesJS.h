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

#if WIN
#if HAVE_DKDuktape 
#pragma once
#ifndef DKHandlesJS_H
#define DKHandlesJS_H

#include "DKDuktape/DKDuktape.h"


class DKHandlesJS : public DKObjectT<DKHandlesJS>
{
public:
	bool Init();

	static int Click(duk_context* ctx);
	static int CurrentHandle(duk_context* ctx);
	static int GetBottom(duk_context* ctx);
	static int GetClass(duk_context* ctx);
	static int GetIndex(duk_context* ctx);
	static int GetLeft(duk_context* ctx);
	static int GetParent(duk_context* ctx);
	static int GetRight(duk_context* ctx);
	static int GetTop(duk_context* ctx);
	static int GetValue(duk_context* ctx);
	static int GetWindow(duk_context* ctx);
	static int GetWindowIndex(duk_context* ctx);
	static int GetWindows(duk_context* ctx);
	static int NextHandle(duk_context* ctx);
	static int PrevHandle(duk_context* ctx);
	//static int SendHook(duk_context* ctx);
	static int SetHandle(duk_context* ctx);
	static int SetValue(duk_context* ctx);
	static int SetWindowHandle(duk_context* ctx);
	static int ShowWindow(duk_context* ctx);
	static int StartSearch(duk_context* ctx);
	static int ToggleHighlight(duk_context* ctx);
	static int WaitForHandle(duk_context* ctx);
	static int WaitForWindow(duk_context* ctx);
	static int WindowExists(duk_context* ctx);
};

REGISTER_OBJECT(DKHandlesJS, true)

#endif //DKHandlesJS_H
#endif //HAVE_DKDuktape
#endif //WIN32
