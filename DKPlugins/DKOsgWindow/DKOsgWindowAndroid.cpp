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
#include "DKOsgWindow/DKOsgWindowAndroid.h"
#include "DKOsgWindow/DKOsgWindow.h"


void DKOsgWindowAndroid::Init(){
	DKDEBUGFUNC();
	//DKClass::RegisterFunc("DKAndroid_onInitOSG", &DKOsgWindowAndroid::InitOSG, this);
	DKClass::RegisterFunc("DKAndroid_onDropFile", &DKOsgWindowAndroid::onDropFile, this);
	DKClass::RegisterFunc("DKAndroid_onResize", &DKOsgWindowAndroid::onResize, this);
	DKClass::RegisterFunc("DKAndroid_onPadDown", &DKOsgWindowAndroid::onPadDown, this);
	DKClass::RegisterFunc("DKAndroid_onPadUp", &DKOsgWindowAndroid::onPadUp, this);
	DKClass::RegisterFunc("DKAndroid_onJoy", &DKOsgWindowAndroid::onJoy, this);
	DKClass::RegisterFunc("DKAndroid_onHat", &DKOsgWindowAndroid::onHat, this);
	DKClass::RegisterFunc("DKAndroid_onAddJoystick", &DKOsgWindowAndroid::onAddJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onRemoveJoystick", &DKOsgWindowAndroid::onRemoveJoystick, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceChanged", &DKOsgWindowAndroid::onSurfaceChanged, this);
	DKClass::RegisterFunc("DKAndroid_onSurfaceDestroyed", &DKOsgWindowAndroid::onSurfaceDestroyed, this);
	DKClass::RegisterFunc("DKAndroid_onKeyDown", &DKOsgWindowAndroid::onKeyDown, this);
	DKClass::RegisterFunc("DKAndroid_onKeyUp", &DKOsgWindowAndroid::onKeyUp, this);
	DKClass::RegisterFunc("DKAndroid_onKeyboardFocusLost", &DKOsgWindowAndroid::onKeyboardFocusLost, this);
	DKClass::RegisterFunc("DKAndroid_onTouch", &DKOsgWindowAndroid::onTouch, this);
	DKClass::RegisterFunc("DKAndroid_onMouse", &DKOsgWindowAndroid::onMouse, this);
	DKClass::RegisterFunc("DKAndroid_onAccel", &DKOsgWindowAndroid::onAccel, this);
	DKClass::RegisterFunc("DKAndroid_onLowMemory", &DKOsgWindowAndroid::onLowMemory, this);
	DKClass::RegisterFunc("DKAndroid_onQuit", &DKOsgWindowAndroid::onQuit, this);
	DKClass::RegisterFunc("DKAndroid_onPause", &DKOsgWindowAndroid::onPause, this);
	DKClass::RegisterFunc("DKAndroid_onResume", &DKOsgWindowAndroid::onResume, this);
	DKClass::RegisterFunc("DKAndroid_onCommitText", &DKOsgWindowAndroid::onCommitText, this);
	DKClass::RegisterFunc("DKAndroid_onSetComposingText", &DKOsgWindowAndroid::onSetComposingText, this);
	DKClass::RegisterFunc("DKAndroid_onGetHint", &DKOsgWindowAndroid::onGetHint, this);
	DKClass::RegisterFunc("DKAndroid_onMousePress", &DKOsgWindowAndroid::onMousePress, this);
	DKClass::RegisterFunc("DKAndroid_onMouseRelease", &DKOsgWindowAndroid::onMouseRelease, this);
	DKClass::RegisterFunc("DKAndroid_onMouseMove", &DKOsgWindowAndroid::onMouseMove, this);
}

void DKOsgWindowAndroid::End(){
	DKDEBUGFUNC();
}
	
/*
void* DKOsgWindowAndroid::InitOSG(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}
*/

void* DKOsgWindowAndroid::onDropFile(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onResize(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOsgWindow::Get("")->view->getEventQueue()->windowResize(0,0,toInt(arry[1]),toInt(arry[2]));
	return NULL;
}

void* DKOsgWindowAndroid::onPadDown(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onPadUp(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onJoy(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onHat(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onAddJoystick(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onRemoveJoystick(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onSurfaceChanged(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onSurfaceDestroyed(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onKeyDown(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvent::SendEvent("GLOBAL", "keydown", arry[1]);
	}
	else{
		DKOsgWindow::Get("")->view->getEventQueue()->keyPress(toInt(arry[1]));
	}
	return NULL;
}

void* DKOsgWindowAndroid::onKeyUp(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	if(toInt(arry[1]) == 4){ //ANDROID_BACK
		DKEvent::SendEvent("GLOBAL", "keyup", arry[1]);
	}
	else{
		DKOsgWindow::Get("")->view->getEventQueue()->keyRelease(toInt(arry[1]));
	}
	return NULL;
}

void* DKOsgWindowAndroid::onKeyboardFocusLost(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onTouch(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onMouse(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onAccel(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onLowMemory(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onQuit(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onPause(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onResume(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onCommitText(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onSetComposingText(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onGetHint(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOsgWindowAndroid::onMousePress(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOsgWindow::Get("")->view->getEventQueue()->mouseButtonPress(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

void* DKOsgWindowAndroid::onMouseRelease(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOsgWindow::Get("")->view->getEventQueue()->mouseButtonRelease(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

void* DKOsgWindowAndroid::onMouseMove(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOsgWindow::Get("")->view->getEventQueue()->mouseMotion(toInt(arry[1]), toInt(arry[2]));
	return NULL;
}


#endif //ANDROID
