#ifdef ANDROID
#include "DK/stdafx.h"
#include "DKOSGWindowAndroid.h"
#include "DKOSGWindow.h"

///////////////////////////////
void DKOSGWindowAndroid::Init()
{
	//DKClass::RegisterFunc("DKAndroid_onInitOSG", &DKOSGWindowAndroid::InitOSG, this);
	DKClass::RegisterFunc("DKAndroid_onDropFile", &DKOSGWindowAndroid::onDropFile, this);
	DKClass::RegisterFunc("DKAndroid_onResize", &DKOSGWindowAndroid::onResize, this);
	DKClass::RegisterFunc("DKAndroid_onPadDown", &DKOSGWindowAndroid::onPadDown, this);
	DKClass::RegisterFunc("DKAndroid_onPadUp", &DKOSGWindowAndroid::onPadUp, this);
	DKClass::RegisterFunc("DKAndroid_onJoy", &DKOSGWindowAndroid::onJoy, this);
	DKClass::RegisterFunc("DKAndroid_onHat", &DKOSGWindowAndroid::onHat, this);
	DKClass::RegisterFunc("DKAndroid_onAddJoystick", &DKOSGWindowAndroid::onAddJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onRemoveJoystick", &DKOSGWindowAndroid::onRemoveJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceChanged", &DKOSGWindowAndroid::onSurfaceChanged, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceDestroyed", &DKOSGWindowAndroid::onSurfaceDestroyed, this);
	DKClass::RegisterFunc("DKAndroid_onKeyDown", &DKOSGWindowAndroid::onKeyDown, this);
	DKClass::RegisterFunc("DKAndroid_onKeyUp", &DKOSGWindowAndroid::onKeyUp, this);
	DKClass::RegisterFunc("DKAndroid_onKeyboardFocusLost", &DKOSGWindowAndroid::onKeyboardFocusLost, this);
	DKClass::RegisterFunc("DKAndroid_onTouch", &DKOSGWindowAndroid::onTouch, this);
	DKClass::RegisterFunc("DKAndroid_onMouse", &DKOSGWindowAndroid::onMouse, this);
	DKClass::RegisterFunc("DKAndroid_onAccel", &DKOSGWindowAndroid::onAccel, this);
	DKClass::RegisterFunc("DKAndroid_onLowMemory", &DKOSGWindowAndroid::onLowMemory, this);
	DKClass::RegisterFunc("DKAndroid_onQuit", &DKOSGWindowAndroid::onQuit, this);
	DKClass::RegisterFunc("DKAndroid_onPause", &DKOSGWindowAndroid::onPause, this);
	DKClass::RegisterFunc("DKAndroid_onResume", &DKOSGWindowAndroid::onResume, this);
	DKClass::RegisterFunc("DKAndroid_onCommitText", &DKOSGWindowAndroid::onCommitText, this);
	DKClass::RegisterFunc("DKAndroid_onSetComposingText", &DKOSGWindowAndroid::onSetComposingText, this);
	DKClass::RegisterFunc("DKAndroid_onGetHint", &DKOSGWindowAndroid::onGetHint, this);
	DKClass::RegisterFunc("DKAndroid_onMousePress", &DKOSGWindowAndroid::onMousePress, this);
	DKClass::RegisterFunc("DKAndroid_onMouseRelease", &DKOSGWindowAndroid::onMouseRelease, this);
	DKClass::RegisterFunc("DKAndroid_onMouseMove", &DKOSGWindowAndroid::onMouseMove, this);
}

//////////////////////////////
void DKOSGWindowAndroid::End()
{
	
}
	
/*
/////////////////////////////////////////////
void* DKOSGWindowAndroid::InitOSG(void* data)
{
	DKLog("DKOSGWindowAndroid::InitOSG()\n", DKDEBUG);
	
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}
*/

////////////////////////////////////////////////
void* DKOSGWindowAndroid::onDropFile(void* data)
{
	DKLog("DKOSGWindowAndroid::onDropFile()\n", DKDEBUG);
	
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////
void* DKOSGWindowAndroid::onResize(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onResize("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	
	DKOSGWindow::Get("")->view->getEventQueue()->windowResize(0,0,toInt(arry[1]),toInt(arry[2]));
	return NULL;
}

///////////////////////////////////////////////
void* DKOSGWindowAndroid::onPadDown(void* data)
{
	DKLog("DKOSGWindowAndroid::onPadDown()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onPadUp(void* data)
{
	DKLog("DKOSGWindowAndroid::onPadUp()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

///////////////////////////////////////////
void* DKOSGWindowAndroid::onJoy(void* data)
{
	DKLog("DKOSGWindowAndroid::onJoy()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

///////////////////////////////////////////
void* DKOSGWindowAndroid::onHat(void* data)
{
	DKLog("DKOSGWindowAndroid::onHat()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

///////////////////////////////////////////////////
void* DKOSGWindowAndroid::onAddJoystick(void* data)
{
	DKLog("DKOSGWindowAndroid::onAddJoystick()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onRemoveJoystick(void* data)
{
	DKLog("DKOSGWindowAndroid::omRemoveJoystick()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onSurfaceChanged(void* data)
{
	DKLog("DKOSGWindowAndroid::onSurfaceChanged()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

////////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onSurfaceDestroyed(void* data)
{
	DKLog("DKOSGWindowAndroid::onSurfaceDestroyed()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

///////////////////////////////////////////////
void* DKOSGWindowAndroid::onKeyDown(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onKeyDown("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvent::SendEvent("GLOBAL", "keydown", arry[1]);
	}
	else{
		DKOSGWindow::Get("")->view->getEventQueue()->keyPress(toInt(arry[1]));
	}
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onKeyUp(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onKeyUp("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvent::SendEvent("GLOBAL", "keyup", arry[1]);
	}
	else{
		DKOSGWindow::Get("")->view->getEventQueue()->keyRelease(toInt(arry[1]));
	}
	return NULL;
}

/////////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onKeyboardFocusLost(void* data)
{
	DKLog("DKOSGWindowAndroid::onNativeKeyboardFocusLost()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onTouch(void* data)
{
	DKLog("DKOSGWindowAndroid::onTouch()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onMouse(void* data)
{
	DKLog("DKOSGWindowAndroid::onMouse()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onAccel(void* data)
{
	DKLog("DKOSGWindowAndroid::onAccel()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////////
void* DKOSGWindowAndroid::onLowMemory(void* data)
{
	DKLog("DKOSGWindowAndroid::onLowMemory()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

////////////////////////////////////////////
void* DKOSGWindowAndroid::onQuit(void* data)
{
	DKLog("DKOSGWindowAndroid::onQuit()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

/////////////////////////////////////////////
void* DKOSGWindowAndroid::onPause(void* data)
{
	DKLog("DKOSGWindowAndroid::onPause()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////
void* DKOSGWindowAndroid::onResume(void* data)
{
	DKLog("DKOSGWindowAndroid::onResume()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////////
void* DKOSGWindowAndroid::onCommitText(void* data)
{
	DKLog("DKOSGWindowAndroid::onCommitText()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

////////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onSetComposingText(void* data)
{
	DKLog("DKOSGWindowAndroid::onSetComposingText()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

///////////////////////////////////////////////
void* DKOSGWindowAndroid::onGetHint(void* data)
{
	DKLog("DKOSGWindowAndroid::onGetHint()\n", DKDEBUG);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

//////////////////////////////////////////////////
void* DKOSGWindowAndroid::onMousePress(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onMousePress("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseButtonPress(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

////////////////////////////////////////////////////
void* DKOSGWindowAndroid::onMouseRelease(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onMouseRelease("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseButtonRelease(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

/////////////////////////////////////////////////
void* DKOSGWindowAndroid::onMouseMove(void* data)
{
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKLog("DKOSGWindowAndroid::onMouseMove("+DKString(_data)+")\n", DKDEBUG);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseMotion(toInt(arry[1]), toInt(arry[2]));
	return NULL;
}



#endif //ANDROID
