#ifdef ANDROID
#include "stdafx.h"
#include "DKWebview.h"
#include "DKAndroid.h"

extern "C" {
	//extern JNIEXPORT jstring JNICALL Java_org_libsdl_app_Webview_Test(JNIEnv* env, jclass cls, jstring string);
}

//////////////////////
void DKWebview::Init()
{
	DKLog("DKWebview::Init()\n", DKDEBUG);
	
	CallJavaFunction("OpenActivity", "WebviewActivity");
	//DKClass::RegisterFunc("DKWebview_Test", &DKWebview::Test, this);
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
	Java_org_libsdl_app_WebView_Test(jd.env, jd.cls, text);
	return NULL;
}
*/

#endif //ANDROID