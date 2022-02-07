// AUTO-GENERATED FILE. "dkapp" is renamed.

#ifdef ANDROID
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