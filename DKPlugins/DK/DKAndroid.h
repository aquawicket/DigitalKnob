/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#if ANDROID
//* http://stackoverflow.com/questions/6017646/jni-warnig-expected-return-type-l-calling-locationmanager-requestlocationupdat

#pragma once
#ifndef DKAndroid_H
#define DKAndroid_H

#define  LOG_TAG    "DKAndroid"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

// WARNING_DISABLE
#include <jni.h>
#include <string>
#include <android/log.h>
#include <iostream>
#include <stdio.h>
// WARNING_ENABLE

#include "DK/DKString.h"

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
	static bool GetScreenHeight(unsigned int& h);
	static bool GetScreenWidth(unsigned int& w);
	static unsigned int android_width;
	static unsigned int android_height;
	static unsigned int android_mouseX;
	static unsigned int android_mouseY;
};

extern "C" 
{
	JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *reserved);
	JNIEXPORT void Java_com_digitalknob_dk_DKApp_testFunc(JNIEnv* env, jobject thiz);
	void initJNIBridge(JNIEnv * env, jobject obj);
	void exitJNIBridge(JNIEnv * env, jobject obj);
	void initSDL(JNIEnv* env, jclass cls, jobject array);
	void CallJavaFunction(const DKString& name, const DKString& param);
	jstring CallCppFunction(JNIEnv *env, jclass cls, jstring data);
};

#endif //DKAndroid_H
#endif //ANDROID
