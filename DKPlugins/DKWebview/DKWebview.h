#ifdef ANDROID
#pragma once
#ifndef DKWebview_H
#define DKWebview_H

#include <jni.h>

/////////////////////////////////////////////
class DKWebview : public DKObjectT<DKWebview>
{
public:
	void Init();
	void End();
	
	static jstring jstring_rval;
	
	//void* Test(void* data);
	void* SendValue(void* data);
	void* ReceiveValue(void* data);
	
	void* GetScreenHeight(void* data);
	void* PrintFunctions(void* data);
	void* onCreate(void* data);
};

REGISTER_OBJECT(DKWebview, true)

#endif //DKWebview_H
#endif //ANDROID
