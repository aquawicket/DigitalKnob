/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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
#ifndef DKWebSocketsJS_H
#define DKWebSocketsJS_H

#include "DKDuktape/DKDuktape.h"


class DKWebSocketsJS : public DKObjectT<DKWebSocketsJS>
{
public:
	bool Init();

	static int CloseClient(duk_context* ctx);
	static int CloseServer(duk_context* ctx);
	static int CreateClient(duk_context* ctx);
	static int CreateServer(duk_context* ctx);
	static int MessageToClient(duk_context* ctx);
	static int MessageToServer(duk_context* ctx);
};
REGISTER_OBJECT(DKWebSocketsJS, true)


#endif //DKWebSocketsJS_H
#endif //HAVE_DKDuktape
