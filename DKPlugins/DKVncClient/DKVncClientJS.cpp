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
#include "DKVncClient/DKVncClientJS.h"
#include "DKVncClient/DKVncClient.h"


bool DKVncClientJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKVncClient_TestInt", DKVncClientJS::TestInt);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestString", DKVncClientJS::TestString);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestReturnInt", DKVncClientJS::TestReturnInt);
	DKDuktape::AttachFunction("CPP_DKVncClient_TestReturnString", DKVncClientJS::TestReturnString);
	return true;
}

int DKVncClientJS::TestInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int input = duk_require_int(ctx, 0);
	int output;
	if(!DKVncClient::TestInt(input, output))
		return DKERROR("DKVncClient::TestInt() failed()! \n");
	duk_push_int(ctx, output);
	return true;
}

int DKVncClientJS::TestString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output;
	if(!DKVncClient::TestString(input, output))
		return DKERROR("DKVncClient::TestString() failed()! \n");
	duk_push_string(ctx, output.c_str());
	return true;
}

int DKVncClientJS::TestReturnInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int rval;
	if(!DKVncClient::TestReturnInt(rval))
		return DKERROR("DKVncClient::TestReturnInt() failed()! \n");
	duk_push_int(ctx, rval);
	return true;
}

int DKVncClientJS::TestReturnString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString rval;
	if(!DKVncClient::TestReturnString(rval))
		return DKERROR("DKVncClient::TestReturnString() failed()! \n");
	duk_push_string(ctx, rval.c_str());
	return true;
}


#endif //HAVE_DKDuktape
