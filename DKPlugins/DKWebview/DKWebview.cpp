#ifdef ANDROID
#include "stdafx.h"
#include "DKWebview.h"
#include "DKAndroid.h"


DKString DKWebview::dkstring_rval;


//////////////////////
void DKWebview::Init()
{
	DKLog("DKWebview::Init()\n", DKDEBUG);
	//DKClass::RegisterFunc("DKWebview_Test", &DKWebview::Test, this);
	DKClass::RegisterFunc("DK_SendValue", &DKWebview::SendValue, this);
	DKClass::RegisterFunc("DK_ReceiveValue", &DKWebview::ReceiveValue, this);
	
	DKClass::RegisterFunc("DKWebview_onCreate", &DKWebview::onCreate, this);
	DKClass::RegisterFunc("DK_PrintFunctions", &DKWebview::PrintFunctions, this);
	
	//FIXME: if we call WebviewActivity from here, it will be called inside SDLActivity.java, onCreate
	//This will cause SDKActivity to pause and make things go haywire. 
	//CallJavaFunction("OpenActivity", "WebviewActivity");
}

/////////////////////
void DKWebview::End()
{
	
}

/////////////////////////////////////
void* DKWebview::onCreate(void* data)
{
	DKLog("DKWebview::onCreate(void*)\n", DKDEBUG);
	CallJavaFunction("AttachFunction", "function DK_SendValue(){ return DK.CallCppFunction('DK_SendValue'); }");
	CallJavaFunction("AttachFunction", "function DK_ReceiveValue(string){ DK.CallCppFunction('DK_ReceiveValue,'+string); }");
	
	CallJavaFunction("AttachFunction", "function DK_PrintFunctions(){ DK.CallCppFunction('DK_PrintFunctions'); }");
	return NULL;
}

/*
/////////////////////////////////
void* DKWebview::Test(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::Test("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jstring text = jd.env->NewStringUTF(arry[0].c_str()); //var1
	return NULL;
}
*/

//////////////////////////////////////
void* DKWebview::SendValue(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	DKLog("DKWebview::SendValue()\n", DKDEBUG);
	//jstring_rval = jd.env->NewStringUTF("Test");
	
	//FIXME: this will crash android
	dkstring_rval = "Test";
	return static_cast<void*>(&dkstring_rval);
	return NULL;
}

/////////////////////////////////////////
void* DKWebview::ReceiveValue(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::ReceiveValue("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKLog("DKWebview::ReceiveValue("+DKString(_data)+"): value = "+arry[1]+"\n", DKDEBUG);
	return NULL;
}

///////////////////////////////////////////
void* DKWebview::PrintFunctions(void* data)
{
	DKLog("\n**** Webview Functions ****\n", DKINFO);
	DKLog("TODO: DKWebview.cpp\n", DKINFO);
	return NULL;
}



#endif //ANDROID