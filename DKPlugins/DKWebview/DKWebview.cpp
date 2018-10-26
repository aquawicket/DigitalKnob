#include "DK/stdafx.h"
#include "DK/DKAndroid.h"
#include "DKWebview/DKWebview.h"

//////////////////////
bool DKWebview::Init()
{
	DKDebug();
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
	DKDebug();
	return true;
}


///////////////////////////////////////////////////
bool DKWebview::onCreate(void* input, void* output)
{
	DKDebug(input, output);
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
	DKDebug(input, output);
#ifdef ANDROID
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

////////////////////////////////////////////////////
bool DKWebview::SendValue(void* input, void* output)
{
	DKDebug(input, output);
#ifdef ANDROID
	JavaData jd = *(JavaData*)input;
	DKINFO("DKWebview::SendValue()\n");
	DKString rval = "Test";
	*(DKString*)output = rval;
#endif
	return true;
}

///////////////////////////////////////////////////////
bool DKWebview::ReceiveValue(void* input, void* output)
{
	DKDebug(input, output);
#ifdef ANDROID
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKINFO("DKWebview::ReceiveValue("+DKString(_data)+")\n");
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKINFO("DKWebview::ReceiveValue("+DKString(_data)+"): value = "+arry[1]+"\n");
#endif
	return true;
}

/////////////////////////////////////////////////////////
bool DKWebview::PrintFunctions(void* input, void* output)
{
	DKDebug(input, output);
	DKINFO("\n**** Webview Functions ****\n");
	DKINFO("TODO: DKWebview.cpp\n");
	return true;
}
