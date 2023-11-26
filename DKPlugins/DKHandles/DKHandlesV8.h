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

#ifdef HAVE_DKCef
#pragma once
#ifndef DKHandlesV8_H
#define DKHandlesV8_H

#include "DKCef/DKCef.h"


class DKHandlesV8 : public DKObjectT<DKHandlesV8>
{
public:
	bool Init();
	bool End();
	
	static bool Click(CefArgs args, CefReturn retval);
	static bool CurrentHandle(CefArgs args, CefReturn retval);
	static bool GetBottom(CefArgs args, CefReturn retval);
	static bool GetClass(CefArgs args, CefReturn retval);
	static bool GetIndex(CefArgs args, CefReturn retval);
	static bool GetLeft(CefArgs args, CefReturn retval);
	static bool GetParent(CefArgs args, CefReturn retval);
	static bool GetRight(CefArgs args, CefReturn retval);
	static bool GetTop(CefArgs args, CefReturn retval);
	static bool GetValue(CefArgs args, CefReturn retval);
	static bool GetWindow(CefArgs args, CefReturn retval);
	static bool GetWindowIndex(CefArgs args, CefReturn retval);
	static bool GetWindows(CefArgs args, CefReturn retval);
	static bool NextHandle(CefArgs args, CefReturn retval);
	static bool PrevHandle(CefArgs args, CefReturn retval);
	//static bool SendHook(CefArgs args, CefReturn retval);
	static bool SetHandle(CefArgs args, CefReturn retval);
	static bool SetValue(CefArgs args, CefReturn retval);
	static bool SetWindowHandle(CefArgs args, CefReturn retval);
	static bool ShowWindow(CefArgs args, CefReturn retval);
	static bool StartSearch(CefArgs args, CefReturn retval);
	static bool ToggleHighlight(CefArgs args, CefReturn retval);
	static bool WaitForHandle(CefArgs args, CefReturn retval);
	static bool WaitForWindow(CefArgs args, CefReturn retval);
	static bool WindowExists(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKHandlesV8, false);

#endif //DKHandlesV8_H
#endif //HAVE_DKCef
