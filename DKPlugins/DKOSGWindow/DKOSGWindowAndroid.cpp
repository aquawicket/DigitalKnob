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
#include "DKOSGWindow/DKOSGWindowAndroid.h"
#include "DKOSGWindow/DKOSGWindow.h"


void DKOSGWindowAndroid::Init(){
	DKDEBUGFUNC();
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

void DKOSGWindowAndroid::End(){
	DKDEBUGFUNC();
}
	
/*
void* DKOSGWindowAndroid::InitOSG(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}
*/

void* DKOSGWindowAndroid::onDropFile(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onResize(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->windowResize(0,0,toInt(arry[1]),toInt(arry[2]));
	return NULL;
}

void* DKOSGWindowAndroid::onPadDown(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onPadUp(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onJoy(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onHat(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onAddJoystick(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onRemoveJoystick(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onSurfaceChanged(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onSurfaceDestroyed(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onKeyDown(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
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

void* DKOSGWindowAndroid::onKeyUp(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
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

void* DKOSGWindowAndroid::onKeyboardFocusLost(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onTouch(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onMouse(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onAccel(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onLowMemory(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onQuit(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onPause(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onResume(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onCommitText(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onSetComposingText(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onGetHint(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	return NULL;
}

void* DKOSGWindowAndroid::onMousePress(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseButtonPress(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

void* DKOSGWindowAndroid::onMouseRelease(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseButtonRelease(toInt(arry[1]), toInt(arry[2]), toInt(arry[3]));
	return NULL;
}

void* DKOSGWindowAndroid::onMouseMove(void* data){
	DKDEBUGFUNC(data);
	JavaData jd = *static_cast<JavaData*>(data);
	const char* _data = jd.env->GetStringUTFChars(jd.data,JNI_FALSE);
	DKStringArray arry;
	toStringArray(arry, _data, ",");
	DKOSGWindow::Get("")->view->getEventQueue()->mouseMotion(toInt(arry[1]), toInt(arry[2]));
	return NULL;
}


#endif //ANDROID
