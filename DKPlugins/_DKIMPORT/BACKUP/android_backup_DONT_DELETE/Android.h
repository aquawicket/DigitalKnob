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

// AUTO-GENERATED FILE. "dkapp" is renamed.

#if ANDROID
#ifndef AndroidApp_H
#define AndroidApp_H
#include "DK/DKAndroid.h"

extern "C" {

	JNIEXPORT void JNICALL Java_digitalknob_dkapp_DK_initJNIBridge(JNIEnv *env, jobject jobj){
		DKFile::exe_path = "dkapp";
		initJNIBridge(env, jobj);
	}
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_DK_exitJNIBridge(JNIEnv *env, jobject jobj){
		exitJNIBridge(env, jobj);
	}
	JNIEXPORT jstring JNICALL Java_digitalknob_dkapp_DK_CallCppFunction(JNIEnv *env, jclass cls, jstring data){
		return CallCppFunction(env, cls, data);
	}
	
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_DKMain_initJNIBridge(JNIEnv *env, jobject jobj){
		DKFile::exe_path = "dkapp";
		initJNIBridge(env, jobj);
	}
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_DKMain_exitJNIBridge(JNIEnv *env, jobject jobj){
		exitJNIBridge(env, jobj);
	}
	JNIEXPORT jstring JNICALL Java_digitalknob_dkapp_DKMain_CallCppFunction(JNIEnv *env, jclass cls, jstring data){
		return CallCppFunction(env, cls, data);
	}
	
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_SDLActivity_initJNIBridge(JNIEnv *env, jobject jobj){
		DKFile::exe_path = "dkapp";
		initJNIBridge(env, jobj);
	}
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_SDLActivity_exitJNIBridge(JNIEnv *env, jobject jobj){
		exitJNIBridge(env, jobj);
	}
	JNIEXPORT void JNICALL Java_digitalknob_dkapp_SDLActivity_initSDL(JNIEnv* env, jclass cls, jobject array){
		initSDL(env,cls,array);
	}
	/*
	JNIEXPORT jstring JNICALL Java_digitalknob_dkapp_SDLActivity_CallCppFunction(JNIEnv *env, jclass cls, jstring data){
		return CallCppFunction(env, cls, data);
	}
	*/
	
} //extern "C"


#endif
#endif