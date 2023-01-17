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

#include "DKArchive/DKArchive.h"
#include "DKArchive/DKArchiveJS.h"

bool DKArchiveJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKArchive_Compress", DKArchiveJS::Compress);
	DKDuktape::AttachFunction("CPP_DKArchive_Extract", DKArchiveJS::Extract);
	return true;
}

int DKArchiveJS::Compress(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString path = duk_require_string(ctx, 0);
	DKString file = duk_require_string(ctx, 1);
	if(!DKArchive::Compress(path, file))
		return DKERROR("DKArchive::Extract() failed \n");
	return true;
}

int DKArchiveJS::Extract(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString path = duk_require_string(ctx, 1);
	if(!DKArchive::Extract(file, path)) 
		return DKERROR("DKArchive::Extract() failed \n");
	return true;
}

#endif //HAVE_DKDuktape