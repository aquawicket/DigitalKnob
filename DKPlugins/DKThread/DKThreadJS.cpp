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
#include "DKThread/DKThread.h"
#include "DKThread/DKThreadJS.h"


bool DKThreadJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKThread_DKQueue", &DKThreadJS::_DKQueue);
	DKDuktape::AttachFunction("CPP_DKThread_GetThreadNames", &DKThreadJS::GetThreadNames);
	return true;
}

int DKThreadJS::GetThreadNames(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString names = toString(DKThreadPool::Instance("DKThreadPool")->names, ",");
	duk_push_string(ctx, names.c_str());
	return 1;
}

int DKThreadJS::_DKQueue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	DKString code = duk_require_string(ctx, 1);
	DKINFO("DKThreadJS::DKQueue("+name+","+code+")\n");
#if WIN
	DKQueue(name, QueueItem, code); //Call in thread
#else
	duk_eval_string(DKDuktape::ctx, code.c_str()); //Call directly
#endif
	return 1;
}

void DKThreadJS::QueueItem(){
	DKDEBUGFUNC();
	DKUtil::Sleep(100); //Bad!  FIXME
	duk_context* ctx2 = DKDuktape::ctx;
	if(!ctx2)
		return; // post error here
	//DKDuktape::ctx = NULL;
	//Create a copy of the context to work with in a new thread..  
	//P.S.  I am very bad a threading. This needs to be fixed.

	//trying to actually mutex lock the DKDuktape::ctx variable and use it.
	//duk_context* ctx2 = (duk_context*)malloc(sizeof(DKDuktape::ctx));
	//memcpy((void*)ctx2, DKDuktape::ctx, sizeof(DKDuktape::ctx));
	
	//DKThreadPool::Get("DKThreadPool0")->tdata is also created in the main thread.. this is bad bad bad...
	DKThreadPool* dkThreadTool = DKThreadPool::Get("DKThreadPool0");
	if(!dkThreadTool)
		return;
	duk_eval_string(ctx2, dkThreadTool->tdata[dkThreadTool->tdata.size()-1].c_str());
	DKUtil::Sleep(500); //Bad!  FIXME
	//free(ctx);
	//DKDuktape::ctx = ctx2;
}

#endif //HAVE_DKThread
