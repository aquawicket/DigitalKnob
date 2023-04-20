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
#include "DK/stdafx.h"
#include "DKSdlWindow/DKSdlWindowAndroid.h"
#include "DK/DKAndroid.h"

WARNING_DISABLE
#include "SDL.h"
//#include "SDL_main.h"
WARNING_ENABLE

extern "C" {
	//extern JavaVM* thejvm;
	extern jint JNICALL JNI_OnLoad2(JNIEnv* env);
	extern void SDL_Android_Init(JNIEnv* env, jclass cls);
	extern void Java_org_libsdl_app_SDLActivity_onNativeDropFile(JNIEnv* env, jclass jcls, jstring filename);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeResize(JNIEnv* env, jclass jcls, jint width, jint height, jint format, jfloat rate);
	//extern JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_onNativePadDown(JNIEnv* env, jclass jcls, jint device_id, jint keycode);
	//extern JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_onNativePadUp(JNIEnv* env, jclass jcls, jint device_id, jint keycode);
	//extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeJoy(JNIEnv* env, jclass jcls, jint device_id, jint axis, jfloat value);
	//extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeHat(JNIEnv* env, jclass jcls, jint device_id, jint hat_id, jint x, jint y);
	//extern JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_nativeAddJoystick(JNIEnv* env, jclass jcls, jint device_id, jstring device_name, jint is_accelerometer, jint nbuttons, jint naxes, jint nhats, jint nballs);
	//extern JNIEXPORT jint JNICALL Java_org_libsdl_app_SDLActivity_nativeRemoveJoystick(JNIEnv* env, jclass jcls, jint device_id);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeSurfaceChanged(JNIEnv* env, jclass jcls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeSurfaceDestroyed(JNIEnv* env, jclass jcls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyDown(JNIEnv* env, jclass jcls, jint keycode);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyUp(JNIEnv* env, jclass jcls, jint keycode);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeKeyboardFocusLost(JNIEnv* env, jclass jcls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeTouch(JNIEnv* env, jclass jcls, jint touch_device_id_in, jint pointer_finger_id_in, jint action, jfloat x, jfloat y, jfloat p);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeMouse(JNIEnv* env, jclass jcls, jint button, jint action, jfloat x, jfloat y);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_onNativeAccel(JNIEnv* env, jclass jcls, jfloat x, jfloat y, jfloat z);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeLowMemory(JNIEnv* env, jclass cls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeQuit(JNIEnv* env, jclass cls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativePause(JNIEnv* env, jclass cls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLActivity_nativeResume(JNIEnv* env, jclass cls);
	extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLInputConnection_nativeCommitText(JNIEnv* env, jclass cls, jstring text, jint newCursorPosition);
	//extern JNIEXPORT void JNICALL Java_org_libsdl_app_SDLInputConnection_nativeSetComposingText(JNIEnv* env, jclass cls, jstring text, jint newCursorPosition);
	extern JNIEXPORT jstring JNICALL Java_org_libsdl_app_SDLActivity_nativeGetHint(JNIEnv* env, jclass cls, jstring name);
}

bool DKSdlWindowAndroid::Init(){
	DKDEBUGFUNC();
	DKClass::RegisterFunc("DKAndroid_onAccel", &DKSdlWindowAndroid::onAccel, this);
	//DKClass::RegisterFunc("DKAndroid_onAddJoystick", &DKSdlWindowAndroid::onAddJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onCommitText", &DKSdlWindowAndroid::onCommitText, this);
	DKClass::RegisterFunc("DKAndroid_onDropFile", &DKSdlWindowAndroid::onDropFile, this);
	DKClass::RegisterFunc("DKAndroid_onGetHint", &DKSdlWindowAndroid::onGetHint, this);
	//DKClass::RegisterFunc("DKAndroid_onHat", &DKSdlWindowAndroid::onHat, this);
	DKClass::RegisterFunc("DKAndroid_onInitSDL", &DKSdlWindowAndroid::onInitSDL, this);
	//DKClass::RegisterFunc("DKAndroid_onJoy", &DKSdlWindowAndroid::onJoy, this);
	DKClass::RegisterFunc("DKAndroid_onKeyDown", &DKSdlWindowAndroid::onKeyDown, this);
	DKClass::RegisterFunc("DKAndroid_onKeyUp", &DKSdlWindowAndroid::onKeyUp, this);
	DKClass::RegisterFunc("DKAndroid_onKeyboardFocusLost", &DKSdlWindowAndroid::onKeyboardFocusLost, this);
	DKClass::RegisterFunc("DKAndroid_onLowMemory", &DKSdlWindowAndroid::onLowMemory, this);
	DKClass::RegisterFunc("DKAndroid_onMouse", &DKSdlWindowAndroid::onMouse, this);
	//DKClass::RegisterFunc("DKAndroid_onPadDown", &DKSdlWindowAndroid::onPadDown, this);
	//DKClass::RegisterFunc("DKAndroid_onPadUp", &DKSdlWindowAndroid::onPadUp, this);
	DKClass::RegisterFunc("DKAndroid_onPause", &DKSdlWindowAndroid::onPause, this);
	DKClass::RegisterFunc("DKAndroid_onQuit", &DKSdlWindowAndroid::onQuit, this);
	//DKClass::RegisterFunc("DKAndroid_onRemoveJoystick", &DKSdlWindowAndroid::onRemoveJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onResize", &DKSdlWindowAndroid::onResize, this);
	DKClass::RegisterFunc("DKAndroid_onResume", &DKSdlWindowAndroid::onResume, this);
	//DKClass::RegisterFunc("DKAndroid_onSetComposingText", &DKSdlWindowAndroid::onSetComposingText, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceChanged", &DKSdlWindowAndroid::onSurfaceChanged, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceDestroyed", &DKSdlWindowAndroid::onSurfaceDestroyed, this);
	DKClass::RegisterFunc("DKAndroid_onTouch", &DKSdlWindowAndroid::onTouch, this);
	return true;
}

bool DKSdlWindowAndroid::End(){
	DKDEBUGFUNC();
	return true;
}
	
bool DKSdlWindowAndroid::onInitSDL(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;

    int i;
    int argc;
    //int status = 0;

	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles");
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 1); 
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 1); 
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_ES);
	
    /* This interface could expand with ABI negotiation, callbacks, etc. */
	JNI_OnLoad2(jd.env);
    //SDL_Android_Init(jd.env, jd.cls);
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles");
    SDL_SetMainReady();
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles");

    // Prepare the arguments.
	jsize len = jd.env->GetArrayLength((jarray)jd.array);
    char* argv[1 + len + 1];
    argc = 0;
    // Use the name "app_process" so PHYSFS_platformCalcBaseDir() works.
    // https://bitbucket.org/MartinFelis/love-android-sdl2/issue/23/release-build-crash-on-start

    argv[argc++] = SDL_strdup("app_process");
    for (i = 0; i < len; ++i) {
        const char* utf;
        char* arg = NULL;
		jstring string = (jstring)jd.env->GetObjectArrayElement((jobjectArray)jd.array, i);
        if (string) {
			utf = jd.env->GetStringUTFChars(string, 0);
            if (utf) {
                arg = SDL_strdup(utf);
				jd.env->ReleaseStringUTFChars(string, utf);
            }
			jd.env->DeleteLocalRef(string);
        }
        if (!arg) {
            arg = SDL_strdup("");
        }
        argv[argc++] = arg;
    }
    argv[argc] = NULL;

    // Run the application.
    //status = SDL_main(argc, argv);

    // Release the arguments. 

    for (i = 0; i < argc; ++i) {
        //SDL_free(argv[i]);
    }

    // Do not issue an exit or the whole application will terminate instead of just the SDL thread 
    // exit(status); 
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles");
	
	//*(int*)output = status;
	return true;
	//we just run our own loop after this..   for now.  (DKApp::Loop), it's called from SDLActivity.jave as  CallCppFunction("loop")
}

bool DKSdlWindowAndroid::onDropFile(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jstring filename = jd.env->NewStringUTF(arry[1].c_str());
	Java_org_libsdl_app_SDLActivity_onNativeDropFile(jd.env, jd.cls, filename);
	return true;
}

bool DKSdlWindowAndroid::onResize(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint width = toInt(arry[1]);
	jint height = toInt(arry[2]);
	jint format = toInt(arry[3]);
	jfloat rate = toFloat(arry[4]);
	Java_org_libsdl_app_SDLActivity_onNativeResize(jd.env, jd.cls, width, height, format, rate);
	return true;
}

/*
bool DKSdlWindowAndroid::onPadDown(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jint keycode = toInt(arry[2]);
	jint rval = Java_org_libsdl_app_SDLActivity_onNativePadDown(jd.env, jd.cls, device_id, keycode);
	
	char buf[64]; // assumed large enough to cope with result
	sprintf(buf, "%d", rval);  // error checking omitted
	jstring val = jd.env->NewStringUTF(buf);  
	//return static_cast<void*>(&val);
	output = &val;
	return true;
}

bool DKSdlWindowAndroid::onPadUp(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jint keycode = toInt(arry[2]);
	jint rval = Java_org_libsdl_app_SDLActivity_onNativePadUp(jd.env, jd.cls, device_id, keycode);
	
	char buf[64]; // assumed large enough to cope with result
	sprintf(buf, "%d", rval);  // error checking omitted
	jstring val = jd.env->NewStringUTF(buf);  
	//return static_cast<void*>(&val);
	output = &val;
	return true;
}

bool DKSdlWindowAndroid::onJoy(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jint axis = toInt(arry[2]);
	jfloat value = toFloat(arry[3]);
	Java_org_libsdl_app_SDLActivity_onNativeJoy(jd.env, jd.cls, device_id, axis, value);
	return true;
}

bool DKSdlWindowAndroid::onHat(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jint hat_id = toInt(arry[2]);
	jint x = toInt(arry[3]);
	jint y = toInt(arry[4]);
	Java_org_libsdl_app_SDLActivity_onNativeHat(jd.env, jd.cls, device_id, hat_id, x, y);
	return true;
}

bool DKSdlWindowAndroid::onAddJoystick(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jstring device_name = jd.env->NewStringUTF(arry[2].c_str());
	jint is_accelerometer = toInt(arry[3]);
	jint nbuttons = toInt(arry[4]);
	jint naxes = toInt(arry[5]);
	jint nhats = toInt(arry[6]);
	jint nballs = toInt(arry[7]);
	jint rval = Java_org_libsdl_app_SDLActivity_nativeAddJoystick(jd.env, jd.cls, device_id, device_name, is_accelerometer, nbuttons, naxes, nhats, nballs);
	
	char buf[64]; // assumed large enough to cope with result
	sprintf(buf, "%d", rval);  // error checking omitted
	jstring val = jd.env->NewStringUTF(buf);
	//return static_cast<void*>(&val);
	output = &val;
	return true;
}

bool DKSdlWindowAndroid::onRemoveJoystick(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint device_id = toInt(arry[1]);
	jint rval = Java_org_libsdl_app_SDLActivity_nativeRemoveJoystick(jd.env, jd.cls, device_id);
	
	char buf[64]; // assumed large enough to cope with result
	sprintf(buf, "%d", rval);  // error checking omitted
	jstring val = jd.env->NewStringUTF(buf);  
	//return static_cast<void*>(&val);
	output = &val;
	return true;
}
*/

bool DKSdlWindowAndroid::onSurfaceChanged(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_onNativeSurfaceChanged(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onSurfaceDestroyed(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_onNativeSurfaceDestroyed(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onKeyDown(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvents::SendEvent("window", "keydown", arry[1]);
	}
	else{
		jint keycode = toInt(arry[1]);
		Java_org_libsdl_app_SDLActivity_onNativeKeyDown(jd.env, jd.cls, keycode);
	}
	return true;
}

bool DKSdlWindowAndroid::onKeyUp(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvents::SendEvent("window", "keyup", arry[1]);
	}
	else{
		jint keycode = toInt(arry[1]);
		Java_org_libsdl_app_SDLActivity_onNativeKeyUp(jd.env, jd.cls, keycode);
	}
	return true;
}

bool DKSdlWindowAndroid::onKeyboardFocusLost(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_onNativeKeyboardFocusLost(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onTouch(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint touch_device_id_in = toInt(arry[1]);
	jint pointer_finger_id_in = toInt(arry[2]);
	jint action = toInt(arry[3]);
	jfloat x = toFloat(arry[4]);
	jfloat y = toFloat(arry[5]);
	jfloat p = toFloat(arry[6]);
	Java_org_libsdl_app_SDLActivity_onNativeTouch(jd.env, jd.cls, touch_device_id_in, pointer_finger_id_in, action, x, y, p);
	return true;
}

bool DKSdlWindowAndroid::onMouse(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jint button = toInt(arry[1]);
	jint action = toInt(arry[2]);
	jfloat x = toFloat(arry[3]);
	jfloat y = toFloat(arry[4]);
	Java_org_libsdl_app_SDLActivity_onNativeMouse(jd.env, jd.cls, button, action, x, y);
	return true;
}

bool DKSdlWindowAndroid::onAccel(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jfloat x = toFloat(arry[1]);
	jfloat y = toFloat(arry[2]);
	jfloat z = toFloat(arry[3]);
	Java_org_libsdl_app_SDLActivity_onNativeAccel(jd.env, jd.cls, x, y, z);
	return true;
}

bool DKSdlWindowAndroid::onLowMemory(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_nativeLowMemory(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onQuit(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_nativeQuit(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onPause(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	DKApp::paused = true;
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_nativePause(jd.env, jd.cls);
	return true;
}

bool DKSdlWindowAndroid::onResume(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
    Java_org_libsdl_app_SDLActivity_nativeResume(jd.env, jd.cls);
	DKApp::paused = false;
	return true;
}

bool DKSdlWindowAndroid::onCommitText(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jstring text = jd.env->NewStringUTF(arry[1].c_str());
	jint newCursorPosition = toInt(arry[2]);
	Java_org_libsdl_app_SDLInputConnection_nativeCommitText(jd.env, jd.cls, text, newCursorPosition);
	return true;
}

/*
bool DKSdlWindowAndroid::onSetComposingText(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jstring text = jd.env->NewStringUTF(arry[1].c_str());
	jint newCursorPosition = toInt(arry[2]);
	Java_org_libsdl_app_SDLInputConnection_nativeSetComposingText(jd.env, jd.cls, text, newCursorPosition);
	return true;
}
*/

bool DKSdlWindowAndroid::onGetHint(const void* input, void* output){
	DKDEBUGFUNC(input, output);
	JavaData jd = *(JavaData*)input;
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	jstring name = jd.env->NewStringUTF(arry[1].c_str());
	jstring rval = Java_org_libsdl_app_SDLActivity_nativeGetHint(jd.env, jd.cls, name);
	//return static_cast<void*>(&rval);
	output = &rval;
	return true;
}


#endif //ANDROID
