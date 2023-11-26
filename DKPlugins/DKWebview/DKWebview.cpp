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
#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWebview/DKWebview.h"


bool DKWebview::Init(){
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKWebview_PrintFunctions", &DKWebview::PrintFunctions, this);
	DKClass::RegisterFunc("DKWebview_ReceiveValue", &DKWebview::ReceiveValue, this);
	DKClass::RegisterFunc("DKWebview_SendValue", &DKWebview::SendValue, this);
	DKClass::RegisterFunc("DKWebview_Test", &DKWebview::Test, this);
	DKClass::RegisterFunc("DKWebview_onCreate", &DKWebview::onCreate, this);
	
	//FIXME: if we call WebviewActivity from here, it will be called inside SDLActivity.java, onCreate
	//This will cause SDKActivity to pause and make things go haywire. 
	//CallJavaFunction("OpenActivity", "WebviewActivity");
	return true;
}

bool DKWebview::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKWebview::onCreate(void* input, void* output){
	DKDEBUGFUNC(input, output);
#if ANDROID
	CallJavaFunction("AttachFunction", "function DKWebview_PrintFunctions(){ DK.CallCppFunction('DKWebview_PrintFunctions'); }");
	CallJavaFunction("AttachFunction", "function DKWebview_ReceiveValue(string){ DK.CallCppFunction('DKWebview_ReceiveValue,'+string); }");
	CallJavaFunction("AttachFunction", "function DKWebview_SendValue(){ return DK.CallCppFunction('DKWebview_SendValue'); }");
	CallJavaFunction("AttachFunction", "function DKWebview_Test(){ return DK.CallCppFunction('DKWebview_Test,'+string); }");
#endif
	return true;
}

bool DKWebview::Test(void* input, void* output){
	DKDEBUGFUNC(input, output);
#if ANDROID
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKINFO("DKWebview::Test("+DKString(_data)+")\n");
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKString rval = arry[0];
	*(DKString*)output = rval;
#endif
	return true;
}

bool DKWebview::SendValue(void* input, void* output){
	DKDEBUGFUNC(input, output);
#if ANDROID
	JavaData jd = *(JavaData*)input;
	DKINFO("DKWebview::SendValue()\n");
	DKString rval = "Test";
	*(DKString*)output = rval;
#endif
	return true;
}

bool DKWebview::ReceiveValue(void* input, void* output){
	DKDEBUGFUNC(input, output);
#if ANDROID
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKINFO("DKWebview::ReceiveValue("+DKString(_data)+")\n");
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKINFO("DKWebview::ReceiveValue("+DKString(_data)+"): value = "+arry[1]+"\n");
#endif
	return true;
}

bool DKWebview::PrintFunctions(void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKINFO("\n**** Webview Functions ****\n");
	DKINFO("TODO: DKWebview.cpp\n");
	return true;
}
