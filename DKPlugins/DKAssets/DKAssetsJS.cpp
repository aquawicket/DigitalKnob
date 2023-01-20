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
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKAssets/DKAssetsJS.h"

bool DKAssetsJS::Init(){
	DKDEBUGFUNC();
	//DKDuktape::AttachFunction("CPP_DKAssets_AppendDataPath", DKAssetsJS::AppendDataPath);
	DKDuktape::AttachFunction("CPP_DKAssets_LocalAssets", DKAssetsJS::LocalAssets);
	DKDuktape::AttachFunction("CPP_DKAssets_OnlineAssets", DKAssetsJS::OnlineAssets);
	DKDuktape::AttachFunction("CPP_DKAssets_Protocol", DKAssetsJS::Protocol);
	return true;
}

//int DKAssetsJS::AppendDataPath(duk_context* ctx){
//  DKDEBUGFUNC(ctx);
//	DKString path = duk_require_string(ctx, 0);
//	if (!DKAssets::AppendDataPath(path)){ return 0; }
//	return 1;
//}

int DKAssetsJS::LocalAssets(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	duk_push_string(ctx, DKFile::local_assets.c_str());
	return 1;
}

int DKAssetsJS::OnlineAssets(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	duk_push_string(ctx, DKFile::online_assets.c_str());
	return 1;
}

int DKAssetsJS::Protocol(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	duk_push_string(ctx, "file:");
	return 1;
}

#endif //HAVE_DKDuktape
