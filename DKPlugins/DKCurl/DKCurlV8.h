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

#if HAVE_DKCef
#pragma once
#ifndef DKCurlV8_H
#define DKCurlV8_H

#include "DKCef/DKCef.h"

class DKCurlV8 : public DKObjectT<DKCurlV8>{
public:
	bool Init();
	bool End();
	static bool Download(CefArgs args, CefReturn retval);
	static bool FileDate(CefArgs args, CefReturn retval);
	static bool FtpConnect(CefArgs args, CefReturn retval);
	static bool FtpUpload(CefArgs args, CefReturn retval);
	static bool GetExternalIP(CefArgs args, CefReturn retval);
	static bool HttpFileExists(CefArgs args, CefReturn retval);
	static bool HttpToString(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCurlV8, false);

#endif //DKCurlV8_H
#endif //HAVE_DKCef