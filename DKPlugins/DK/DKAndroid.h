#ifdef ANDROID
//* http://stackoverflow.com/questions/6017646/jni-warnig-expected-return-type-l-calling-locationmanager-requestlocationupdat

#pragma once
#ifndef DKAndroid_H
#define DKAndroid_H

#define MOBILE
#define  LOG_TAG    "DKAndroid"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

#include <jni.h>
#include <string>
#include <android/log.h>
#include <iostream>
#include <stdio.h>
#include "DKString.h"

struct JavaData
{
	JNIEnv *env;
	jclass cls;
	jobject array;
	jstring data;
};

class DKAndroid
{
public:
	static void init();
	static bool GetMousePos(int& x, int& y);	
	static unsigned int android_width;
	static unsigned int android_height;
	static unsigned int android_mouseX;
	static unsigned int android_mouseY;
};

extern "C" 
{
	JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved);
	void initJNIBridge(JNIEnv * env, jobject obj);
	void exitJNIBridge(JNIEnv * env, jobject obj);
	void initSDL(JNIEnv* env, jclass cls, jobject array);
	void CallJavaFunction(const DKString& name, const DKString& param);
	jstring CallCppFunction(JNIEnv *env, jclass cls, jstring data);
};

#endif //DKAndroid_H
#endif //ANDROID
