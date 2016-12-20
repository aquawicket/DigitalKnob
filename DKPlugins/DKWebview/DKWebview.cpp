#ifdef ANDROID
#include "stdafx.h"
#include "DKWebview.h"
#include "DKAndroid.h"

//////////////////////
void DKWebview::Init()
{
	DKLog("DKWebview::Init()\n", DKDEBUG);
	//DKClass::RegisterFunc("DKWebview_Test", &DKWebview::Test, this);
	DKClass::RegisterFunc("DK_ReceiveValue", &DKWebview::ReceiveValue, this);
	
	DKClass::RegisterFunc("DKWebview_onCreate", &DKWebview::onCreate, this);
	DKClass::RegisterFunc("DK_GetScreenHeight", &DKWebview::GetScreenHeight, this);
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
	CallJavaFunction("AttachFunction", "function DK_ReceiveValue(string){ DK.CallCppFunction('DK_ReceiveValue,'+string); }");
	
	CallJavaFunction("AttachFunction", "function DK_GetScreenHeight(){ return DK.CallCppFunction('DK_GetScreenHeight'); }");
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

/////////////////////////////////////////
void* DKWebview::ReceiveValue(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::ReceiveValue("+DKString(_data)+")\n", DKDEBUG);
	return NULL;
}

////////////////////////////////////////////
void* DKWebview::GetScreenHeight(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	int height;
	if(DKClass::HasFunc("DKSDLWindow::GetScreenHeight")){
		height = *static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetScreenHeight"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetScreenHeight")){
		height = *static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetScreenHeight"));
	}
	else{
		DKLog("DKJS::GetScreenHeight(): no function available \n", DKERROR);
		return NULL;
	}

	jstring rval = jd.env->NewStringUTF(toString(height).c_str());
	return static_cast<void*>(&rval);
}

///////////////////////////////////////////
void* DKWebview::PrintFunctions(void* data)
{
	DKLog("\n**** Webview Functions ****\n", DKINFO);
	DKLog("TODO: DKWebview.cpp\n", DKINFO);
	return NULL;
}



#endif //ANDROID