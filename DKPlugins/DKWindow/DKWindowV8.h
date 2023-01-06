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
#if HAVE_DKCef
#pragma once
#ifndef DKWindowV8_H
#define DKWindowV8_H

#include "DKCef/DKCef.h"


class DKWindowV8 : public DKObjectT<DKWindowV8>
{
public:
	bool Init();
	bool End();

	static bool TestInt(CefArgs args, CefReturn retval);
	static bool TestString(CefArgs args, CefReturn retval);
	static bool TestReturnInt(CefArgs args, CefReturn retval);
	static bool TestReturnString(CefArgs args, CefReturn retval);

	static bool Create(CefArgs args, CefReturn retval);
	static bool Fullscreen(CefArgs args, CefReturn retval);
	static bool GetHeight(CefArgs args, CefReturn retval);
	static bool GetMouseX(CefArgs args, CefReturn retval);
	static bool GetMouseY(CefArgs args, CefReturn retval);
	static bool GetPixelRatio(CefArgs args, CefReturn retval);
	static bool GetWidth(CefArgs args, CefReturn retval);
	static bool GetX(CefArgs args, CefReturn retval);
	static bool GetY(CefArgs args, CefReturn retval);
	static bool Hide(CefArgs args, CefReturn retval);
	static bool IsFullscreen(CefArgs args, CefReturn retval);
	static bool IsVisible(CefArgs args, CefReturn retval);
	static bool Maximize(CefArgs args, CefReturn retval);
	static bool MessageBox(CefArgs args, CefReturn retval);
	static bool Minimize(CefArgs args, CefReturn retval);
	static bool Restore(CefArgs args, CefReturn retval);
	static bool SetHeight(CefArgs args, CefReturn retval);
	static bool SetIcon(CefArgs args, CefReturn retval);
	static bool SetTitle(CefArgs args, CefReturn retval);
	static bool SetWidth(CefArgs args, CefReturn retval);
	static bool SetX(CefArgs args, CefReturn retval);
	static bool SetY(CefArgs args, CefReturn retval);
	static bool Show(CefArgs args, CefReturn retval);
	static bool Windowed(CefArgs args, CefReturn retval);
};
REGISTER_OBJECT(DKWindowV8, false);


#endif //DKWindowV8_H
#endif //HAVE_DKCef
