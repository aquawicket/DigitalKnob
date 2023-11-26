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
#include "DKUpdate/DKUpdate.h"
#include "DKUpdate/DKUpdateJS.h"


bool DKUpdateJS::Init(){
	DKDEBUGFUNC();
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestInt", DKUpdateJS::TestInt);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestString", DKUpdateJS::TestString);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestReturnInt", DKUpdateJS::TestReturnInt);
	//DKDuktape::AttachFunction("CPP_DKUpdate_TestReturnString", DKUpdateJS::TestReturnString);

	DKDuktape::AttachFunction("CPP_DKUpdate_CheckForUpdate", DKUpdateJS::CheckForUpdate);
	DKDuktape::AttachFunction("CPP_DKUpdate_CreateUpdate", DKUpdateJS::CreateUpdate);
	DKDuktape::AttachFunction("CPP_DKUpdate_DoUpdate", DKUpdateJS::DoUpdate);
	return true;
}

/*
int DKUpdateJS::TestInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int input = duk_require_int(ctx, 0);
	int output = DKUpdate::TestInt(input);
	duk_push_int(ctx, output);
	return true;
}

int DKUpdateJS::TestString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString input = duk_require_string(ctx, 0);
	DKString output = DKUpdate::TestString(input);
	duk_push_string(ctx, output.c_str());
	return true;
}

int DKUpdateJS::TestReturnInt(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int rval = DKWindow::TestReturnInt();
	duk_push_int(ctx, rval);
	return true;
}

int DKUpdateJS::TestReturnString(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString rval = DKUpdate::TestReturnString();
	duk_push_string(ctx, rval.c_str());
	return true;
}
*/

int DKUpdateJS::CheckForUpdate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::CheckForUpdate())
		return DKERROR("DKUpdate::CheckForUpdate() failed! \n");
	return true;
}

int DKUpdateJS::CreateUpdate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::CreateUpdate())
		return DKERROR("DKUpdate::CreateUpdate() failed! \n");
	return true;
}

int DKUpdateJS::DoUpdate(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKUpdate::DoUpdate())
		return DKERROR("DKUpdate::DoUpdate() failed! \n");
	return true;
}

int DKUpdateJS::UpdatePlugin(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKUpdate::UpdatePlugin(url))
		return DKERROR("DKUpdate::Plugin() failed! \n");
	return true;
}


#endif //HAVE_DKDuktape
