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
#pragma once
#ifndef DKOSGWindowAndroid_H
#define DKOSGWindowAndroid_H

WARNING_DISABLE
#include <jni.h>
WARNING_ENABLE


class DKOSGWindowAndroid : public DKObjectT<DKOSGWindowAndroid>
{
public:
	void Init();
	void End();
	
	//void* InitOSG(void* data);
	void* onDropFile(void* data);
	void* onResize(void* data);
	void* onPadDown(void* data);
	void* onPadUp(void* data);
	void* onJoy(void* data);
	void* onHat(void* data);
	void* onAddJoystick(void* data);
	void* onRemoveJoystick(void* data);
	void* onSurfaceChanged(void* data);
	void* onSurfaceDestroyed(void* data);
	void* onKeyDown(void* data);
	void* onKeyUp(void* data);
	void* onKeyboardFocusLost(void* data);
	void* onTouch(void* data);
	void* onMouse(void* data);
	void* onAccel(void* data);
	void* onLowMemory(void* data);
	void* onQuit(void* data);
	void* onPause(void* data);
	void* onResume(void* data);
	void* onCommitText(void* data);
	void* onSetComposingText(void* data);
	void* onGetHint(void* data);
	void* onMousePress(void* data);
	void* onMouseRelease(void* data);
	void* onMouseMove(void* data);
};
	
REGISTER_OBJECT(DKOSGWindowAndroid, true)
#endif //DKOSGWindowAndroid_H
#endif //ANDROID
