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
#ifdef HAVE_DKDuktape 
#pragma once
#ifndef DKWindowJS_H
#define DKWindowJS_H

#include "DKDuktape/DKDuktape.h"


class DKWindowJS : public DKObjectT<DKWindowJS>
{
public:
	bool Init();

	static int TestInt(duk_context* ctx);
	static int TestString(duk_context* ctx);
	static int TestReturnInt(duk_context* ctx);
	static int TestReturnString(duk_context* ctx);

	//static int GetGLMajorVersion(duk_context* ctx);
	//static int GetGLMinorVersion(duk_context* ctx);
	//static int GetGLVersion(duk_context* ctx);
	//static int GetGLVendor(duk_context* ctx);
	//static int GetGLRenderer(duk_context* ctx);

	static int Create(duk_context* ctx);
	static int Fullscreen(duk_context* ctx);
	static int GetHeight(duk_context* ctx);
	static int GetMouseX(duk_context* ctx);
	static int GetMouseY(duk_context* ctx);
	static int GetPixelRatio(duk_context* ctx);
	static int GetWidth(duk_context* ctx);
	static int GetX(duk_context* ctx);
	static int GetY(duk_context* ctx);
	static int Hide(duk_context* ctx);
	static int IsFullscreen(duk_context* ctx);
	static int IsVisible(duk_context* ctx);
	static int Maximize(duk_context* ctx);
	static int MessageBox(duk_context* ctx);
	static int Minimize(duk_context* ctx);
	static int moveTo(duk_context* ctx);
	static int resizeTo(duk_context* ctx);
	static int Restore(duk_context* ctx);
	static int SetHeight(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
	static int SetTitle(duk_context* ctx);
	static int SetWidth(duk_context* ctx);
	static int SetX(duk_context* ctx);
	static int SetY(duk_context* ctx);
	static int Show(duk_context* ctx);
	static int Windowed(duk_context* ctx);
};
REGISTER_OBJECT(DKWindowJS, true)


#endif //DKWindowJS_H
#endif //HAVE_DKDuktape
