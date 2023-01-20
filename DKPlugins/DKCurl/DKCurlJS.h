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

#if HAVE_DKDuktape 
#pragma once
#ifndef DKCurlJS_H
#define DKCurlJS_H

#include "DKDuktape/DKDuktape.h"

class DKCurlJS : public DKObjectT<DKCurlJS>{
public:
	bool Init();
	static int Download(duk_context* ctx);
	static int FileDate(duk_context* ctx);
	static int FtpConnect(duk_context* ctx);
	static int FtpUpload(duk_context* ctx);
	static int GetExternalIP(duk_context* ctx);
	static int HttpFileExists(duk_context* ctx);
	static int HttpToString(duk_context* ctx);
};

REGISTER_OBJECT(DKCurlJS, true)

#endif //DKCurlJS_H
#endif //HAVE_DKDuktape