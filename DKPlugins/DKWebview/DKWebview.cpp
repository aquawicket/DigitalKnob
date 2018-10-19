#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWebview/DKWebview.h"

//////////////////////
bool DKWebview::Init()
{
	DKLog("DKWebview::Init()\n", DKDEBUG);
	
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

/////////////////////
bool DKWebview::End()
{
	return true;
}


///////////////////////////////////////////////////
bool DKWebview::onCreate(void* input, void* output)
{
	DKLog("DKWebview::onCreate()\n", DKDEBUG);
#ifdef ANDROID
	CallJavaFunction("AttachFunction", "function DKWebview_PrintFunctions(){ DK.CallCppFunction('DKWebview_PrintFunctions'); }");
	CallJavaFunction("AttachFunction", "function DKWebview_ReceiveValue(string){ DK.CallCppFunction('DKWebview_ReceiveValue,'+string); }");
	CallJavaFunction("AttachFunction", "function DKWebview_SendValue(){ return DK.CallCppFunction('DKWebview_SendValue'); }");
	CallJavaFunction("AttachFunction", "function DKWebview_Test(){ return DK.CallCppFunction('DKWebview_Test,'+string); }");
#endif
	return true;
}

///////////////////////////////////////////////
bool DKWebview::Test(void* input, void* output)
{
	DKLog("DKWebview::Test()\n", DKDEBUG);
#ifdef ANDROID
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::Test("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKString rval = arry[0];
	*(DKString*)output = rval;
#endif
	return true;
}

////////////////////////////////////////////////////
bool DKWebview::SendValue(void* input, void* output)
{
	DKLog("DKWebview::SenndValue()\n", DKDEBUG);
#ifdef ANDROID
	JavaData jd = *(JavaData*)input;
	DKLog("DKWebview::SendValue()\n", DKDEBUG);
	DKString rval = "Test";
	*(DKString*)output = rval;
#endif
	return true;
}

///////////////////////////////////////////////////////
bool DKWebview::ReceiveValue(void* input, void* output)
{
	DKLog("DKWebview::ReceiveValue()\n", DKDEBUG);
#ifdef ANDROID
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::ReceiveValue("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKLog("DKWebview::ReceiveValue("+DKString(_data)+"): value = "+arry[1]+"\n", DKDEBUG);
#endif
	return true;
}

/////////////////////////////////////////////////////////
bool DKWebview::PrintFunctions(void* input, void* output)
{
	DKLog("\n**** Webview Functions ****\n");
	DKLog("TODO: DKWebview.cpp\n");
	return true;
}
