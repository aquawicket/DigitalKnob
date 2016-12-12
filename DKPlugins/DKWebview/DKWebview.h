#ifdef ANDROID
#pragma once
#ifndef DKWebview_H
#define DKWebview_H

#include <jni.h>

/////////////////////////////////////////////
class DKWebView : public DKObjectT<DKWebView>
{
public:
	void init();
	void End();
};

REGISTER_OBJECT(DKWebView, true)

#endif //DKWebview_H
#endif //ANDROID
