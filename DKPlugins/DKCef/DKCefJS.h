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

#if HAVE_DKDuktape 
#pragma once
#ifndef DKCefJS_H
#define DKCefJS_H

#include "DKDuktape/DKDuktape.h"

class DKCefJS : public DKObjectT<DKCefJS>
{
public:
	bool Init();
	
	//Cef js functions
	static int CloseBrowser(duk_context* ctx);
	static int CloseDevTools(duk_context* ctx);
	static int Copy(duk_context* ctx);
	static int CopyImage(duk_context* ctx);
	static int Cut(duk_context* ctx);
	static int DownloadUrl(duk_context* ctx);
	static int Find(duk_context* ctx);
	static int GetBrowserId(duk_context* ctx);
	static int GetBrowsers(duk_context* ctx);
	static int GetCurrentBrowser(duk_context* ctx);
	static int GetPageSource(duk_context* ctx);
	static int GetUrl(duk_context* ctx);
	static int GoBack(duk_context* ctx);
	static int GoForward(duk_context* ctx);
	static int NewBrowser(duk_context* ctx);
	static int Paste(duk_context* ctx);
	static int Popup(duk_context* ctx);
	static int Print(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int RemoveFocus(duk_context* ctx);
	static int RunJavascript(duk_context* ctx);
	static int SetFocus(duk_context* ctx);
	static int SetKeyboardFocus(duk_context* ctx);
	static int SetUrl(duk_context* ctx);
	static int ShowDevTools(duk_context* ctx);
	static int Stop(duk_context* ctx);
	static int ViewPageSource(duk_context* ctx);
};

REGISTER_OBJECT(DKCefJS, true)
#endif //DKCefJS_H
#endif //HAVE_DKDuktape
