#ifdef ANDROID
#include "stdafx.h"
#include "DKWebview.h"
#include "DKAndroid.h"

//////////////////////
void DKWebview::Init()
{
	DKLog("DKWebview::Init()\n", DKDEBUG);
	//DKClass::RegisterFunc("DKWebview_Test", &DKWebview::Test, this);
	DKClass::RegisterFunc("DKWebview_onCreate", &DKWebview::onCreate, this);
	
	//FIXME: when we call WebviewActivity from here, SDLActivity still runs and goes haywire. 
	//CallJavaFunction("OpenActivity", "WebviewActivity");
}

/////////////////////
void DKWebview::End()
{
	
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

/////////////////////////////////////
void* DKWebview::onCreate(void* data)
{
	//JavaData jd = *static_cast<JavaData*>(data);
	//const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKWebview::onCreate(void*)\n", DKDEBUG);
	//DKStringArray arry;
	//toStringArray(arry, _data, ",");
	//jstring text = jd.env->NewStringUTF(arry[0].c_str()); //var1
	return NULL;
}

#endif //ANDROID