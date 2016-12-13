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
	
	//void* Test(void* data);
	void* onCreate(void* data);
};

REGISTER_OBJECT(DKWebview, true)

#endif //DKWebview_H
#endif //ANDROID
