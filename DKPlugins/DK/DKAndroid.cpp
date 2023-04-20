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

#include "DK/stdafx.h"

#if ANDROID
#include "DK/DKAndroid.h"
#include "DK/DKApp.h"
#include "DK/DKClass.h"

# if HAVE_sdl
	#include "SDL.h"
#endif

unsigned int DKAndroid::android_width = 800;
unsigned int DKAndroid::android_height = 480;
unsigned int DKAndroid::android_mouseX = 0;
unsigned int DKAndroid::android_mouseY = 0;

extern "C" {

	static JavaVM* thejvm = 0;
	static jobject theobj = 0;

	//JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved){
	JNIEXPORT jint JNI_OnLoad2(JavaVM* vm, void* reserved){
		DKDEBUGFUNC(vm, reserved);
		thejvm = vm;
		return JNI_VERSION_1_6;
	}

	JNIEXPORT void Java_com_digitalknob_dk_DKApp_testFunc(JNIEnv* env, jobject thiz){
		DKINFO("Java_com_digitalknob_dk_DKApp_testFunc() \n");
	}

	void initJNIBridge(JNIEnv* env, jobject obj){
		DKDEBUGFUNC(env, obj);
		theobj = env->NewGlobalRef(obj);
	}

	void exitJNIBridge(JNIEnv* env, jobject obj){
		DKDEBUGFUNC(env, obj);
		env->DeleteGlobalRef(theobj);
	}

	//FIXME: this needs to fail without crashing
	void CallJavaFunction(const DKString& name, const DKString& param){
		DKDEBUGFUNC(name, param);
		JNIEnv* env;
		bool attached = false;
		switch(thejvm->GetEnv((void**)&env, JNI_VERSION_1_6)){
			case JNI_OK:
				break;
			case JNI_EDETACHED:
				if (thejvm->AttachCurrentThread(&env, NULL)!=0)
					DKERROR("failed to attech jvm\n");
				attached = true;
				break;
			case JNI_EVERSION:
				DKERROR("jni version not supported\n");
		}
		jclass cls = env->GetObjectClass(theobj);
		if (!cls){
			DKERROR("Could not get cls\n");
			return;
		}
		//Call void function
		if(param.empty()){
			jmethodID method = env->GetMethodID(cls, name.c_str(), "()V");
			if(!method){
				DKERROR("Could not get method\n");
				return;
			}
			env->CallVoidMethod(theobj, method);
			return;
		}
		//Call function with string parameter
		jmethodID method = env->GetMethodID(cls, name.c_str(), "(Ljava/lang/String;)V");
		if (!method){
			DKERROR("Could not get method\n");
			return;
		}
		jstring jstr = env->NewStringUTF(param.c_str());
		env->CallVoidMethod(theobj, method, jstr);
		return;
	}

	void initSDL(JNIEnv* env, jclass cls, jobject array){
		DKDEBUGFUNC(env, cls, array);
		JavaData jdata;
		jdata.env = env;
		jdata.cls = cls;
		jdata.array = array;
		DKClass::DKCreate("DKSdlWindowAndroid");
		DKClass::CallFunc("DKAndroid_onInitSDL", &jdata);
	}

	jstring CallCppFunction(JNIEnv* env, jclass cls, jstring data){
		DKDEBUGFUNC(env, cls, data);
		const char* _data = env->GetStringUTFChars(data,JNI_FALSE);
		DKStringArray arry;
		toStringArray(arry, _data, ",");
		if(same(arry[0],"DKAndroid_init")){
			if(arry.size() > 2){
				DKAndroid::android_width = toInt(arry[1]);
				DKAndroid::android_height = toInt(arry[2]);
			}
			DKAndroid::init();
			return NULL;
		}
		if(!DKApp::active){ return NULL; }
		if(same(arry[0],"DKAndroid_exit")){
			DKINFO("DKAndroid::exit()\n");
			DKApp::Exit();
			return NULL;
		}
		if(same(arry[0],"DKAndroid_step")){
			DKApp::DoFrame();
			return NULL;
		}
		if(same(arry[0],"DKAndroid_loop")){
			DKApp::Loop();
			return NULL;
		}
		JavaData jdata;
		jdata.env = env;
		jdata.cls = cls;
		jdata.data = data;
		DKString rval;
		DKClass::CallFunc(arry[0], &jdata, &rval);
		if(rval.empty()){ return NULL; }
		DKINFO("CallCppFunction() rval = "+rval+"\n");
		jclass strClass = env->FindClass("java/lang/String"); 
		jmethodID ctorID = env->GetMethodID(strClass, "<init>", "([BLjava/lang/String;)V"); 
		jstring encoding = env->NewStringUTF("GBK"); 
		jbyteArray bytes = env->NewByteArray(strlen(rval.c_str())); 
		env->SetByteArrayRegion(bytes, 0, strlen(rval.c_str()), (jbyte*)rval.c_str()); 
		jstring str = (jstring)env->NewObject(strClass, ctorID, bytes, encoding);
		return str;//&& DKDEBUGRETURN(str);
		/*
		////   SDL  ////
		if(same(arry[0],"DKAndroid_onDropFile"))
			DKClass::CallFunc("DKAndroid_onDropFile", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onResize"))
			DKClass::CallFunc("DKAndroid_onResize", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onPadDown"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onPadDown", static_cast<void*>(&jdata)));
		if(same(arry[0],"DKAndroid_onPadUp"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onPadUp", static_cast<void*>(&jdata)));
		if(same(arry[0],"DKAndroid_onJoy"))
			DKClass::CallFunc("DKAndroid_onJoy", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onHat"))
			DKClass::CallFunc("DKAndroid_onHat", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_AddJoystick"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_AddJoystick", static_cast<void*>(&jdata)));
		if(same(arry[0],"DKAndroid_RemoveJoystick"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_RemoveJoystick", static_cast<void*>(&jdata)));
		if(same(arry[0],"onNativeSurfaceChanged"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onSurfaceChanged", static_cast<void*>(&jdata)));
		if(same(arry[0],"DKAndroid_onSurfaceDestroyed"))
			DKClass::CallFunc("DKAndroid_onSurfaceDestroyed", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onKeyDown"))
			DKClass::CallFunc("DKAndroid_onKeyDown", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onKeyUp"))
			DKClass::CallFunc("DKAndroid_onKeyUp", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onKeyboardFocusLost"))
			DKClass::CallFunc("DKAndroid_onKeyboardFocusLost", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onTouch"))
			DKClass::CallFunc("DKAndroid_onTouch", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onMouse"))
			DKClass::CallFunc("DKAndroid_onMouse", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onAccel"))
			DKClass::CallFunc("DKAndroid_onAccel", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onLowMemory"))
			DKClass::CallFunc("DKAndroid_onLowMemory", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onQuit"))
			DKClass::CallFunc("DKAndroid_onQuit", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onPause"))
			DKClass::CallFunc("DKAndroid_onPause", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onResume"))
			DKClass::CallFunc("DKAndroid_onResume", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onCommitText"))
			DKClass::CallFunc("DKAndroid_onCommitText", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onComposingText"))
			DKClass::CallFunc("DKAndroid_onComposingText", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onGetHint"))
			return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onGetHint", static_cast<void*>(&jdata)));
		////   OpenSceneGraph ////
		if(same(arry[0],"DKAndroid_onMousePress"))
			DKClass::CallFunc("DKAndroid_onMousePress", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onMouseRelease"))
			DKClass::CallFunc("DKAndroid_onMouseRelease", static_cast<void*>(&jdata));
		if(same(arry[0],"DKAndroid_onMouseMove"))
			DKClass::CallFunc("DKAndroid_onMouseMove", static_cast<void*>(&jdata));
		*/
	}
} //extern "C"


void DKAndroid::init(){
	DKDEBUGFUNC();
	if(!DKApp::active){ //if ! android context resume	
		//required for loading screen
		CallJavaFunction("copyAssets", ""); //copy ALL assets on startup
		//Copy assets required for loading screen
		//CallJavaFunction("copyAsset", "times-Bold.ttf");
		//CallJavaFunction("copyAsset", "times-BoldItalic.ttf");
		//CallJavaFunction("copyAsset", "times-Italic.ttf");
		//CallJavaFunction("copyAsset", "times-Roman.ttf");
		//CallJavaFunction("copyAsset", "index.html");
		//CallJavaFunction("copyAsset", "DKBody.css");
		//CallJavaFunction("copyAsset", "DKRocket.css");
		//CallJavaFunction("copyAsset", "DKLoading.html");
		//CallJavaFunction("copyAsset", "digitalknob.png");
		//CallJavaFunction("copyAsset", "settings.txt");
		//CallJavaFunction("copyAsset", "app.js"); //TODO: migrate to main.js filename
		// //CallJavaFunction("copyAsset", "main.js");
		//CallJavaFunction("copyAsset", "DKConsole.html");
		DKApp dkapp(NULL, NULL);
		#if DKAPP
		DKINFO("DKAPP defined\n");
		#endif
		DKINFO("Registered Classes\n");
		DKStringArray classes;
		DKClass::GetClassList(classes);
		for(int i=0; i<classes.size(); i++){
			DKINFO(classes[i]+"\n");
		}
		DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
		dkapp.Init();
		//Attempt to preload these
		DKClass::DKCreate("DKAssets");
		DKClass::DKCreate("DKDuktape");
	}
}

bool DKAndroid::GetMousePos(int& x, int& y){
	DKDEBUGFUNC(x, y);
	x = android_mouseX;
	y = android_mouseY;
	return true;
}

bool DKAndroid::GetScreenHeight(int& h) {
	DKDEBUGFUNC(h);
	// https://stackoverflow.com/a/12134363/688352
	/*
	#include <sys/ioctl.h>
	#include <linux/fb.h>
	struct fb_var_screeninfo fb_var;
	int fd = open("/dev/graphics/fb0", O_RDONLY);
	ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
	close(fd);
	*/
#if HAVE_sdl
	SDL_DisplayMode sdl_displayMode;
	SDL_GetCurrentDisplayMode(0, &sdl_displayMode);
	h = sdl_displayMode.h;
	return true;
#else
	return DKERROR("sdl unavailable! \n");
#endif
}

bool DKAndroid::GetScreenWidth(int& w){
	DKDEBUGFUNC(w);
	// https://stackoverflow.com/a/12134363/688352
	/*
	#include <sys/ioctl.h>
	#include <linux/fb.h>
	struct fb_var_screeninfo fb_var;
	int fd = open("/dev/graphics/fb0", O_RDONLY);
	ioctl(fd, FBIOGET_VSCREENINFO, &fb_var);
	close(fd);
	*/
#if HAVE_sdl
	SDL_DisplayMode sdl_displayMode;
	SDL_GetCurrentDisplayMode(0, &sdl_displayMode);
	w = sdl_displayMode.w;
	return true;
#else 
	return DKERROR("sdl unavailable! \n");
#endif
}

/*
void DKAndroid::ProcessEvent(Rocket::Core::Event& event){
	DKDEBUGFUNC(events);
	//Toggle Keyboard on text element click
	if(event.GetType() == "mousedown"){
		if(same(event.GetCurrentElement()->GetTagName().CString(), "textarea") ||
			same(event.GetCurrentElement()->GetTagName().CString(), "input")){
			CallJavaFunction("toggleKeyboard", "");
			return;
		}
	}
	//Hide Keyboard on input Enter
	if(event.GetType() == "keydown" && event.GetCurrentElement()->GetTagName() == "input"){
		int key = event.GetParameter<int>("key_identifier", 0);
		if(key == Rocket::Core::Input::KI_RETURN){ //Enter
			CallJavaFunction("toggleKeyboard", "");
			return;
		}	
	}
}
*/

#endif //ANDROID
