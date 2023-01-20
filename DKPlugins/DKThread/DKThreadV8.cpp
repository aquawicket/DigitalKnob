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
#ifdef HAVE_DKCef
#include "DKThread/DKThread.h"
#include "DKThread/DKThreadV8.h"


bool DKThreadV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKThread_DKQueue", &DKThreadV8::_DKQueue);
	DKV8::AttachFunction("DKThread_GetThreadNames", DKThreadV8::GetThreadNames);
	return true;
}

bool DKThreadV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKThreadV8::GetThreadNames(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString names = toString(DKThreadPool::Instance("DKThreadPool")->names, ",");
	//retval = CefV8Value::CreateString(names.c_str());
	retval->SetString(0, names.c_str());
	return true;
}

bool DKThreadV8::_DKQueue(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString name = args[0]->GetStringValue();
	DKString name = args->GetString(0);
	//DKString code = args[1]->GetStringValue();
	DKString code = args->GetString(1);
	
	DKINFO("DKThreadJS::DKQueue("+name+","+code+")\n");
//#if WIN
//	DKQueue(name, QueueItem, code); //Call in thread
//#else
	DKCef::Get()->RunJavascript(0, code); //Call directly
//#endif
	return true;
}

void DKThreadV8::QueueItem(){
	DKDEBUGFUNC();
	DKUtil::Sleep(100); //Bad!  FIXME
	//duk_context* ctx2 = DKDuktape::ctx;
	//if(!ctx2){ return; }// post error here
	
	//DKThreadPool::Get("DKThreadPool0")->tdata is also created in the main thread.. this is bad bad bad...
	DKThreadPool* dkThreadTool = DKThreadPool::Get("DKThreadPool0");
	if(!dkThreadTool){ return; }
	//duk_eval_string(ctx2, dkThreadTool->tdata[dkThreadTool->tdata.size()-1].c_str());
	DKUtil::Sleep(500); //Bad!  FIXME
}

#endif //HAVE_DKCef
