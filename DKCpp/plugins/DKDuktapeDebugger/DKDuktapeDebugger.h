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

#pragma once
#ifndef DKDuktapeDebugger_H
#define DKDuktapeDebugger_H
#include "DK/DK.h"
#include "DKDuktape/DKDuktape.h"

//WARNING_DISABLE
	#include "duktape.h"
	#include "DKDuktapeDebugger/duk_trans_dvalue.h"
//WARNING_ENABLE


class DKDuktapeDebugger : public DKObjectT<DKDuktapeDebugger>
{
public:
	bool Init();
	bool End();
	
	bool attach();
	static void my_cooperate(duk_trans_dvalue_ctx* ctx, int block);
	static void my_received(duk_trans_dvalue_ctx* ctx, duk_dvalue* dv);
	static void my_handshake(duk_trans_dvalue_ctx* ctx, const char* line);
	static void my_detached(duk_trans_dvalue_ctx* ctx);
	
	duk_context* ctx;
	duk_trans_dvalue_ctx* trans_ctx;
	static DKStringArray message;
};


REGISTER_OBJECT(DKDuktapeDebugger, true);

#endif //DKDuktapeDebugger_H
