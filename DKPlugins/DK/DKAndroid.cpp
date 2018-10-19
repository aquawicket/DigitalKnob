#include "DK/stdafx.h"

#ifdef ANDROID
#include "DK/DKAndroid.h"
#include "DK/DKApp.h"
#include "DK/DKClass.h"

unsigned int DKAndroid::android_width = 800;
unsigned int DKAndroid::android_height = 480;
unsigned int DKAndroid::android_mouseX = 0;
unsigned int DKAndroid::android_mouseY = 0;

///////////
extern "C"
{

static JavaVM* thejvm = 0;
static jobject theobj = 0;

/////////////////////////////////////////////////////
JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved)
{
	DKDebug(vm, reserved);
	thejvm = vm;
    return JNI_VERSION_1_6;
}

////////////////////////////////////////////
void initJNIBridge(JNIEnv* env, jobject obj)
{
	DKDebug(env, obj);
	theobj = env->NewGlobalRef(obj);
}

////////////////////////////////////////////
void exitJNIBridge(JNIEnv* env, jobject obj)
{
	DKDebug(env, obj);
	env->DeleteGlobalRef(theobj);
}

//FIXME: this needs to fail without crashing
//////////////////////////////////////////////////////////////////
void CallJavaFunction(const DKString& name, const DKString& param)
{
	DKDebug(name, param);
	JNIEnv* env;
	bool attached = false;
	switch(thejvm->GetEnv((void**)&env, JNI_VERSION_1_6)){
		case JNI_OK:
			break;
		case JNI_EDETACHED:
			if (thejvm->AttachCurrentThread(&env, NULL)!=0){
				DKLog("failed to attech jvm \n", DKERROR);
			 }
			attached = true;
			break;
		case JNI_EVERSION:
			DKLog("jni version not supported \n", DKERROR);
	}

	jclass cls = env->GetObjectClass(theobj);
	if (!cls) {
		DKLog("Could not get cls \n", DKERROR);
        return;
    }

	//Call void function
	if(param.empty()){
		jmethodID method = env->GetMethodID(cls, name.c_str(), "()V");
		if(!method){
			DKLog("Could not get method \n", DKERROR);
			return;
		}

		env->CallVoidMethod(theobj, method);
	    return;
	}

	//Call function with string parameter
	jmethodID method = env->GetMethodID(cls, name.c_str(), "(Ljava/lang/String;)V");
	if (!method) {
		DKLog("Could not get method \n", DKERROR);
        return;
    }

	jstring jstr = env->NewStringUTF(param.c_str());
	env->CallVoidMethod(theobj, method, jstr);
    return;
}

////////////////////////////////////////////////////
void initSDL(JNIEnv* env, jclass cls, jobject array)
{
	DKDebug(env, cls, array);
	JavaData jdata;
	jdata.env = env;
	jdata.cls = cls;
	jdata.array = array;
	DKClass::DKCreate("DKSDLWindowAndroid");
	DKClass::CallFunc("DKAndroid_onInitSDL", &jdata, NULL);
}

//////////////////////////////////////////////////////////////
jstring CallCppFunction(JNIEnv* env, jclass cls, jstring data)
{
	DKDebug(env, cls, data);
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
		DKLog("DKAndroid::exit()\n");
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
	DKLog("CallCppFunction() rval = "+rval+"\n");
	
	jclass strClass = env->FindClass("java/lang/String"); 
	jmethodID ctorID = env->GetMethodID(strClass, "<init>", "([BLjava/lang/String;)V"); 
	jstring encoding = env->NewStringUTF("GBK"); 

	jbyteArray bytes = env->NewByteArray(strlen(rval.c_str())); 
	env->SetByteArrayRegion(bytes, 0, strlen(rval.c_str()), (jbyte*)rval.c_str()); 
	jstring str = (jstring)env->NewObject(strClass, ctorID, bytes, encoding);
	return str;

	
	/*
	////////   SDL  /////////////////////////////////
	if(same(arry[0],"DKAndroid_onDropFile")){
		DKClass::CallFunc("DKAndroid_onDropFile", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onResize")){
		DKClass::CallFunc("DKAndroid_onResize", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onPadDown")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onPadDown", static_cast<void*>(&jdata)));
	}
	if(same(arry[0],"DKAndroid_onPadUp")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onPadUp", static_cast<void*>(&jdata)));
	}
	if(same(arry[0],"DKAndroid_onJoy")){
		DKClass::CallFunc("DKAndroid_onJoy", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onHat")){
		DKClass::CallFunc("DKAndroid_onHat", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_AddJoystick")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_AddJoystick", static_cast<void*>(&jdata)));
	}
	if(same(arry[0],"DKAndroid_RemoveJoystick")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_RemoveJoystick", static_cast<void*>(&jdata)));
	}
	if(same(arry[0],"onNativeSurfaceChanged")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onSurfaceChanged", static_cast<void*>(&jdata)));
	}
	if(same(arry[0],"DKAndroid_onSurfaceDestroyed")){
		DKClass::CallFunc("DKAndroid_onSurfaceDestroyed", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onKeyDown")){
		DKClass::CallFunc("DKAndroid_onKeyDown", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onKeyUp")){
		DKClass::CallFunc("DKAndroid_onKeyUp", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onKeyboardFocusLost")){
		DKClass::CallFunc("DKAndroid_onKeyboardFocusLost", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onTouch")){
		DKClass::CallFunc("DKAndroid_onTouch", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onMouse")){
		DKClass::CallFunc("DKAndroid_onMouse", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onAccel")){
		DKClass::CallFunc("DKAndroid_onAccel", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onLowMemory")){
		DKClass::CallFunc("DKAndroid_onLowMemory", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onQuit")){
		DKClass::CallFunc("DKAndroid_onQuit", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onPause")){
		DKClass::CallFunc("DKAndroid_onPause", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onResume")){
		DKClass::CallFunc("DKAndroid_onResume", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onCommitText")){
		DKClass::CallFunc("DKAndroid_onCommitText", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onComposingText")){
		DKClass::CallFunc("DKAndroid_onComposingText", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onGetHint")){
		return static_cast<jstring>(DKClass::CallFunc("DKAndroid_onGetHint", static_cast<void*>(&jdata)));
	}

	///////   OpenSceneGraph ////////////////
	if(same(arry[0],"DKAndroid_onMousePress")){
		DKClass::CallFunc("DKAndroid_onMousePress", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onMouseRelease")){
		DKClass::CallFunc("DKAndroid_onMouseRelease", static_cast<void*>(&jdata));
	}
	if(same(arry[0],"DKAndroid_onMouseMove")){
		DKClass::CallFunc("DKAndroid_onMouseMove", static_cast<void*>(&jdata));
	}
	*/
}

} //extern "C"

//////////////////////
void DKAndroid::init()
{
	DKDebug();
	
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
		//CallJavaFunction("copyAsset", "app.js");
		//CallJavaFunction("copyAsset", "DKConsole.html");

		DKApp dkapp;

		#ifdef DKAPP
		DKLog("DKAPP defined \n");
		#endif
		
		DKLog("Registered Classes \n");
		DKStringArray classes;
		DKClass::GetClassList(classes);
		for(int i=0; i<classes.size(); i++){
			DKLog(classes[i]+"\n");
		}

		DKObject* app = DKClass::DKCreate("App"); //App.h/App.cpp (user code)
		dkapp.Init();
		
		//Attempt to preload these
		DKClass::DKCreate("DKAssets");
		DKClass::DKCreate("DKDuktape");
	}
}

///////////////////////////////////////////
bool DKAndroid::GetMousePos(int& x, int& y)
{
	DKDebug(x, y);
	x = android_mouseX;
	y = android_mouseY;
	return true;
}

/*
////////////////////////////////////////////////////////
void DKAndroid::ProcessEvent(Rocket::Core::Event& event)
{
	DKDebug(events);
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